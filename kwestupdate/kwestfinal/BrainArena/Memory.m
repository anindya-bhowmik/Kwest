//
//  Memory.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "Memory.h"
#import "Menu.h"
#import "Score.h"
#import "Utility.h"
#import "Chartboost.h"
#import <RevMobAds/RevMobAds.h>
#import "BrainArenaMenu.h"

@implementation Memory
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    Memory *layer = [Memory node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}
-(id)init{
    if(self =[super init]){
        [Flurry logEvent:@"Memory"] ;
        gamedata = [GameData GameDataManager];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"] && gamedata.isTutorialShown == FALSE){
            [self createTutorialBaseView];
        }
        else {
            [self mainViewofMemory];
        }
    }
    return self;
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:coundownEffectId];
}

-(void)mainViewofMemory{
    CCSprite *bg =[CCSprite spriteWithFile:@"brainarenabg.png"];
    bg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:bg];
    isCLicked = false;
    bool israndom = false;
  
    stat = [PlayerStatistics StatManager];
    counter = 0.0f;
    long long int n1 =pow(10, (gamedata.memoryn-1));
    long long int n2 = pow(10, gamedata.memoryn)-1;
    NSLog(@"n1=%lld",n1);
    NSLog(@"n2=%lld",n2);
    NSLog(@"ansbefore=%llu",answer);
    while (!israndom) {
        answer = (arc4random()%(n2))+n1;
        if (answer<n2) {
            israndom = true;
        }
    }
   
    displayText = [CCLabelTTF labelWithString:@"Memorize this Number :" fontName:@"Times-Bold" fontSize:30];
    displayText.position = ccp(160*DevicewidthRatio,320*DeviceheightRatio);
    displayText.color = ccGRAY;
    [self addChild:displayText];
    NSLog(@"answer=%lld",answer);
    NSString *qusstr = [NSString stringWithFormat:@"%lld",answer];
    quslbl =[CCLabelTTF labelWithString:qusstr fontName:@"Times-Bold" fontSize:38];
    quslbl.position = ccp(160*DevicewidthRatio,280*DeviceheightRatio);
    [self addChild:quslbl];
    anslbl = [CCLabelTTF labelWithString:@"" fontName:@"Times-Bold" fontSize:38];
    anslbl.position = ccp(160*DevicewidthRatio,300*DeviceheightRatio);
    [self addChild:anslbl];
    NSString *counterstr = [NSString stringWithFormat:@"%f",counter];
    counterlbl = [CCLabelTTF labelWithString:counterstr fontName:@"Times" fontSize:20];
    counterlbl.position = ccp(300*DevicewidthRatio,450*DeviceheightRatio);
    [self addChild:counterlbl];
    counter = 0;
    displaycounter = gamedata.memorycounter+2;
    if(displaycounter ==2)
        displaycounter = 2.1;
    NSString *qusnumstr = [NSString stringWithFormat:@"Q-%d",gamedata.memoryquscounter];
    CCLabelTTF *qusnumlbl = [CCLabelTTF labelWithString:qusnumstr fontName:@"Times" fontSize:24];
    qusnumlbl.position = ccp(160*DevicewidthRatio,455*DeviceheightRatio);
    [self addChild:qusnumlbl];
    NSString *labelString = [NSString stringWithFormat:@"Level %d",gamedata.memoryquscounter];
    displayLabel = [CCLabelTTF labelWithString:labelString fontName:@"Times-Bold" fontSize:30];
    displayLabel.position = ccp(160*DevicewidthRatio,380*DeviceheightRatio);
    displayLabel.color = ccGRAY;
    [self addChild:displayLabel];
    CCMenuItemImage    *backitem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(back:)];
    CCMenu *back  = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(50*DevicewidthRatio,440*DeviceheightRatio);
    [self addChild:back];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        coundownEffectId = [[SimpleAudioEngine sharedEngine]playEffect:@"Ticking.mp3"];
    [self schedule:@selector(countdown:) interval:0.1f];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        anslbl.fontSize = 38*2;
        counterlbl.fontSize = 40;
        displayLabel.fontSize = 30*2;
        quslbl.fontSize = 38*2;
        displayText.fontSize = 60;
        qusnumlbl.fontSize = 48;
    }

}

-(void)createTutorialBaseView{
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Memorytxt"];
    
    tutorialView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.backgroundColor = [UIColor blackColor];
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    /*if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+225, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }*/
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+30, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);}
    
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/8, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    ;
    if ([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]) {
        scrollView.frame = CGRectMake(DeviceWidth/5.8, DeviceHeight/8, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-100);
        ;    }
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    sprintTextImageView.image= sprintTextImage;
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
    gamedata.isTutorialShown = TRUE;
    [tutorialView removeFromSuperview];
    [self mainViewofMemory];
}



-(void)back:(id)sender{
    [self unschedule:@selector(countdown:)];
    gamedata.memorycounter=1;
    gamedata.memoryn =2;
    gamedata.memoryquscounter=1;
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[BrainArenaMenu scene]]];
}


-(void)Answer:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    if(!isCLicked){
        CCMenuItem *btn = (CCMenuItemImage*)sender;
        if(btn.tag!=10 && btn.tag!=12){
           // NSLog(@"tag=%d",btn.tag);
            NSString *str;
            if(![anslbl.string length]<=0){
                str = anslbl.string;
                [anslbl setString:[NSString stringWithFormat:@"%@%d",str,btn.tag]];
            }
            else{
                [anslbl setString:[NSString stringWithFormat:@"%d",btn.tag]];
            }
        }
        else if(btn.tag==10){
            NSString *str1 = anslbl.string;
            NSLog(@"str=%@",str1);
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
    isCLicked=true;
    long long int ansval = [ans longLongValue];
    if(ansval==answer){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine  sharedEngine]playEffect:@"CorrectAns.mp3"];
        gamedata.previousmemoryn=gamedata.memoryn;
        gamedata.previouscounter = gamedata.memorycounter;
        gamedata.memoryquscounter++;
        if(gamedata.memorycounter==0){
            gamedata.memorycounter=1;
            gamedata.memoryn++;
        }
        else if(gamedata.memorycounter==1){
            
            gamedata.memorycounter=0;
        }
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[Memory scene]]];
    }
    else{
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            [[SimpleAudioEngine  sharedEngine]playEffect:@"WrongAns.mp3"];
        
        Score *sc = [[Score alloc]init];
        [sc MemoryFinish:gamedata.previousmemoryn LevelCompleted:gamedata.memoryquscounter];
        [self calculateScore];
       
        gamedata.memorycounter=1;
        gamedata.memoryn =2;
        gamedata.memoryquscounter=1;
        gamedata.previouscounter=0;
    }
}

-(void)calculateScore{
    float g=0.0f;
    float k=0.0f;
//    float knop = [gamedata returnknop];
//    float gold = [gamedata returngold];
    BOOL kos = [gamedata returnkeyofstrength];
    if(gamedata.previousmemoryn<6){
        g=0;
        k=0;
    }
    else if(gamedata.previousmemoryn==6){
        g=1;
        k=0;
    }
    else if(gamedata.previousmemoryn==7){
        g=(1+(1-gamedata.previouscounter));
        k=0;
    }
    else if(gamedata.previousmemoryn==8){
        g=(2+(1-gamedata.previouscounter));
        k=1;
    }
    else if(gamedata.previousmemoryn>=9){
        g=(3+(1-gamedata.previouscounter)+(gamedata.previousmemoryn-8));
        k=2;
    }
    if(g!=0){
        g= g+2*kos;
    }
    if(k!=0){
        k= k+kos;
    }
 
    //[gamedata setknop:knop];
    //[gamedata setgold:gold];
    //[self setLevel:knop];
    //[gamedata setMemorybest:gamedata.previousmemoryn];
    // [self karmaCalculation];
    if(![gamedata returnpremium]){
        [self showAd];
    }
    [self showScoreLayer:g:k];
}

-(void)showAd{
    int probabilityOfChartBoost = arc4random()%100;
    int probabilityOfRevmob = arc4random()%100;
    if(probabilityOfChartBoost<70){
          if ([[GameData GameDataManager] returnknop]>15)
              [[Chartboost sharedChartboost]showInterstitial];
    }
    else if(probabilityOfRevmob<80){
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

-(void)countdown:(ccTime)dt{
   // NSLog(@"counter=%.1f",counter);
     counter+=0.1;
    if(counter<=displaycounter)
            counterlbl.string = [NSString stringWithFormat:@"%.1f",counter];
    
    
    else{
        [[SimpleAudioEngine sharedEngine]stopEffect:coundownEffectId];
        [self unschedule:@selector(countdown:)];
        displayText.string = @"The Number was :";
        displayText.position = ccp(160*DevicewidthRatio,380*DeviceheightRatio);
        [self removeChild:displayLabel cleanup:YES];
        quslbl.visible = false;
        [self addButtons];
    }
}

-(void)addButtons{
    
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

-(void)showScoreLayer:(float)g :(float)k{
    CCSprite *bg = [CCSprite spriteWithFile:@"scorebg.png"];
    bg.position = ccp(160*DevicewidthRatio,200*DeviceheightRatio);
    [self addChild:bg];
    NSString *ansnumqus;
    if(gamedata.memoryquscounter-1>0){
        ansnumqus = [NSString stringWithFormat:@"You have reached level %d and  remembered up to %lld digit numbers",gamedata.memoryquscounter-1,gamedata.previousmemoryn];
    }
    else{
    ansnumqus = @"You didn't remember any number and didn't earn a reward. Try again.";
    }
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
