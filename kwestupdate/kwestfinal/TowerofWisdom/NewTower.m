//
//  NewTower.m
//  kwest
//
//  Created by Aitl on 1/23/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "NewTower.h"
#import "Menu.h"
#import "QuestScene.h"
//#import "ResolutionConstant.h"
#import "TutorialView.h"
#import "BasePopUpView.h"
#import "Utility.h"
#import "Chartboost.h"
static NSString * const UIGestureRecognizerNodeKey = @"UIGestureRecognizerNodeKey";

@implementation NewTower
+(CCScene *) scene    {
        // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
        
        // 'layer' is an autorelease object.
    NewTower *layer = [NewTower node];
        
        // add layer as a child to scene
    [scene addChild: layer];
        
        // return the scene
    return scene;
}

-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"Tower"];
//        self.enabled = YES;
//        zoomCount = 0;
        gamedata = [GameData GameDataManager];
        [self createMainView];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
            [self createTutorialBaseView];
        }
        if(![gamedata returnpremium]){
            if ([[GameData GameDataManager] returnknop]>100)
            [[Chartboost sharedChartboost]showInterstitial];
        }
        if ( [[NSUserDefaults standardUserDefaults] boolForKey:@"revAskAllow"])
            NSLog(@"Asking ALlowed");
      if ([gamedata returnknop]>320 && [[NSUserDefaults standardUserDefaults] boolForKey:@"revAskAllow"]){
          UIAlertView *rateAlertView = [[UIAlertView alloc]initWithTitle:@"Rate KWEST?" message:@"Because you are an esteemed Scholar now, We would be honored to have you rate KWEST on the appstore. It should take less than a minute. We appreciate your support, O Wise One." delegate:self cancelButtonTitle:@"Not Now - Too Busy" otherButtonTitles:@"Rate KWEST", @"Already Done", @"No, and Don't Ask Again", nil];
          
          //UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Pixelated" message:@"Would you like to Download 'Pixelated'? Pixelated is a simple but challenging strategy game, that defies you to conquer the board as fast as possible with the least moves." delegate:self cancelButtonTitle:@"No, Can't Do It" otherButtonTitles:@"OK - Seems Easy", nil];
          rateAlertView.tag=2;
          //app_link=@"http://bit.ly/PxlT1";
          [rateAlertView show];
          [rateAlertView release];

      }
        
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        if([[SimpleAudioEngine sharedEngine]willPlayBackgroundMusic]){
            [[SimpleAudioEngine  sharedEngine]playBackgroundMusic:@"Tower.mp3" loop:NO];
        }
}

-(void)onExit{
    [super onExit];

}

-(void)createMainView{
    [self enableTouch];
    level=[gamedata returnlevel];
    isCleared = FALSE;
    towerBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];//[[UIScreen mainScreen] applicationFrame]];
    towerBaseView.backgroundColor = [UIColor redColor];
    float deviceOS = [[[UIDevice currentDevice] systemVersion]floatValue];
    
    [[[CCDirector sharedDirector]view ]addSubview:towerBaseView];
   towerView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    if(deviceOS >= 7){
        towerView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);
    }
    towerView.backgroundColor = [UIColor blackColor];
    towerView.delegate = self;
    image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Toweofwisdombg"]];
    
    image.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);
//    image.backgroundColor = [UIColor redColor];
    towerView.contentSize = CGSizeMake(image.frame.size.width, image.frame.size.height*2);//image.frame.size;
    [towerView addSubview:image];
    
    towerView.minimumZoomScale =towerView.frame.size.width / image.frame.size.width;//image.frame.size.width;
    towerView.maximumZoomScale = 2.0;
    [towerView setZoomScale:towerView.minimumZoomScale];
    
    [towerBaseView addSubview:towerView];
    int curLevelKnopThreshold,nexLevelKnopThreshold;
    if(level<=0){
        NSString *str = @"You still can't see the tower. Come back after you get at least 5 KNOPs.";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=1;
        [alert show];
        [alert release];
//        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 300, 130)];
//        lbl.numberOfLines =2 ;
//        lbl.text = str;
//        [image addSubview:lbl];
        towerView.maximumZoomScale =1.0;
    }
    else{
        [image setUserInteractionEnabled:YES];
        image.userInteractionEnabled = YES;
        Myquslist *qq= [[Myquslist alloc]init];
       // if(level<10){
        if (level >=10){
            level = 9;
        }
        curLevelKnopThreshold = [qq getKnopThreshold:level];
        nexLevelKnopThreshold = [qq getKnopThreshold:level+1];
        curKNOP = (int)[gamedata returnknop];
        nextKNOP = nexLevelKnopThreshold;
        [qq release];
       // }
      
        towerButtonArray = [[NSMutableArray alloc]initWithCapacity:10];
        for(int i=1 ; i<=[gamedata returnlevel];i++){
            UIImage *towerImage = [UIImage imageNamed:[NSString stringWithFormat:@"level%d",i]];
            UIButton *levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            switch (i) {
                case 1:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                     levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height)-30, towerImage.size.width, towerImage.size.height);
//                    }
                    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height), towerImage.size.width, towerImage.size.height);
                    }

                    break;
                case 2:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-50), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-50)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-100), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                case 3:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-87), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-87)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-174), towerImage.size.width, towerImage.size.height);
                    }

                    break;
                case 4:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-115), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-115)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-230), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                case 5:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-150), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-150)-70, towerImage.size.width, towerImage.size.height);
//                    }
                    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                    levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-300), towerImage.size.width, towerImage.size.height);
                    }

                    break;
                case 6:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-180), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-180)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-360), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                case 7:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-210), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-210)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-420), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                case 8:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-245), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-245)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-490), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                case 9:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-270), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-270)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-540), towerImage.size.width, towerImage.size.height);
                    }

                    break;
                case 10:
                    levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-330), towerImage.size.width, towerImage.size.height);
//                    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
//                        levelButton.frame = CGRectMake((DeviceWidth-towerImage.size.width)/2, (DeviceHeight-towerImage.size.height-330)-70, towerImage.size.width, towerImage.size.height);
//                    }
                     if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
                        levelButton.frame = CGRectMake(((DeviceWidth-towerImage.size.width)/2), (DeviceHeight-towerImage.size.height-660), towerImage.size.width, towerImage.size.height);
                    }
                    break;
                    //
                    //
                    
                    
                default:
                    break;
            }
            levelButton.tag = i;
           // [levelButton setBackgroundColor:[UIColor redColor]];
            [levelButton setBackgroundImage:towerImage forState:UIControlStateNormal];
        //    [levelButton setBackgroundImage:towerImage forState:UIControlStateSelected ];
            [levelButton addTarget:self action:@selector(showLevelInfo:) forControlEvents:UIControlEventTouchUpInside];
            [image addSubview:levelButton];
            
            [towerButtonArray addObject:levelButton];
            [levelButton release];
        }
        
    }
    UIImage *questButtonImage = [UIImage imageNamed:@"questbtn"];
    questButton = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth/32, DeviceHeight/48, questButtonImage.size.width, questButtonImage.size.height )];
    [questButton setBackgroundImage:questButtonImage forState:UIControlStateNormal];
    [questButton setBackgroundImage:[UIImage imageNamed:@"questbtnpressed"] forState:UIControlEventTouchUpInside];
    [questButton addTarget:self action:@selector(goToQuest) forControlEvents:UIControlEventTouchUpInside];
    // [scroll release];
    [towerBaseView addSubview:questButton];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"BackButton"];
    backButton = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth/160, DeviceHeight-backButtonImage.size.height, backButtonImage.size.width, backButtonImage.size.height )];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    // [scroll release];
    [towerBaseView addSubview:backButton];
    UIImage *progressBgImage = [UIImage imageNamed:@"progressbg@2x"];
    UIView *progressTabView = [[UIView alloc]initWithFrame:CGRectMake(DeviceWidth-(progressBgImage.size.width), DeviceHeight/8, progressBgImage.size.width, progressBgImage.size.height+DeviceHeight/5)];
    progressTabView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    [progressTabView addGestureRecognizer:tap];
    [towerBaseView addSubview:progressTabView];
    
    progressBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth-progressBgImage.size.width, DeviceHeight/4.2, progressBgImage.size.width, progressBgImage.size.height)];
    progressBgImageView.image = progressBgImage;
    progressBgImageView.userInteractionEnabled = YES;
    

    [towerBaseView addSubview:progressBgImageView];
    UIImage *fill = [UIImage imageNamed:@"progressbar"];
    NSLog(@"%f %f",fill.size.width,fill.size.height);
    progressView = [[JEProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/2.46, progressBgImageView.frame.size.width, fill.size.height);
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    [progressView addGestureRecognizer:tap2];
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
        progressView.frame = CGRectMake(progressBgImageView.frame.origin.x-5, DeviceHeight/3.07, progressBgImageView.frame.size.width+10, 2.0f);
    }
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        progressView.frame = CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/3.3, progressBgImageView.frame.size.width, fill.size.height);
    }
    if([gamedata returnlevel]<10){
        [progressView setProgress:1.0f];
    }
    else if([gamedata returnlevel]>=10){
        [progressView setProgress:100.0f];
    }
    [progressView setTrackImage:[UIImage imageNamed:@"track@2x"]];
    [progressView setProgressImage:fill];
    
    [towerBaseView  addSubview:progressView];
    CGAffineTransform transform = progressView.transform ;//CGAffineTransformMakeScale(1.0f, 6.0f);
//    transform = CGAffineTransformRotate(transform,  M_PI * -0.5);
//    if([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0f){
//        transform = CGAffineTransformScale(transform, 1.2f, 4.5f);    }
    transform =CGAffineTransformMakeRotation( M_PI * -0.5 );
   // transform =CGAffineTransformMakeScale(1.0f, 6.0f);
    
    //progressView.transform= CGAffineTransformMakeRotation( M_PI * -0.5 );
    progressView.transform = transform;
    curLevel =  [[UILabel alloc]initWithFrame:CGRectMake(progressBgImageView.frame.origin.x+20, DeviceHeight/1.66, 70, 30)];
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        curLevel.frame = CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/2.4, 70, 30);
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        curLevel.frame = CGRectMake(progressBgImageView.frame.origin.x+20, DeviceHeight/2.4, 70, 30);
    }
    curLevel.text = [NSString stringWithFormat:@"E %d",level];
    curLevel.textColor = [UIColor colorWithRed:191 green:191 blue:191 alpha:255];
    curLevel.font = [UIFont boldSystemFontOfSize:20];
    curLevel.backgroundColor = [UIColor clearColor];
    [towerBaseView addSubview:curLevel];
    
    curLevelKnop =  [[UILabel alloc]initWithFrame:CGRectMake(progressBgImageView.frame.origin.x+20, DeviceHeight/1.54, 70, 30)];
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        curLevelKnop.frame = CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/2.2, 70, 30);
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        curLevelKnop.frame = CGRectMake(progressBgImageView.frame.origin.x+20, DeviceHeight/2.2, 70, 30);
    }
    if(level<10)
        curLevelKnop.text = [NSString stringWithFormat:@"(%d)",curLevelKnopThreshold];
    curLevelKnop.textColor = [UIColor colorWithRed:191 green:191 blue:191 alpha:255];
    curLevelKnop.font = [UIFont systemFontOfSize:14];
    curLevelKnop.backgroundColor = [UIColor clearColor];
    [towerBaseView addSubview:curLevelKnop];
    
    nextLevel =  [[UILabel alloc]initWithFrame:CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/8, 70, 30)];
    
    nextLevel.text = [NSString stringWithFormat:@"E %d",level+1];
    nextLevel.font = [UIFont boldSystemFontOfSize:20];
    nextLevel.backgroundColor = [UIColor clearColor];
    [nextLevel setTextColor:[UIColor colorWithRed:228.0/255.0 green:186.0/255.0 blue:10.0/255.0 alpha:1.0]];
    
    [towerBaseView addSubview:nextLevel];
    
    nextLevelKnop =  [[UILabel alloc]initWithFrame:CGRectMake(progressBgImageView.frame.origin.x, DeviceHeight/5.64, 70, 30)];
    nextLevelKnop.text = [NSString stringWithFormat:@"(%d)",nexLevelKnopThreshold];
    nextLevelKnop.font = [UIFont systemFontOfSize:14];
    nextLevelKnop.backgroundColor = [UIColor clearColor];
    [nextLevelKnop setTextColor:[UIColor colorWithRed:228.0/255.0 green:186.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [towerBaseView addSubview:nextLevelKnop];
    
 //   UIViewController *ctrl = [[UIViewController alloc] init];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
    tempView.backgroundColor = [UIColor redColor];
    [[[CCDirector sharedDirector]view ]addSubview:tempView];
    [UIView transitionFromView:tempView
                        toView:towerBaseView
                      duration:2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:nil];
    
    //[self.navigationController pushViewController:ctrl animated:NO];
        //Animation
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.6];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:towerView cache:YES];
//        [UIView commitAnimations];
        
//    }completion:^(BOOL finished) {
//        if(finished){
//            //Completed
//        }
//    }];
////

}

-(void)handleTap{
    NSString *wisdomString = @"Your Days_To_Wisdom:";
    if([gamedata daysToWisdom]>0){
        wisdomString = [NSString stringWithFormat:@"%@ %d",wisdomString,[gamedata daysToWisdom]];
    }
    else{
        wisdomString = [NSString stringWithFormat:@"%@ Not Yet",wisdomString];
    }
    NSString *alertMessage;
    if([gamedata returnlevel]<10){
        alertMessage = [NSString stringWithFormat:@"You have %d KNOwledge Points, and you will reach the next era of Wisdom at %d KNOPs.\nYou have played KWEST for %d Days.\nYour Growth Rate is %.2f KNOPs Per Hour.\n%@",curKNOP,nextKNOP,[gamedata numberOfDaysPlayed],[gamedata growthRate],wisdomString];
    }
    else{
        alertMessage = [NSString stringWithFormat:@"You have %d KNOwledge Points. You are in the 10th Era of Wisdom.\nYou have played KWEST for %d Days.\nYour Growth Rate is %.2f KNOPs Per Hour.\n%@",curKNOP,[gamedata numberOfDaysPlayed],[gamedata growthRate],wisdomString];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alert.tag==3;
    [alert show];
    [alert release];
}

-(void)createTutorialBaseView{
    [self disableTouch];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"TwrWsdmtxt"];
    UIImage *questButtonImage = [UIImage imageNamed:@"Quests"];
    
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
 //   tutorialView.backgroundColor = [UIColor blackColor];
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+30, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    
    towerBackGroundView = [[UIScrollView alloc]init];
    towerBackGroundView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/12, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        towerBackGroundView.frame = CGRectMake(DeviceWidth/5, DeviceHeight/12, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);

    }
    
    [tutorialView addSubview:towerBackGroundView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //sprintTextImageView.image= sprintTextImage;
//    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
//    scrollView.scrollEnabled = YES;
    [towerBackGroundView addSubview:sprintTextImageView];
    //  [self showBeyondTutorial];
    
    UIButton *questTutorialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    questTutorialButton.frame = CGRectMake(tutorialBackgroundImage.size.width/2 - questButtonImage.size.width/2, towerBackGroundView.frame.size.height, questButtonImage.size.width, questButtonImage.size.height);
    [questTutorialButton setBackgroundImage:questButtonImage forState:UIControlStateNormal];
    [questTutorialButton addTarget:self action:@selector(gotToQuestFromTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:questTutorialButton];
    [UIView animateWithDuration:2.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
}
-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}
-(void)gotToQuestFromTutorial{
    [tutorialView removeFromSuperview];
    [self goToQuest];
}
-(void)showMainView{
    //  [self clearTutorialView];
    [UIView animateWithDuration:1.0 delay:0.6 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [tutorialView removeFromSuperview];
                         [self enableTouch];}];
    
   // [self createMainView];
}

-(void)clearView{
    if(!isCleared){
        isCleared = TRUE;
//        [backButton removeFromSuperview];
//        [questButton removeFromSuperview];
//        [towerView removeFromSuperview];
//        [progressView removeFromSuperview];
//        [curLevel removeFromSuperview];
//        [nextLevel removeFromSuperview];
//        [image removeFromSuperview];
//        [progressBgImageView removeFromSuperview];
//        [curLevelKnop removeFromSuperview];
//        [nextLevelKnop removeFromSuperview];
//        
//        [backButton release];
//        [questButton release];
//        [towerView release];
//        [progressView release];
//        [curLevel release];
//        [nextLevel release];
//        [curLevelKnop release];
//        [nextLevelKnop release];
//        [image release];
//        
//        [progressBgImageView release];
        [towerBaseView removeFromSuperview];
    }

}

-(void)showLevelInfo:(id)sender{
    [self clearView];
    UIButton *btn = (UIButton *)sender;
    NSLog(@"senderTag=%d",btn.tag);
    
    
    CCMenuItem *nextitem = [CCMenuItemImage itemWithNormalImage:@"Tower_Next_Button.png" selectedImage:@"Tower_Next_Button.png" target:self selector:@selector(showNextpopup)];
    CCMenu *next = [CCMenu menuWithItems:nextitem, nil];
    next.position = ccp(240*DevicewidthRatio,30*DeviceheightRatio);
    currentPopupNumber= btn.tag;
    [self towerTalkPopup:currentPopupNumber];
//    NSString *str = @"kslfdsalanfasdnfdnfjksngjsngjksngkj";
//    CCLabelTTF *con4 = [CCLabelTTF labelWithString:str dimensions:CGSizeMake(200, bg.contentSize.height) alignment:UITextAlignmentLeft fontName:@"Times" fontSize:20];
//    con4.position = ccp(140,150);
//    con4.color = ccBLACK;
//    [bg addChild:con4];
    CCMenuItem *homeitem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(backToHome)];
    CCMenu *back = [CCMenu menuWithItems:homeitem, nil];
    back.position = ccp(70*DevicewidthRatio,30*DeviceheightRatio);
    
    [self addChild:back];
    
    
    
    [self addChild:next];
}
-(void)showNextpopup{
    [bgImageView removeFromSuperview];
    [towerTalkScrollView removeFromSuperview];
    currentPopupNumber++;
    if(currentPopupNumber>[gamedata returnlevel]){
        currentPopupNumber=1;
    }
    [self towerTalkPopup:currentPopupNumber];
}

-(NSString*)generateToken{

        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        
        char code[20];
        
        int d2=day%10;
        int d1=(day-d2)/10;
        
        int m1=month%10;
        int m2=(month-m1)/10;
        
        int y=year%100;
        int y1=y%10;
        int y2=(y-y1)/10;
        
        int r1=97+arc4random()%16; // Integer to correspond to ASCII of a lowercase a--> p
        int r2=65+arc4random()%23; // Integer to correspond to Ascii of an uppercase A-->W
        int r3=97+arc4random()%19; // Integer to correspond to Ascii of a lowercase a-->s
        
        
        int KNOPs = [gamedata returnknop]; // We will set to the actual KNOP in the code
        int Gold = [gamedata returngold]; // Actual Gold
        float UScore = [gamedata getUScore]; // Actual UScore
        
        int intUScore=ceil(UScore);
        
        int No_Quests=[gamedata getQuestCompleted]; // Actual No_Quests
        
        int KG=KNOPs+Gold;
        
        int KG1=KG%10;
        int KG2=((KG%100)-KG1)/10;
        int KG3=((KG%1000)-(KG1+10*KG2))/100;
        int KG4=((KG%10000)-(KG1+10*KG2+100*KG3))/1000;
        
        
        int U1=intUScore%10;
        int U2=((intUScore%100)-U1)/10;
        int U3=((intUScore%1000)-(U1+10*U2))/100;
        int U4=((intUScore%10000)-(U1+10*U2+100*U3))/1000;
        
        int n1=KG1%4 + r1%3 + No_Quests%4;
        int r11=r1 + U3;
        int r21=r2 + U2%3;
        int r31=r3 + U1%7;
        
        int r4=d2%5 + d1 + month%2;
        
        
        code[0]=(char) (r1);
        code[1]=(char) (r2);
        code[2]= (char) (48+d2);
        code[3]= (char) (r3);
        code[4]=(char) (48+m1);
        code[5]= (char) (48+d1);
        code[6]=(char) (48+KG4);
        code[7]=(char) (48+KG3);
        code[8]=(char) (48+KG2);
        code[9]=(char) (48+KG1);
        code[10]=(char) (48+n1);
        code[11]=(char) (48+U4);
        code[12]=(char) (48+U3);
        code[13]=(char) (48+U2);
        code[14]=(char) (48+U1);
        code[15]=(char) (r11);
        code[16]=(char) (48+No_Quests);
        code[17]=(char) (r21);
        code[18]=(char) (r31);
        code[19]=(char) (48+r4);
        
        
        
        
        NSString *token;
        
        token = [[NSString alloc] initWithBytes:code length:sizeof(code) encoding:NSASCIIStringEncoding];
        
         
        // here instead of displaying you will save token in the Player table .. later it will be retrieved from there
        
    [gamedata setToken:token];
    return token;
    
}

-(void)towerTalkPopup:(int)popupNumber{
//    bg= [CCSprite spriteWithFile:[NSString stringWithFormat:@"%dtxt.png",popupNumber]];
//    bg.position = ccp(160,260);
//    [self addChild:bg];
    UIImage *bgImage = [UIImage imageNamed:@"Tower_Level_DIalog"];
    
    bgImageView = [[UIImageView alloc]initWithImage:bgImage];
    bgImageView.frame = CGRectMake((DeviceWidth-bgImage.size.width)/2, (DeviceHeight-bgImage.size.height)/2-30, bgImage.size.width, bgImage.size.height);
    bgImageView.userInteractionEnabled = YES;
    [[[CCDirector sharedDirector]view ]addSubview:bgImageView];
    
    talkImage = [UIImage imageNamed:[NSString stringWithFormat:@"%dtxt.png",popupNumber ]];
    towerTalkScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(25, 30, bgImageView.frame.size.width-40, bgImageView.frame.size.height-60)];
   // towerTalkScrollView.backgroundColor = [UIColor redColor];
        
    if([[[Utility getInstance]deviceType] isEqualToString:@"-568h"]){
        
        towerTalkScrollView.frame = CGRectMake(25, 30, bgImageView.frame.size.width-40, bgImageView.frame.size.height-60);
    }
    if([[[Utility getInstance]deviceType] isEqualToString:@"_iPad"]){
         towerTalkScrollView.frame = CGRectMake(45,70, bgImageView.frame.size.width-80, bgImageView.frame.size.height-140);
    }
    talkImageView = [[UIImageView alloc]initWithImage: talkImage];
    
    towerTalkScrollView.contentSize = CGSizeMake(talkImage.size.width, talkImage.size.height/2+talkImage.size.height);
    towerTalkScrollView.scrollEnabled = YES;
  [towerTalkScrollView addSubview:talkImageView];
    [bgImageView addSubview:towerTalkScrollView];

    if(popupNumber==10){
        NSString *token = [gamedata getToken] ;
        if(!token){
            token = [self generateToken];
        }
       
    towerTalkScrollView.frame = CGRectMake(25, 20, bgImageView.frame.size.width-40, bgImageView.frame.size.height-80);
        if([[[Utility getInstance]deviceType] isEqualToString:@"-568h"]){
            towerTalkScrollView.frame = CGRectMake(25, 30, bgImageView.frame.size.width-40, bgImageView.frame.size.height-80);
        }
        if([[[Utility getInstance]deviceType] isEqualToString:@"_iPad"]){
            towerTalkScrollView.frame = CGRectMake(45,60, bgImageView.frame.size.width-80, bgImageView.frame.size.height-200);        }

    tokenLabel = [[UILabel alloc]initWithFrame:CGRectMake(DeviceWidth/5.82, DeviceHeight/1.54, 320, 50)];
        if([[[Utility getInstance]deviceType] isEqualToString:@"-568h"]){
            tokenLabel.frame = CGRectMake(DeviceWidth/5.82, 320, 320, 50);
        }
//        if([[[Utility getInstance]deviceType] isEqualToString:@"_iPad"]){
//            tokenLabel.frame = CGRectMake(70, 300, 320, 50);
//            
//        }

    tokenLabel.backgroundColor = [UIColor clearColor];
    tokenLabel.text = token;
    tokenLabel.font = [UIFont fontWithName:@"Times" size:15];
        if([[[Utility getInstance]deviceType] isEqualToString:@"_iPad"]){
        tokenLabel.font = [UIFont fontWithName:@"Times" size:30];
        }
        [bgImageView addSubview:tokenLabel];
    }

}


-(void)backToHome{
    [towerTalkScrollView removeFromSuperview];
    [bgImageView removeFromSuperview];
    [self clearView];
 [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[NewTower scene]]];
}

-(void)goToQuest{
    [[SimpleAudioEngine sharedEngine]stopEffect:effectID];
    [self clearView];
//    [backButton removeFromSuperview];
//    [questButton removeFromSuperview];
//    [towerView removeFromSuperview];
//    [progressView removeFromSuperview];
//    [curLevel removeFromSuperview];
//    [nextLevel removeFromSuperview];
//    [image removeFromSuperview];
//    [progressBgImageView removeFromSuperview];

    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB transitionWithDuration:1.0 scene:[QuestScene scene]]];
}

- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
	CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
             frameToCenter.origin.y = ((boundsSize.height - frameToCenter.size.height) / 2)-50;
        }
    }
    else {
        frameToCenter.origin.y = 0;
        if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
            frameToCenter.origin.y = -150;
        }
    }
	
	return frameToCenter;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
   // image.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);
    image.frame = [self centeredFrameForScrollView:scrollView andUIView:image];
//    for (int i= 0; i<[towerButtonArray count]; i++) {
//        UIButton *btn = (UIButton*)[towerButtonArray objectAtIndex:i];
//        btn.frame = [self centeredFrameForScrollView:scrollView andUIView:btn];
//    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return image;
}


-(void)enableTouch{
    [towerBackGroundView setUserInteractionEnabled:YES];
    [backButton setUserInteractionEnabled:YES];
    
}

-(void)disableTouch{
    [towerBackGroundView setUserInteractionEnabled:NO];
   [backButton setUserInteractionEnabled:NO];
}

#pragma mark - GestureRecognizer delegate


-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==1)
    {
        if(buttonIndex == 0){
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
                [tutorialView removeFromSuperview];
            }
            [self back];
        }
    }
    if (alertView.tag==2)
    {
        if (buttonIndex==0)
        {
            
        }
        else if (buttonIndex==1)
        {
            //NSString *app_link=@"https://itunes.apple.com/us/app/kwest-mind-adventure-intelligence/id798581184?ls=1&mt=8";
            NSString *app_link=@"http://itunes.apple.com/app/id798581184?mt=8";
            //@"http://itunes.apple.com/app/id798581184?mt=8";
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.9) {
               app_link=@"itms-apps://itunes.apple.com/app/id798581184";
                NSLog(@"Beyond");
            }
            else
            {
                app_link=@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=798581184";
                NSLog(@"NOT Beyond");
            }
            
            //itms-apps://itunes.apple.com/app/id798581184
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:app_link]];
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"revAskAllow"];
            [Flurry logEvent:@"Review Click"];

            
            
        }
        else if (buttonIndex==2)
        {
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"revAskAllow"];

        }
        
        else if (buttonIndex==3)
        {
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"revAskAllow"];

        }
    }
    if (alertView.tag==3)
    {
        
    }

}
-(void)back{
    
    //    [qq release];
        [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
    tempView.backgroundColor = [UIColor redColor];
    [[[CCDirector sharedDirector]view ]addSubview:tempView];
    [UIView transitionFromView:towerBaseView
                        toView:tempView
                      duration:2
                       options:UIViewAnimationTransitionFlipFromRight
                    completion:nil];
   // [self clearView];
    [tempView removeFromSuperview];
   // if(!isCleared){
//    CCTransitionCrossFade *transition = [CCTransitionCrossFade transitionWithDuration:0.1 scene:[Menu scene]];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
//    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[Menu scene]]];
   // }
}

@end
