//
//  Sprint.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "Sprint.h"
#import "Menu.h"
#import "Score.h"
#import "Utility.h"
#import "Chartboost.h"
#import <RevMobAds/RevMobAds.h>
#import "BrainArenaMenu.h"
@implementation Sprint
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    Sprint *layer = [Sprint node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(void)createnumpad{
  
    keyPadBg = [CCSprite spriteWithFile:@"numpad.png"];
    keyPadBg.anchorPoint = ccp(0.5,0.5);
    keyPadBg.position = ccp(160*DevicewidthRatio,110*DeviceheightRatio);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        keyPadBg.position = ccp(160*DevicewidthRatio,95*DeviceheightRatio);
    }
    
    [self addChild:keyPadBg];
    CCSprite *ornamentImage = [CCSprite spriteWithFile:@"ornamen-02.png"];
    //    ornamentImage.anchorPoint = ccp(0.5*DevicewidthRatio,0.5*DeviceheightRatio);
    ornamentImage.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        ornamentImage.position = ccp(160*DevicewidthRatio,205*DeviceheightRatio);
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        ornamentImage.position = ccp(160*DevicewidthRatio,235*DeviceheightRatio);
    }

    [self addChild:ornamentImage];
    float xval=0;
    float yval=0;
    //isClicked =false;
    for(int i=1;i<=9;i++){
        NSString *str = [NSString stringWithFormat:@"btn%d.png",i];
        NSString *pressedStr = [NSString stringWithFormat:@"btn%dpressed.png",i];
        CCMenuItemImage *btn = [CCMenuItemImage itemWithNormalImage:str selectedImage:pressedStr target:self selector:@selector(Answer:)];
        // if(i!=11)
        btn.tag=i;
        
        CCMenu *btnmenu = [CCMenu menuWithItems:btn, nil];
        btnmenu.position = ccp(50+xval,185-yval);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            btnmenu.position = ccp(50*DevicewidthRatio+xval,175*DeviceheightRatio-yval);
        }
        [keyPadBg addChild:btnmenu];
        xval+=67;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            xval+=67;
        }
        if(i%3==0){
            xval=0;
            yval+=53;
            if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                 yval+=53;
            }
        }
    }
    CCMenuItemImage *btn0 = [CCMenuItemImage itemWithNormalImage:@"btn0.png" selectedImage:@"btn0pressed.png" target:self selector:@selector(Answer:)];
    btn0.tag =0;
    CCMenu *btn0Menu = [CCMenu menuWithItems:btn0, nil];
    btn0Menu.position = ccp(120*DevicewidthRatio,30*DeviceheightRatio);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        btn0Menu.position = ccp(120*DevicewidthRatio,25*DeviceheightRatio);
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        btn0Menu.position = ccp(110*DevicewidthRatio,25*DeviceheightRatio);
    }


    [keyPadBg addChild:btn0Menu];
    
    CCMenuItemImage *delBtn = [CCMenuItemImage itemWithNormalImage:@"btn10.png" selectedImage:@"btn10pressed.png" target:self selector:@selector(Answer:)];
    delBtn.tag = 10;
    CCMenu *delBtnMenu = [CCMenu menuWithItems:delBtn, nil];
    delBtnMenu.position = ccp(275,160);

    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        //btnmenu.position = ccp(50*DevicewidthRatio+xval,185*DeviceheightRatio-yval);
        delBtnMenu.position = ccp(540,140*DevicewidthRatio);
    }
        [keyPadBg addChild:delBtnMenu];
    //
    CCMenuItemImage *enterBtn = [CCMenuItemImage itemWithNormalImage:@"btn12.png" selectedImage:@"btn12pressed.png" target:self selector:@selector(Answer:)];
    enterBtn.tag = 12;
    CCMenu *enterBtnMenu = [CCMenu menuWithItems:enterBtn, nil];
    enterBtnMenu.position = ccp(275,60);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        //btnmenu.position = ccp(50*DevicewidthRatio+xval,185*DeviceheightRatio-yval);
        enterBtnMenu.position = ccp(540,40*DevicewidthRatio);
    }

    //  enterBtnMenu.tag = 11;
    [keyPadBg addChild:enterBtnMenu];
}

-(void)initialize{
    int n1 = arc4random()%16;
    int n2 = arc4random()%12;
    int ran  = arc4random()%3;
    
    int num1 = MAX(n1, n2)+ceil(gamedata.sprintqusnum/2.0);
    int num2 = MAX(n1,n2)+ceil(gamedata.sprintqusnum/3.0);
    NSString *operator;
    if(ran==0){
        answer = num1+num2;
        operator =[NSString stringWithFormat:@"+"];
    }
    else if(ran==1){
        answer = num1-num2;
        operator =[NSString stringWithFormat:@"-"];
    }
    else if(ran==2){
        answer = num1*num2;
        operator =[NSString stringWithFormat:@"x"];
    }
    NSLog(@"answer=%d",answer);
    NSString *num1str = [NSString stringWithFormat:@"%d",num1];
    NSString *num2str = [NSString stringWithFormat:@"%d",num2];
    CCLabelTTF *num1lbl = [CCLabelTTF labelWithString:num1str fontName:@"Times-Bold" fontSize:38];
    CCLabelTTF *num2lbl = [CCLabelTTF labelWithString:num2str fontName:@"Times-Bold" fontSize:38];
    CCLabelTTF *optlbl = [CCLabelTTF labelWithString:operator fontName:@"Times-Bold" fontSize:36];
    CCLabelTTF *equllbl = [CCLabelTTF labelWithString:@"=" fontName:@"Times-Bold" fontSize:38];
    equllbl.position = ccp(160*DevicewidthRatio,320*DeviceheightRatio);
    [self addChild:equllbl];
    anslbl = [CCLabelTTF labelWithString:@"" fontName:@"Times-Bold" fontSize:38];
    anslbl.position = ccp(220*DevicewidthRatio,320*DeviceheightRatio);
    num1lbl.position = ccp(60*DevicewidthRatio,320*DeviceheightRatio);
    num2lbl.position = ccp(125*DevicewidthRatio,320*DeviceheightRatio);
    optlbl.position = ccp(95*DevicewidthRatio,320*DeviceheightRatio);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        anslbl.fontSize = 38*2;
        num1lbl.fontSize = 38*2;
        num2lbl.fontSize = 38*2;
        optlbl.fontSize = 38*2;
        equllbl.fontSize = 36*2;
    }
    [self addChild:anslbl];
    [self addChild:num1lbl];
    [self addChild:num2lbl];
    [self addChild:optlbl];
    //   NSString *as=optlbl.string;
    //  NSLog(@"as=%@",as);
    CCMenuItemImage    *backitem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(back:)];
    CCMenu *back  = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(50*DevicewidthRatio,440*DeviceheightRatio);
    [self addChild:back];
    
    NSString *qusnumstr = [NSString stringWithFormat:@"Q : %d/15",gamedata.sprintquscounter];
    CCLabelTTF *qusnumlbl = [CCLabelTTF labelWithString:qusnumstr fontName:@"Times-Bold" fontSize:24];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        qusnumlbl.fontSize = 24*2;
    }
    qusnumlbl.position = ccp(160*DevicewidthRatio,455*DeviceheightRatio);
    [self addChild:qusnumlbl];
    
    
    counter = gamedata.sprintTimer;
    NSString *counterstr = [NSString stringWithFormat:@"%.1f",counter];
    counterlbl = [CCLabelTTF labelWithString:counterstr fontName:@"Times-Bold" fontSize:20];
    counterlbl.color = ccRED;
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        counterlbl.fontSize = 40;
    }
    counterlbl.position = ccp(300*DevicewidthRatio,450*DeviceheightRatio);
    [self addChild:counterlbl];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        countdownEffectID = [[SimpleAudioEngine sharedEngine]playEffect:@"Ticking.mp3"];
    
    [self schedule:@selector(countdown:)interval:0.1f];

}

-(void)mainViewofSprint{
   
    stat = [PlayerStatistics StatManager];
    bg =[CCSprite spriteWithFile:@"brainarenabg.png"];
    bg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:bg];
    [self createnumpad];
    [self initialize];

}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:countdownEffectID];
}

-(id)init{
    if(self =[super init]){
        [Flurry logEvent:@"Speed"];
      //  [self mainViewofSprint];
         gamedata = [GameData GameDataManager];
        isClicked = false;
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"] && gamedata.isTutorialShown == FALSE){
            [self createTutorialBaseView];
        }
        else{
            [self mainViewofSprint];
        }
    }
    return self;
}

-(void)createTutorialBaseView{
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Speedtxt"];
    
    tutorialView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.backgroundColor = [UIColor blackColor];
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
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/8, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    if ([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]) {
        scrollView.frame = CGRectMake(DeviceWidth/5, DeviceHeight/8, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);
    }
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //sprintTextImageView.image= sprintTextImage;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    [scrollView addSubview:sprintTextImageView];
    [tutorialView addSubview:scrollView];
    [sprintTextImageView release];
    [scrollView release];
   
  //  [self showBeyondTutorial];
}
-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}
-(void)showMainView{
  //  [self clearTutorialView];
    [tutorialView removeFromSuperview];
    gamedata.isTutorialShown = TRUE;
    [self mainViewofSprint];
}

-(void)back:(id)sender{
    [self unschedule:@selector(countdown:)];
    gamedata.sprintquscounter=1;
    gamedata.sprintqusnum=1;
    gamedata.sprintTimer=0.0f;
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[BrainArenaMenu scene]]];
}

-(void)Answer:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"]){
            ALuint effect = [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    }
    
    if(!isClicked){
        CCMenuItem *btn = (CCMenuItemImage*)sender;
        if(btn.tag!=10 && btn.tag!=12){
            if([anslbl.string length]>0){
                NSString *str = anslbl.string;
                [anslbl setString:[NSString stringWithFormat:@"%@%d",str,btn.tag]];
            }
            else{
                [anslbl setString:[NSString stringWithFormat:@"%d",btn.tag]];
            }
        }
        else if(btn.tag==10){
            NSString *str1 = anslbl.string;
            if ( [str1 length] > 0)
                str1 = [str1 substringToIndex:[str1 length] - 1];
            [anslbl setString:[NSString stringWithFormat:@"%@",str1]];
        }
        else if(btn.tag==12){
            NSString *str1 = anslbl.string;
            [self checkAnswer:str1];
        }
    }

}


-(void)checkAnswer:(NSString*)ans{
    
    int ansval = [ans intValue];
    isClicked=true;
    [self unschedule:@selector(countdown:)];
    if(ansval==answer){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine sharedEngine]playEffect:@"CorrectAns.mp3"];

        gamedata.sprintquscounter++;
        gamedata.sprintqusnum++;
        
        if(gamedata.sprintqusnum<=15)
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[Sprint scene]]];
        else{
            [[SimpleAudioEngine sharedEngine]stopEffect:countdownEffectID];
            //[[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
            NSInteger n = [gamedata getsprinttry];
            n++;
            if (n==1) //just completed the first correct try
            {
                UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have successfully completed your first Sprint. \nRemember: 15 Questions, Correctly, ASAP. Better Time means more Gold & KNOPs. Click OK then Back to go to Brain Arena." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                BMAlert.tag = 2;
                [BMAlert show];
                [BMAlert release];

            }
            
            else if (n==10 && ![[GameData GameDataManager] returnpremium])
            {
                //NSLog(@"TARAAAdAAAAAA");
                UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Excellent !" message:@"You have Completed 10 Sprints. Check your Statistics in the Intelligence Statistics Page (Profile). \nHint: Upgrading to Premium will increase your daily Energy significantly, allow you to buy Keys, and remove the cap on your progress. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                BMAlert.tag = 3;
                [BMAlert show];
                [BMAlert release];
            }
            
            else if (n==20 && [[GameData GameDataManager] returnpremium] && (![[GameData GameDataManager] returnkeyofenergy] || ![[GameData GameDataManager] returnkeyofstrength]))
            {
                //NSLog(@"TARAAAdAAAAAA");
                UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have Completed 20 Sprints. \nRemember: The Key of Energy increases your daily Energy significantly, reduces the Energy cost of everything, and Unlocks the Well. The Key of Strength increases your Brain Arena Gains, Reduces your Brain Arena Energy costs, and Improves the Well of Energy and the Tree of Knowledge." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                BMAlert.tag = 5;
                [BMAlert show];
                [BMAlert release];
            }

            [gamedata setsprinttry:n];
            Score *sc = [[Score alloc]init];
            [sc SprintFinish:gamedata.sprintTimer];
           // [self showScoreLayer:0 :0];
           [self calculateScore:gamedata.sprintTimer];
            
            }
        }
    else{
        
        [[SimpleAudioEngine sharedEngine]stopEffect:countdownEffectID];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
         [[SimpleAudioEngine sharedEngine]playEffect:@"WrongAns.mp3"];
        gamedata.sprintquscounter=1;
        gamedata.sprintqusnum=1;
        gamedata.sprintTimer=0.0f;
        NSString *ansnumqus = @"That's Incorrect. No Time registered. You need to correctly answer 15 Questions.";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:ansnumqus message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert.tag=1;
        [alert release];
         Score *sc = [[Score alloc]init];
        [sc lstatOverall];
        [sc release];
    }
}

-(void)alertView :(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 && alertView.tag==1){
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[Menu scene]]];
    }
    else if (buttonIndex ==0 && alertView.tag==2)
    {
        
    }
    else{
        
    }
}

-(void)countdown:(ccTime)dt{
    counter+=0.1;
    gamedata.sprintTimer+=0.1;
    float n = gamedata.sprintTimer/10.0f;
    if(n==1)
        gamedata.sprintTimer+=gamedata.sprintTimer/10;
    counterlbl.string = [NSString stringWithFormat:@"%.1f",gamedata.sprintTimer];
}


-(void)calculateScore:(float)time{

    int g=0;
    int k=0;
    float knop;
    float gold;
    bool kos;
    knop = [gamedata returnknop];
    gold = [gamedata returngold];
    kos = [gamedata returnkeyofstrength];
    NSLog(@"goldbefore=%.f",gold);
    NSLog(@"knopbefore=%.f",knop);
    if(time<=25){
        g=8;
        k=3;
    }
    else if(time<=30){
        g=4;
        k=2;
    }
    else if(time<=35){
        g=3;
        k=1;
    }
    else if(time<=40){
        g=2;
        k=1;
    }
    else if(time<=50){
        g=1;
        k=0;
    }
    else{
        g=0;
        k=0;
    }
    if(g!=0){
        g=g+2*kos;
    }
    if(k!=0){
        k=k+kos;
    }
    
    if(![gamedata returnpremium]){
        [self showAd];
    }
    [self showScoreLayer:g :k];
    
}
-(void)showAd{
     if ([[GameData GameDataManager] returnknop]>10)
     {
         int probabilityOfChartBoost = arc4random()%100;
         int probabilityOfRevmob = arc4random()%100;
         if(probabilityOfChartBoost<70){
            [[Chartboost sharedChartboost]showInterstitial];
        }
        else if(probabilityOfRevmob<80){
            [[RevMobAds session] showFullscreen];
        }
     }
}
//-(void)setLevel:(int)k{
//    int level = 0;
//    if(k>=5 && k<100)
//        level=1;
//    else if(k>=100 && k<220)
//        level=2;
//    else if(k>=220 && k<360)
//        level=3;
//    else if(k>=360 && k<600)
//        level=4;
//    else if(k>=600 && k<900)
//        level=5;
//    else if(k>=900 && k<1200)
//        level=6;
//    else if(k>=1200 &&k<1600)
//        level=7;
//    else if(k>=1600 && k<2000)
//        level=8;
//    else if(k>=2000 && k<2500)
//        level=9;
//    else if(k>=2500)
//        level=10;
//    [gamedata setLevel:level];
//}
//-(void)karmaCalculation{
//    float k_totalrate;
//    int level;
//    double noofquestcompleted;
//    double temp1;
//    double temp2;
//    int flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8,flag9;
//    level = [gamedata returnlevel];
//    noofquestcompleted = [gamedata getQuestCompleted];
//    temp1 = (double)((level+1)/2.0f);
//    temp2 = (double)((level-3)/2.0f);
//    float tmp = temp1-noofquestcompleted ;
//    NSLog(@"temp1=%f temp2=%f",tmp,temp2);
//    
//    int correctsum = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
//    int trysum = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
//    
//    if(trysum!=0)
//        k_totalrate = ((float)correctsum/(float)trysum)*100;
//    else 
//        k_totalrate=0;
//    float l_totalavg = (([gamedata getEnduranceavg]/30.0f+(1-(([gamedata getSprinteavg]-20)/40))+[gamedata getMemoryavg]/8.0f)/3.0f)*100;
//    
//    if(k_totalrate>=75)
//        flag1 = 1;
//    else 
//        flag1=0;
//    
//    if(l_totalavg>=75)
//        flag2=1;
//    else 
//        flag2 =0;
//    
//    if(level>=5)
//        flag3=1;
//    else
//        flag3=0;
//    
//    if(temp1<=noofquestcompleted)
//        flag4=1;
//    else
//        flag4=0;
//    
//    if(temp1<noofquestcompleted)
//        flag5=1;
//    else
//        flag5=0;
//    if(k_totalrate<50)
//        flag6=1;
//    else
//        flag6 =0; 
//    if(l_totalavg<50)
//        flag7=1;
//    else 
//        flag7=0;
//    if(temp2>=(float)noofquestcompleted)
//        flag8=1;
//    else 
//        flag8 = 0;
//    if(temp2>(float)noofquestcompleted)
//        flag9=1;
//    else
//        flag9=0;
//    int karma=5+((flag1+flag2+flag3+flag4+flag5)-(flag6+flag7+flag8+flag9));
//    NSLog(@"flag1=%d,flag2=%d,flag3=%d,flag4=%d,flag5=%d,flag6=%d,flag7=%d,flag8=%d,flag9=%d quest=%f",flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8,flag9,noofquestcompleted);
//    [gamedata setKarma:karma];
//}


-(void)showScoreLayer:(float)g :(float)k{
    CCSprite *scorebg = [CCSprite spriteWithFile:@"scorebg.png"];
    scorebg.position = ccp(160*DevicewidthRatio,200*DeviceheightRatio);
    [self addChild:scorebg];

    NSString *completeString = [NSString stringWithFormat:@"You have completed the 15-question sprint in %.1f seconds",counter];
    CCLabelTTF *complete = [CCLabelTTF labelWithString:completeString fontName:@"Times-Bold" fontSize:20 dimensions:CGSizeMake(200, 240) hAlignment:kCCTextAlignmentLeft lineBreakMode:Nil];
       complete.position = ccp(140,100);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        complete.fontSize = 40;
        complete.dimensions = CGSizeMake(320, 400);
        complete.position = ccp(250,110*DevicewidthRatio);
    }
 
    complete.color = ccBLACK;
    [scorebg addChild:complete];
    
    CCLabelTTF *yourReawarLabel = [CCLabelTTF labelWithString:@"Your Reward :"  fontName:@"Times" fontSize:20];
    yourReawarLabel.position = ccp(120,110);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        yourReawarLabel.position = ccp(120*DevicewidthRatio,110*DeviceheightRatio);
        yourReawarLabel.fontSize = 40;
    }
    yourReawarLabel.color = ccBLACK;
    [scorebg addChild:yourReawarLabel];
    CCLabelTTF *knoplbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"KNOPs: %.f",k] fontName:@"Times-Bold" fontSize:22];
    knoplbl.position = ccp(140,80);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
       knoplbl.position = ccp(140*DevicewidthRatio,80*DeviceheightRatio);
        knoplbl.fontSize = 40;
    }
    knoplbl.color = ccBLUE;
    [scorebg addChild:knoplbl];
    CCLabelTTF *goldlbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Gold    : %.f",g] fontName:@"Times-Bold" fontSize:22];
    goldlbl.position = ccp(140,50);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldlbl.position = ccp(140*DevicewidthRatio,50*DeviceheightRatio);
        goldlbl.fontSize = 40;
    }
    goldlbl.color = ccBLUE;
    [scorebg addChild:goldlbl];
    id fadeIn = [CCFadeIn actionWithDuration:0.1];
    id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
    id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
    id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
    id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
    [scorebg runAction:pulse];
    
  /*  BrainArenaResult *kr = [BrainArenaResult node];
    [self addChild:kr];*/
}
@end
