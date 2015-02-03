    //
//  Endurance.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "Endurance.h"
#import "Menu.h"
#import "PlayerStatistics.h"
#import "Utility.h"
#import <Chartboost/Chartboost.h>
#import <RevMobAds/RevMobAds.h>
#import "BrainArenaMenu.h"

@implementation Endurance
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    Endurance *layer = [Endurance node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:countDownEffectId];
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

-(id)init{
    if(self =[super init]){
        [Flurry logEvent:@"Focus"];
        gamedata = [GameData GameDataManager];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"] && gamedata.isTutorialShown == FALSE){
            [self createTutorialBaseView];
        }
        else {
            [self mainViewofEndurance];
        }
    }
    
    return self;
}


-(void)mainViewofEndurance{
    
    
    int n1 = arc4random()%20;
    int n2 = arc4random()%15;
    CCSprite *bg =[CCSprite spriteWithFile:@"brainarenabg.png"];
    bg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:bg];
    [self createnumpad ];
    
    int num1 = MAX(n1, n2)+ceil(gamedata.sprintqusnum/2.0);
    int num2 = MIN(n1,n2)+ceil(gamedata.sprintqusnum/2.0);
    NSString *operator;
    if(gamedata.endurancequsnum<=10){
        
        int ran  = arc4random()%2;
        if(ran==0){
            answer = num1+num2;
            operator =[NSString stringWithFormat:@"+"];
        }
        else if(ran==1){
            answer = num1-num2;
            operator =[NSString stringWithFormat:@"-"];
        }
    }
    else if(gamedata.endurancequsnum<=15){
        int ran  = arc4random()%3;
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
    }
    else{
        answer = num1*num2;
        operator =[NSString stringWithFormat:@"x"];
    }
    
    NSLog(@"answer=%d",answer);
    NSString *num1str = [NSString stringWithFormat:@"%d",num1];
    NSString *num2str = [NSString stringWithFormat:@"%d",num2];
    CCLabelTTF *num1lbl = [CCLabelTTF labelWithString:num1str fontName:@"Times-Bold" fontSize:38];
    CCLabelTTF *num2lbl = [CCLabelTTF labelWithString:num2str fontName:@"Times-Bold" fontSize:38];
    CCLabelTTF *optlbl = [CCLabelTTF labelWithString:operator fontName:@"Times-Bold" fontSize:34];
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
    counterlbl = [CCLabelTTF labelWithString:@"4.00" fontName:@"Times-Bold" fontSize:20];
    counterlbl.color = ccRED;
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        counterlbl.fontSize = 40;
    }
    counterlbl.position = ccp(300*DevicewidthRatio,450*DeviceheightRatio);
    [self addChild:counterlbl];
    counter = 4.0f;
    
    NSString *qusnumstr = [NSString stringWithFormat:@"Q : %d",gamedata.endurancequscounter];
    CCLabelTTF *qusnumlbl = [CCLabelTTF labelWithString:qusnumstr fontName:@"Times-Bold" fontSize:24];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        qusnumlbl.fontSize = 48;
    }
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        qusnumlbl.fontSize = 24*2;
    }
    qusnumlbl.position = ccp(160*DevicewidthRatio,455*DeviceheightRatio);
    [self addChild:qusnumlbl];

    
    CCMenuItemImage    *backitem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(back:)];
    CCMenu *back  = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(50*DevicewidthRatio,440*DeviceheightRatio);
    [self addChild:back];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        countDownEffectId = [[SimpleAudioEngine sharedEngine]playEffect:@"Ticking.mp3"];
    [self schedule:@selector(countdown:) interval:0.1];
}

-(void)createTutorialBaseView{
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Focustxt"];
    
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
          scrollView.frame = CGRectMake(DeviceWidth/5, DeviceHeight/8, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-100);
    }
    [tutorialView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
//    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
//    sprintTextImageView.image= sprintTextImage;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    [scrollView addSubview:sprintTextImageView];
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
    [self mainViewofEndurance];
}


-(void)back:(id)sender{
    gamedata.endurancequsnum=1;
    gamedata.endurancequscounter=1;
    [self unschedule:@selector(countdown:)];
      [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[BrainArenaMenu scene]]];
}

-(void)countdown:(ccTime)dt{
       counter=counter-0.1;
      if(counter<0){
            isCLicked = true;
          [[SimpleAudioEngine sharedEngine]stopEffect:countDownEffectId];
         /*   NSLog(@"endurancequsnum=%d",gamedata.endurancequscounter);
            NSString *ansnumqus = [NSString stringWithFormat:@"You have correctly answered %i Consecutive Questions",gamedata.endurancequscounter];
            CCLabelTTF *failed = [CCLabelTTF labelWithString:ansnumqus fontName:@"Times" fontSize:20];
            failed.position = ccp(160,240);
            [self addChild:failed];
            gamedata.endurancequsnum=1;
            //gamedata.endurancequscounter=1;
                 [self unschedule:@selector(countdown:)];*/
        [self fail];
        }
      else {
          
          counterlbl.string =[NSString stringWithFormat:@"%.1f",counter];
      }

    
}
-(void)Answer:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    if(!isCLicked){
        
    CCMenuItemImage  *btn = (CCMenuItemImage*)sender;
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
    [[SimpleAudioEngine sharedEngine]stopEffect:countDownEffectId];
    isCLicked = true;
    [self unschedule:@selector(countdown:)];
    //int ansval = [ans intValue];
    NSString *answerString = [NSString stringWithFormat:@"%d",answer];
    if([ans isEqualToString:answerString]){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine sharedEngine]playEffect:@"CorrectAns.mp3"];
        
        gamedata.endurancequsnum++;
        gamedata.endurancequscounter++;
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[Endurance scene]]];
    }
    else{
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine  sharedEngine]playEffect:@"WrongAns.mp3"];
        [self fail];
        
        NSLog(@"Now Checking.... Endurance");
        if ([[GameData GameDataManager] getendurancetry] ==1)
        {
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Focus" message:@"You have completed your first FOCUS game. Remember : You have 4 seconds to answer each question.. The more you answer, the Higher your gains. Concentrate!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 2;
        [BMAlert show];
        [BMAlert release];
             NSLog(@"Now Checking.... Endurance 1 Confirmed");
        }
        
        else if ([[GameData GameDataManager] getendurancetry]==10 && ![[GameData GameDataManager] returnpremium])
        {
            //NSLog(@"TARAAAdAAAAAA");
            UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Excellent !" message:@"You have Completed 10 Focus Games. Check your Statistics in the Intelligence Statistics Page (Profile). \nHint: Upgrading to Premium will increase your daily Energy significantly, allow you to buy Keys, and remove the cap on your progress. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            BMAlert.tag = 3;
            [BMAlert show];
            [BMAlert release];
        }
        
        else if ([[GameData GameDataManager] getendurancetry]==20 && [[GameData GameDataManager] returnpremium] && (![[GameData GameDataManager] returnkeyofenergy] || ![[GameData GameDataManager] returnkeyofstrength]))
        {
            //NSLog(@"TARAAAdAAAAAA");
            UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have Completed 20 Focus Games. \nRemember: The Key of Energy increases your daily Energy significantly, reduces the Energy cost of everything, and Unlocks the Well. The Key of Strength increases your Brain Arena Gains, Reduces your Brain Arena Energy costs, and Improves the Well of Energy and the Tree of Knowledge." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            BMAlert.tag = 5;
            [BMAlert show];
            [BMAlert release];
        }

        


       /*   [self unschedule:@selector(countdown:)];
        NSString *ansnumqus = [NSString stringWithFormat:@"You have correctly answered %d Consecutive Questions",gamedata.endurancequscounter-1];
        CCLabelTTF *failed = [CCLabelTTF labelWithString:ansnumqus fontName:@"Times" fontSize:15];
        failed.position = ccp(160,440);
        [self addChild:failed];
        gamedata.endurancequsnum=1;
       gamedata.endurancequscounter=1;*/
    }
     
}

-(void)alertView :(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 && alertView.tag==1){
           }
    else if (buttonIndex ==0 && alertView.tag==2)
    {
        
    }
}

-(void)fail{
    Score *sc =[[Score alloc]init];
    [sc EnduranceFinsh:gamedata.endurancequscounter];
    [self calculateScore:gamedata.endurancequscounter];
    [self unschedule:@selector(countdown:)];
    gamedata.endurancequsnum=1;
    gamedata.endurancequscounter=1;
}

-(void)calculateScore:(NSInteger)qusnum{
    NSLog(@"qusnummm=%d",qusnum);
    int g;
    int k;
    float knop;
    float gold;
    knop = [gamedata returnknop];
    gold = [gamedata returngold];
    BOOL kos;
    kos = [gamedata returnkeyofstrength];
    if(qusnum-1>=25){
        g=8;
        k=3;
    }
    else if(qusnum-1>=21){
        g=4;
        k=2;
    }
    else if(qusnum-1>=18){
        g = 3;
        k = 1;
    }
    else if(qusnum-1>=15){
        g=2;
        k=1;
    }
    else if(qusnum-1>=10){
        g=1;
        k=0;
    }
    else{
        g=0;
        k=0;
    }
    if(g!=0)
        g=g+2*kos;
    if(k!=0)
        k=k+kos;
   // [gamedata setEndurancebest:qusnum-1];
    if(![gamedata returnpremium]){
        [self showAd];
    }
    [self showScoreLayer:g :k];
}

-(void)showAd{
    int probabilityOfChartBoost = arc4random()%100;
    int probabilityOfRevmob = arc4random()%100;
    if(probabilityOfChartBoost<70 && [[GameData GameDataManager] getendurancetry]>(4)){
          if ([[GameData GameDataManager] returnknop]>15)
              [Chartboost showInterstitial:CBLocationGameOver];
    }
    else if(probabilityOfRevmob<80 && [[GameData GameDataManager] getendurancetry]>(4)){
          if ([[GameData GameDataManager] returnknop]>15)
        [[RevMobAds session] showFullscreen];
    }
}

-(void)setLevel:(int)k{
    int level = 0;
    if(k>=5 && k<100)
        level=1;
    else if(k>=100 && k<220)
        level=2;
    else if(k>=220 && k<360)
        level=3;
    else if(k>=360 && k<600)
        level=4;
    else if(k>=600 && k<900)
        level=5;
    else if(k>=900 && k<1200)
        level=6;
    else if(k>=1200 &&k<1600)
        level=7;
    else if(k>=1600 && k<2000)
        level=8;
    else if(k>=2000 && k<2500)
        level=9;
    else if(k>=2500)
        level=10;
    [gamedata setLevel:level];
}

-(void)delloc{
    
    [super dealloc];
}

-(void)showScoreLayer:(float)g :(float)k{
       
    CCSprite *bg = [CCSprite spriteWithFile:@"scorebg.png"];
    bg.position = ccp(160*DevicewidthRatio,200*DeviceheightRatio);
    [self addChild:bg];
    
    NSString *ansnumqus = [NSString stringWithFormat:@"You have correctly answered %d Consecutive Questions",gamedata.endurancequscounter-1];
    CCLabelTTF *failed = [CCLabelTTF labelWithString:ansnumqus fontName:@"Times-Bold" fontSize:20 dimensions:CGSizeMake(200, 240) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeWordWrap];
       failed.position = ccp(140,100);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        failed.fontSize = 40;
        failed.dimensions = CGSizeMake(400, 400);
        failed.position = ccp(250,110*DevicewidthRatio);
    }
 
    failed.color = ccBLACK;
    [bg addChild:failed];
    
    CCLabelTTF *yourReawarLabel = [CCLabelTTF labelWithString:@"Your Reward :"  fontName:@"Times" fontSize:20];
    yourReawarLabel.position = ccp(120,110);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        yourReawarLabel.position = ccp(120*DevicewidthRatio,110*DeviceheightRatio);
        yourReawarLabel.fontSize = 40;
    }
    yourReawarLabel.color = ccBLACK;
    [bg addChild:yourReawarLabel];
    CCLabelTTF *knoplbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"KNOPs: %.f",k] fontName:@"Times-Bold" fontSize:22];
    knoplbl.position = ccp(140,80);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        knoplbl.position = ccp(140*DevicewidthRatio,80*DeviceheightRatio);
        knoplbl.fontSize = 40;
    }

    knoplbl.color = ccBLUE;
    [bg addChild:knoplbl];
    CCLabelTTF *goldlbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Gold    : %.f",g] fontName:@"Times-Bold" fontSize:22];
    goldlbl.position = ccp(140,50);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldlbl.position = ccp(140*DevicewidthRatio,50*DeviceheightRatio);
        goldlbl.fontSize = 40;
    }

    goldlbl.color = ccBLUE;
    [bg addChild:goldlbl];
    
    id fadeIn = [CCFadeIn actionWithDuration:0.1];
    id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
    id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
    id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
    id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
    [bg runAction:pulse];
    
    
        /*  BrainArenaResult *kr = [BrainArenaResult node];
         [self addChild:kr];*/
    }



@end
