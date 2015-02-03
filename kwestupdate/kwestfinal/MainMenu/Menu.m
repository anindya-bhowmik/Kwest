//
//  HelloWorldLayer.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 10/10/2012.
//  Copyright AITL 2012. All rights reserved.
//


// Import the interfaces
#import "Menu.h"
#import "TutorialView.h"
#import "Play.h"
#import "BrainArenaMenu.h"
#import "PlayerInfo.h"
#import "PlayerStat.h"
#import "Profile.h"
#import "NewTower.h"
#import "Beyond.h"
#import "OptionView.h"
#import "BasePopUpView.h"
#import "Score.h"
#import <RevMobAds/RevMobAds.h>
#import "Utility.h"
#import "GameKitHelper.h"
#import <Chartboost/Chartboost.h>
//#import "ResolutionConstant.h"
// HelloWorldLayer implementation
@implementation Menu

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Menu *layer = [Menu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//-(void)onEnterTransitionDidFinish{
//    [super onEnterTransitionDidFinish];
//    NSLog(@"asds");
//}


-(void)onEnter{
    [super onEnter];
   // [[RevMobAds session] showFullscreen];
    //if([[SimpleAudioEngine sharedEngine]willPlayBackgroundMusic]){
   // 
    
      //  [[SimpleAudioEngine  sharedEngine]playBackgroundMusic:@"Angels.mp3" loop:NO];
   // }
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:effectId];
   
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
       // listofItem = [[NSMutableArray alloc]init];
//        Score *sc = [[Score alloc]init];
//        [sc calculateUScore];
//        [sc release];
        
//        UIViewController *temp = [[UIViewController alloc]init];
//        [[[CCDirector sharedDirector]view ]addSubview:temp.view];
//        GameCenterManager *gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
//       // [gameCenterManager setDelegate:self];
//        [gameCenterManager authenticateLocalUser:temp];
//
        [Chartboost showRewardedVideo:CBLocationMainMenu];
        for(int i=0;i<10;i++){
            int p_type =arc4random()%100+1;
            NSLog(@"ptype=%d",p_type);
        }
           gamedata = [GameData GameDataManager];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if(![defaults boolForKey:@"isFirstOpenApplication"]){
            [defaults setBool:YES forKey:@"Help"];
            [defaults setBool:YES forKey:@"Sound"];
            [defaults setInteger:0 forKey:@"EasterFlag"];
            [defaults setBool:YES forKey:@"isFirstOpenApplication"];
            NSDate *startDate = [NSDate date];
            NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            NSString *dateString = [dateFormatter stringFromDate:startDate];
            [gamedata setStartDate:dateString];
        }
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            effectId =  [[SimpleAudioEngine sharedEngine]playEffect:@"Angels.mp3"];
     
        PlayerStatistics *knowledgePathStat = [PlayerStatistics StatManager];
        [[GameKitHelper sharedGameKitHelper]submitScore:(int64_t)[knowledgePathStat getTotalCorrectRecord] category:@"KnowledgeGrade"];
        [[GameKitHelper sharedGameKitHelper]submitScore:(int64_t)[gamedata getoverallavg]*10 category:@"IntelligenceGrade"];
        [[GameKitHelper sharedGameKitHelper]submitScore:([gamedata growthRate]*100) category:@"GrowthRate"];
        if([gamedata daysToWisdom] > 0){
            [[GameKitHelper sharedGameKitHelper]submitScore:[gamedata daysToWisdom] category:@"DaysToWisdom "];
        }
        if ([gamedata numberOfDaysPlayed] <=10)
        {
            if ([knowledgePathStat getTotalTryRecord]>=500)
                [[GameKitHelper sharedGameKitHelper]sendAchievements:@"ambitious"];
            if ([gamedata getoveralltry] >=100)
                 [[GameKitHelper sharedGameKitHelper]sendAchievements:@"champion"];
        }
        if(![gamedata returnpremium]){
            if([gamedata returnknop]>275){
                [gamedata setknop:275];
            }
        }
       
        Score *score = [[Score alloc]init];
        [score karmaCalculation];
        [score release];
        NSString *getrefildate = [gamedata getEndergydate];
        NSLog(@"getrefildate=%@",getrefildate);
        
        [self currentTime:getrefildate];
        [self createBackgroundView];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
            [self createTutorialBaseView];
           // [self performSelector:@selector(createTutorialBaseView) withObject:nil afterDelay:0.5];
        }
        
        
        if(![[GameData GameDataManager] returnpremium]){
            [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"moreAllowed"];
        }
        
        //if ([[GameData GameDataManager] returnknop]<5 && [[NSU)
        /*if ([[NSUserDefaults standardUserDefaults]boolForKey:@"allowPop"])
            NSLog(@"Its Allowed");
        else
            NSLog(@"Its NOT");
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"notFirst"])
            NSLog(@"Its Not First");
        else
            NSLog(@"Its First");*/
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"] && [[NSUserDefaults standardUserDefaults]boolForKey:@"notFirst"] && [[NSUserDefaults standardUserDefaults] boolForKey:@"allowPop"])
        {
            int help_probability=arc4random()%100;
            //UIAlert Deactivate Tutorial Mode? Hint: You can Also set Tutorial OFF from the Options (...) Page 1) Yes, I Know Enough 2)No, Keep It
            if (help_probability<100)
            {
                UIAlertView *tutorialAlertView = [[UIAlertView alloc]initWithTitle:@"Tutorial Off?" message:@"Deactivate Tutorial Mode? \n Hint: You can Also set Tutorial OFF from the Options (...) Page. You can use the Help there to Learn more about the game." delegate:self cancelButtonTitle:@"No, I'll Do It Later" otherButtonTitles:@"Yes - I Know Enough", nil];
                
                [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"allowPop"];
                [tutorialAlertView show];
                [tutorialAlertView release];
               

               
            }
        }
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"notFirst"];

       	}
	return self;

}
-(void)alertView :(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   {
    if(buttonIndex == 1){
        //[Flurry logEvent:@"PremiumConfirm"];
         [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"Help"];
    }
}




-(void)createTutorialBaseView{
    gamedata.isTutorialShown = FALSE;
    [self disableTouch];
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *moreButtonImage = [UIImage imageNamed:@"More"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
//    tutorialView.backgroundColor = [UIColor grayColor];
    tutorialView.alpha = 0.0;
//    wrapper = [[CCUIViewWrapper alloc]initForUIView:tutorialView];
//    wrapper.contentSize = CGSizeMake(DeviceWidth, DeviceHeight);
//    
//    wrapper.position = ccp(320,0);
   // [self addChild:wrapper];
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
    [self showKwestMainText];
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(DeviceWidth/1.45, tutorialBackgroundImageView.frame.origin.y+tutorialBackgroundImage.size.width+DeviceHeight/4.8, moreButtonImage.size.width, moreButtonImage.size.height);
//    moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.23, moreButtonImage.size.width, moreButtonImage.size.height);
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.18, moreButtonImage.size.width, moreButtonImage.size.height);
//    }
    [moreButton setBackgroundImage:moreButtonImage forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showKwestMoreText) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:moreButton];
    [UIView animateWithDuration:2.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    
}

-(void)showKwestMoreText{
//    [UIView animateWithDuration:1.0 delay:1.0 options:nil
//                     animations:^{
//                         //tutorialView.center = midCenter;
//                         tutorialView.alpha = 0;
//                         tutorialBackgroundImageView.alpha = 0;
//                         moreButton.alpha = 0;
//                     }
//                     completion:^(BOOL finished){
                         for(UIView *subViews in [tutorialBackgroundImageView subviews]){
                                                          [subViews removeFromSuperview];
                                                      }
                         
                         UIImage *sprintTextImage = [UIImage imageNamed:@"KWEST_Sectionstxt"];
                         UIImage *brainArenaButtonImage = [UIImage imageNamed:@"BrainArena"];
                         UIImage *beyondButtonImage = [UIImage imageNamed:@"Beyond"];
                         UIImage *knowledgepathButtonImage = [UIImage imageNamed:@"KnowledgePath"];
                         UIImage *profileButtonImage = [UIImage imageNamed:@"Profile"];
                         UIImage *towerofWisdomButtonImage = [UIImage imageNamed:@"Tower"];
                         UIScrollView *scrollView = [[UIScrollView alloc]init];
                         scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height);
                         ;
//                         if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//                             scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/30, sprintTextImage.size.width, sprintTextImage.size.height);
//                         ;
//                         }
                         [tutorialBackgroundImageView addSubview:scrollView];
                         
                         UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
                         scrollView.scrollEnabled = NO;
                         scrollView.contentSize = CGSizeMake(sprintTextImage.size.width+60, sprintTextImage.size.height);
                         [scrollView addSubview:sprintTextImageView];
                         float xmargin =(tutorialBackgroundImageView.frame.size.width -(brainArenaButtonImage.size.width+beyondButtonImage.size.width))/3;
                         UIButton *brainArenaButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         brainArenaButton.frame = CGRectMake(xmargin+5, scrollView.frame.size.height+20, brainArenaButtonImage.size.width, brainArenaButtonImage.size.height);
                         [brainArenaButton setBackgroundImage:brainArenaButtonImage forState:UIControlStateNormal];
                         [brainArenaButton addTarget:self action:@selector(gotToBrainArenaFromTutorial) forControlEvents:UIControlEventTouchDown];
                         [tutorialBackgroundImageView addSubview:brainArenaButton];
                         
                         UIButton *beyondButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         beyondButton.frame = CGRectMake(xmargin+5+brainArenaButton.frame.size.width, scrollView.frame.size.height+20, beyondButtonImage.size.width, beyondButtonImage.size.height);
                         [beyondButton setBackgroundImage:beyondButtonImage forState:UIControlStateNormal];
                         [beyondButton addTarget:self action:@selector(goToBeyondFromTutorial) forControlEvents:UIControlEventTouchDown];
                         [tutorialBackgroundImageView addSubview:beyondButton];
                         
                         UIButton *knowledgepathButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         knowledgepathButton.frame = CGRectMake(xmargin+5, scrollView.frame.size.height+20+brainArenaButton.frame.size.height, knowledgepathButtonImage.size.width, knowledgepathButtonImage.size.height);
                         [knowledgepathButton setBackgroundImage:knowledgepathButtonImage forState:UIControlStateNormal];
                         [knowledgepathButton addTarget:self action:@selector(gotToKnowledgePathFromTutorial) forControlEvents:UIControlEventTouchDown];
                         [tutorialBackgroundImageView addSubview:knowledgepathButton];
                         
                         
                         UIButton *profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         profileButton.frame = CGRectMake(xmargin+5+brainArenaButton.frame.size.width, scrollView.frame.size.height+20+beyondButton.frame.size.height, profileButtonImage.size.width, profileButtonImage.size.height);
                         [profileButton setBackgroundImage:profileButtonImage forState:UIControlStateNormal];
                         [profileButton addTarget:self action:@selector(gotToProfileFromTutorial) forControlEvents:UIControlEventTouchDown];
                         [tutorialBackgroundImageView addSubview:profileButton];
                         
                         UIButton *towerButton = [UIButton buttonWithType:UIButtonTypeCustom];
                         towerButton.frame = CGRectMake(xmargin+5, scrollView.frame.size.height+20+beyondButton.frame.size.height+profileButton.frame.size.height, towerofWisdomButtonImage.size.width, towerofWisdomButtonImage.size.height);
                         [towerButton setBackgroundImage:towerofWisdomButtonImage forState:UIControlStateNormal];
                         [towerButton addTarget:self action:@selector(goToTowerofWisdomfromTutorial) forControlEvents:UIControlEventTouchDown];
                         [tutorialBackgroundImageView addSubview:towerButton];
                         [moreButton removeFromSuperview];
                        // [tutorialView removeFromSuperview];
                    // }];
//    [UIView animateWithDuration:1.0 delay:1.0 options:nil
//                     animations:^{
//                         //tutorialView.center = midCenter;
//                         tutorialView.alpha = 1;
//                         tutorialBackgroundImageView.alpha = 1;
//                     }
//                     completion:^(BOOL finished){
////                         for(UIView *subViews in [tutorialBackgroundImageView subviews]){
////                             [subViews removeFromSuperview];
////                         }
//                     }];
    
   // [self clearTutorialView];
//    [UIView animateWithDuration:1.0 delay:0.2 options:nil
//                     animations:^{
//                         //tutorialView.center = midCenter;
//                         tutorialView.alpha = 1;
//                         moreButton.alpha = 0;
//                         tutorialBackgroundImageView.alpha =1;
//                     }
//                     completion:^(BOOL finished){
////                         for(UIView *subViews in [tutorialBackgroundImageView subviews]){
////                             [subViews removeFromSuperview];
////                             [moreButton removeFromSuperview];
////                         }
//                     }];
    
    

}

-(void)removeTutorialBaseView{
    [tutorialView removeFromSuperview];
}

-(void)gotToBrainArenaFromTutorial{
    [self removeTutorialBaseView];
    [self goToBrainArena];
}

-(void)gotToKnowledgePathFromTutorial{
    [self removeTutorialBaseView];
    [self goToStart];
}

-(void)goToBeyondFromTutorial{
    [self removeTutorialBaseView];
    [self goToBeyond];
}

-(void)gotToProfileFromTutorial{
    [self removeTutorialBaseView];
    [self goToPlayerData];
}
-(void)goToTowerofWisdomfromTutorial{
    [self removeTutorialBaseView];
    [self goToTowerofWisdom];
}

//-(void)clearTutorialView{
//    [UIView animateWithDuration:1.0 delay:0.2 options:nil
//                     animations:^{
//                         //tutorialView.center = midCenter;
//                         tutorialView.alpha = 0;
//                     }
//                     completion:^(BOOL finished){
//                         for(UIView *subViews in [tutorialBackgroundImageView subviews]){
//                             [subViews removeFromSuperview];
//                         }
//                     }];
//
//    
//}

-(void)showMainView{
   // self.enabled = YES;
    [UIView animateWithDuration:1.0 delay:0.2 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                      [tutorialView removeFromSuperview];
                     }];
   
    [self enableTouch];
    //[self createBackgroundView];
}
-(void)showKwestMainText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"KWEST_Maintxt"];
//    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
//    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
//    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height);
    ;
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height);
        ;

    }
    
    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = NO;
//    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width+60, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
    
}

-(void)createBackgroundView{
    [self enableTouch];
    
//    tutView = [[TutorialView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
//    [[[CCDirector sharedDirector]openGLView]addSubview:tutView];
    menuBg = [CCSprite spriteWithFile:@"Homebackground.png"];
    menuBg.anchorPoint = ccp(0.5,0.5);
    menuBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:menuBg];
    CCMenuItemImage *knowledgePath = [CCMenuItemImage itemWithNormalImage:@"KnowledgePathmenu.png" selectedImage:@"KnowledgePathPressed.png" target:self selector:@selector(goToStart)];
    knowledgePathMenu = [CCMenu menuWithItems:knowledgePath, nil];
    knowledgePathMenu.position = ccp(80*DevicewidthRatio,190*DeviceheightRatio);
    [menuBg addChild:knowledgePathMenu];
    
     CCMenuItemImage *profile = [CCMenuItemImage itemWithNormalImage:@"You.png" selectedImage:@"YouPressed.png" target:self selector:@selector(goToPlayerData)];
    profileMenu = [CCMenu menuWithItems:profile, nil];
    profileMenu.position = ccp(100*DevicewidthRatio,30*DeviceheightRatio);
    [menuBg addChild:profileMenu];
    
    CCMenuItemImage *brainArena = [CCMenuItemImage itemWithNormalImage:@"BrainArenamenu.png" selectedImage:@"BrainArenaPressed.png" disabledImage:@"BrainArenamenu.png" target:self selector:@selector(goToBrainArena)];
    brainArenaMenu = [CCMenu menuWithItems:brainArena, nil];
    brainArenaMenu.position = ccp(240*DevicewidthRatio,78*DeviceheightRatio);
    [menuBg addChild:brainArenaMenu];
    
    CCMenuItemImage *towerOfWisdom = [CCMenuItemImage itemWithNormalImage:@"TowerWisdom.png" selectedImage:@"TowerWisdomPressed.png" disabledImage:@"TowerWisdom.png" target:self selector:@selector(goToTowerofWisdom)];
    towerOfWisdomMenu = [CCMenu menuWithItems:towerOfWisdom, nil];
    towerOfWisdomMenu.position = ccp(250*DevicewidthRatio,301*DeviceheightRatio);
    [menuBg addChild:towerOfWisdomMenu];
    
    CCMenuItemImage *beyond = [CCMenuItemImage itemWithNormalImage:@"Beyondmenu.png" selectedImage:@"BeyondPressed.png" disabledImage:@"BeyondPressed.png" target:self selector:@selector(goToBeyond)];
    beyondMenu = [CCMenu menuWithItems:beyond, nil];
    beyondMenu.position = ccp(DevicewidthRatio*70,DeviceheightRatio*350);
    [menuBg addChild:beyondMenu];
    
    CCMenuItemImage *threePoints = [CCMenuItemImage itemWithNormalImage:@"ThreePoints.png" selectedImage:@"ThreePointsPressed.png" disabledImage:@"BeyondPressed.png" target:self selector:@selector(goTothreePoints:)];
    threePointsMenu = [CCMenu menuWithItems:threePoints, nil];
    threePointsMenu.position = ccp(280*DevicewidthRatio,30*DeviceheightRatio);
    [menuBg addChild:threePointsMenu];
}


-(void)enableTouch{
  
    knowledgePathMenu.enabled = YES;
    profileMenu.enabled= YES;
    brainArenaMenu.enabled= YES;
    towerOfWisdomMenu.enabled= YES;
    beyondMenu.enabled= YES;
    threePointsMenu.enabled= YES;
}

-(void)disableTouch{
    knowledgePathMenu.enabled = NO;
    profileMenu.enabled= NO;
    brainArenaMenu.enabled= NO;
    towerOfWisdomMenu.enabled= NO;
    beyondMenu.enabled= NO;
    threePointsMenu.enabled= NO;
}

-(void)goTothreePoints:(id)sender{
[[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[OptionView scene]]];
}

-(void)goToTowerofWisdom{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[NewTower scene]]];
}

-(void)goToBeyond{
   [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[Beyond scene]]];
    
}
-(void)goToPlayerData{
    
//    [self addTable];

   [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[Profile scene]]];

}


-(void)goToStart{
    [[GameData GameDataManager]readQusfromdb];
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[Play scene]]];
}

-(void)goToAdventure:(id)sender{
   
}

-(void)goToBrainArena{
 [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[BrainArenaMenu scene]]];
}


-(void)currentTime:(NSString*)refildate
{    
    int karma = [gamedata returnkarma];
    NSLog(@"Passed currentTime");
    NSInteger energy=0;
    //Get current time
    NSDate* now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:now];
    NSInteger year = [dateComponents year];

    NSInteger month= [dateComponents month];
    NSInteger day = [dateComponents day];
    [gregorian release];
    NSString *curdate = [NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    NSLog(@"curdata = %@",curdate);
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLaunched"]){
        energy = 75;
        [gamedata setgold:5];
        [gamedata setEnergydate:curdate];
        [gamedata setEnergy:energy];
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"isFirstTimeLaunched"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        if ([curdate isEqualToString:refildate]) {
        NSLog(@"notrefil");
        NSLog(@"Refill Date: %@",refildate);
        NSLog(@"Current Date (equal): %@", curdate);
        
        }
    else {
       energy = 30 + 45*[gamedata returnpremium]+ 50*[gamedata returnkeyofenergy] + (3*(karma-5));
//        int r = arc4random()%99+1;
//        NSLog(@"r=%d",r);
//        if (r<karma*4 && karma>6) {
//             energy = 45 +(karma-6)*3;
//        }
//        else if(r<10*(5-karma) && karma<5){
//            energy = 45 - (5-karma)*3;
//        }
//            
//        else 
//            energy = 45;
        [gamedata setEnergydate:curdate];
        [gamedata setEnergy:energy];
    }
    }
    NSLog(@"Current Time  %d",refildate.length);
}

- (void)didFailToLoadRewardedVideo:(CBLocation)location
                         withError:(CBLoadError)error{

}

- (void)didDisplayRewardedVideo:(CBLocation)location{

}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
