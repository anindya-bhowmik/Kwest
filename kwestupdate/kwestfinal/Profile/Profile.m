//
//  Profile.m
//  kwest
//
//  Created by Aitl on 1/15/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "Profile.h"
#import "BasePopUpView.h"
#import "Score.h"
#import "OptionView.h"
#import <RevMobAds/RevMobAds.h>
#import "Utility.h"
#import "FBShareViewController.h"
#import "InAppPurchase.h"
#import "Chartboost.h"
#import "KnowledgePathstat.h"
#define alreadyHave 4
#define keyofwisdombtntag 14
#define keyofstrengthbtntag 15
#define keyofenergybtntag 16
#define goldPopup     222222
#define UScorePopUpTag 200

#define premiumAlert 17

@implementation Profile

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Profile *layer = [Profile node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self = [super init]){
                [self createMainView];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
                [self createTutorialBaseView];
                [self createProfileTutorialView];
            }
        if(![[GameData GameDataManager]returnpremium]){
            [self showAd];
        }
        
    }
    return self;
}

-(void)showAd{
    if ([[GameData GameDataManager] returnknop]>60)
    {
    int probabilityOfChartBoost = arc4random()%100;
    int probabilityOfRevmob = arc4random()%100;
    if(probabilityOfChartBoost<30){
        [[Chartboost sharedChartboost]showInterstitial];
    }
    else if(probabilityOfRevmob<40){
        [[RevMobAds session] showFullscreen];
    }
    }
}


-(void)createTutorialBaseView{
    [self disableTouch];
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
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
     
    [UIView animateWithDuration:1.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
}

-(void)onEnter{
    [super onEnter];
    //[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"HeartBeat.mp3"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        if([[SimpleAudioEngine sharedEngine]willPlayBackgroundMusic]) {
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"HeartBeat.mp3" loop:YES];
        
    }

}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

-(void)createProfileTutorialView{
    UIImage *sprintTextImage = [UIImage imageNamed:@"Profiletxt"];
    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
   UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/12.8, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
     scrollView.frame = CGRectMake(DeviceWidth/12, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-100);
    }
    
    
    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = NO;
    [scrollView addSubview:sprintTextImageView];
    float xmargin =(tutorialBackgroundImageView.frame.size.width -(attributeButtonImage.size.width+statisticsButtonImage.size.width))/3;
    
    UIButton *attributesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attributesButton.frame = CGRectMake(xmargin+5,DeviceHeight/2.18, attributeButtonImage.size.width, attributeButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
        attributesButton.frame = CGRectMake(xmargin+5,DeviceHeight/2.5, attributeButtonImage.size.width, attributeButtonImage.size.height);
    }

    // attributesButton.tag = keyofwisdombtntag;
    [attributesButton setBackgroundImage:attributeButtonImage forState:UIControlStateNormal];
    [attributesButton addTarget:self action:@selector(showAttribuesTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:attributesButton];
    
    UIButton *statisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    statisticsButton.frame = CGRectMake(attributesButton.frame.size.width+xmargin+10,DeviceHeight/2.18, statisticsButtonImage.size.width, statisticsButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
       statisticsButton.frame = CGRectMake(attributesButton.frame.size.width+xmargin+10,DeviceHeight/2.5, statisticsButtonImage.size.width, statisticsButtonImage.size.height);
    }
    //keyodStrengthButton.tag = keyofstrengthbtntag;
    [statisticsButton setBackgroundImage:statisticsButtonImage forState:UIControlStateNormal];
    [statisticsButton addTarget:self action:@selector(showStatisticsTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:statisticsButton];

    UIButton *boostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2,(DeviceHeight/2.18)+statisticsButton.frame.size.height+10, boostButtonImage.size.width, boostButtonImage.size.height);
    // keyofEnergyButton.tag = keyofenergybtntag;
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
        boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2,(DeviceHeight/2.5)+statisticsButton.frame.size.height+10, boostButtonImage.size.width, boostButtonImage.size.height);
    }
    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:boostButton];


}

-(void)createBoostSubTutorial:(int)num ShowBoostButton :(BOOL)status{
    [self clearTutorialView];
    
    UIImage *beyondTextImage = [UIImage imageNamed:[NSString stringWithFormat:@"boostSubtutorialtext%d",num]];
    
    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/16, DeviceHeight/16, beyondTextImage.size.width, beyondTextImage.size.height)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        beyondTextImageView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, beyondTextImage.size.width, beyondTextImage.size.height);
    }
    beyondTextImageView.image = beyondTextImage;
    [tutorialBackgroundImageView addSubview:beyondTextImageView];
    
    UIButton *boostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, DeviceHeight/1.71, boostButtonImage.size.width, boostButtonImage.size.height);
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, 290, boostButtonImage.size.width, boostButtonImage.size.height);
//    }
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
        boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, DeviceHeight/2, boostButtonImage.size.width, boostButtonImage.size.height);
    }

    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
    boostButton.hidden = status;
    [tutorialBackgroundImageView addSubview:boostButton];
    
}


-(void)showStatisticsTutorial{
  [self clearTutorialView];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Statisticstxt"];
   
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/12.8, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height-60);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
     scrollView.frame = CGRectMake(DeviceWidth/12, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height-100);
    }
    
    
    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    [scrollView addSubview:sprintTextImageView];
//    float xmargin =(tutorialBackgroundImageView.frame.size.width -(attributeButtonImage.size.width+statisticsButtonImage.size.width))/3;

//    sprintTextImageView.image = [UIImage imageNamed:@"Statisticstxt"];
//    sc
}

-(void)showAttribuesTutorial{
    [self clearTutorialView];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Attributestxt"];
   
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/12.8, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/12, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);
    }
    
    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, scrollView.frame.size.height+sprintTextImage.size.height/1.5);
    [scrollView addSubview:sprintTextImageView];
    //    float xmargin =(tutorialBackgroundImageView.frame.size.width -(attributeButtonImage.size.width+statisticsButtonImage.size.width))/3;
    
    //    sprintTextImageView.image = [UIImage imageNamed:@"Statisticstxt"];
    //    sc
}


-(void)showBoosttutorial{
    [self clearTutorialView];
    UIImage *boostTextImage = [UIImage imageNamed:@"Booststxt"];
    
    
    UIImage *keyofWisdomButtonImage = [UIImage imageNamed:@"Key_Wisdom_but"];
    UIImage *keyofEnergyButtonImage = [UIImage imageNamed:@"Key_Energy_but"];
    UIImage *keyofStrengthButtonImage = [UIImage imageNamed:@"Key_Strength_but"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/12.8, DeviceHeight/16, boostTextImage.size.width, boostTextImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/12, DeviceHeight/16, boostTextImage.size.width, boostTextImage.size.height);
    }

    [tutorialBackgroundImageView addSubview:scrollView];
    UIImageView *beyondSubTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, boostTextImage.size.width, boostTextImage.size.height)];
    beyondSubTextImageView.image = boostTextImage;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [scrollView addSubview:beyondSubTextImageView];
    
    float xmargin =(tutorialBackgroundImageView.frame.size.width -(keyofWisdomButtonImage.size.width+keyofStrengthButtonImage.size.width))/3;
    
    
    UIButton *keyodWisdomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyodWisdomButton.frame = CGRectMake(xmargin+5,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    keyodWisdomButton.tag = keyofwisdombtntag;
    [keyodWisdomButton setBackgroundImage:keyofWisdomButtonImage forState:UIControlStateNormal];
    [keyodWisdomButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:keyodWisdomButton];
    
    UIButton *keyodStrengthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyodStrengthButton.frame = CGRectMake(keyodWisdomButton.frame.size.width+xmargin+10,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    keyodStrengthButton.tag = keyofstrengthbtntag;
    [keyodStrengthButton setBackgroundImage:keyofStrengthButtonImage forState:UIControlStateNormal];
    [keyodStrengthButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:keyodStrengthButton];
    
    UIButton *keyofEnergyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyofEnergyButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-keyofEnergyButtonImage.size.width/2,beyondSubTextImageView.frame.size.height+keyodStrengthButton.frame.size.height+40, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    keyofEnergyButton.tag = keyofenergybtntag;
    [keyofEnergyButton setBackgroundImage:keyofEnergyButtonImage forState:UIControlStateNormal];
    [keyofEnergyButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:keyofEnergyButton];
    
}

-(void)showBoostSubTutorial:(id)sender{
    //[self clearTutorialView];
    UIButton *btn = (UIButton*)sender;
    [self createBoostSubTutorial:btn.tag-13 ShowBoostButton:NO];
//    UIImage *beyondTextImage = [UIImage imageNamed:[NSString stringWithFormat:@"boostSubtutorialtext%d",btn.tag-13]];
//    
//    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
//    
//    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, beyondTextImage.size.width, beyondTextImage.size.height)];
//    beyondTextImageView.image = beyondTextImage;
//    [tutorialBackgroundImageView addSubview:beyondTextImageView];
//    
//    UIButton *boostButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, 280, boostButtonImage.size.width, boostButtonImage.size.height);
//    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
//    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
//    [tutorialBackgroundImageView addSubview:boostButton];
}


-(void)showMainView{
    [UIView animateWithDuration:1.0 delay:0.6 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [tutorialView removeFromSuperview];
                         [self enableTouch];}];

 
}

-(void)clearTutorialView{
   // [scrollView removeFromSuperview];
    
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}


-(void)createMainView{
    
    [self enableTouch];
    gamedata = [GameData GameDataManager];
    Score *sc = [[Score alloc]init];
    [sc karmaCalculation];
    [sc release];
    
    float knop = [gamedata returnknop];
    float gold = [gamedata returngold];
    int energy = [gamedata returnenergy];
    int karma = [gamedata returnkarma];
    playerLabel = [gamedata returnlevel];
    NSString *log = [NSString stringWithFormat: @"Profile_Level_%i", playerLabel];
    [Flurry logEvent:log];
    NSString *knopstr = [NSString stringWithFormat:@"%d",(int)knop ];
    NSString *goldstr = [NSString stringWithFormat:@"%d",(int)gold];
    NSString *karmastr = [NSString stringWithFormat:@"%d",karma];
    NSString *energystr = [NSString stringWithFormat:@"%d",energy];
    
    bg = [CCSprite spriteWithFile:@"Profilebg.png"];
    bg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    bg.anchorPoint = ccp(0.5,0.5);
    [self addChild:bg];
    
    CCMenuItemImage *karmaItemMenu = [CCMenuItemImage itemWithNormalImage:@"Karma.png" selectedImage:@"Karma.png" target:self selector:@selector(showKarmaPopUp)];
    karmaItemPopUPMenu = [CCMenu menuWithItems:karmaItemMenu , nil];
   // CCSprite *karmaSprite =[CCSprite spriteWithFile:@"Karma.png"];
    karmaItemPopUPMenu.position = ccp(65*DevicewidthRatio,350*DeviceheightRatio);
    [bg addChild:karmaItemPopUPMenu];
    
    CCSprite *karmaBox = [CCSprite spriteWithFile:@"Box #3.png"];
    karmaBox.position = ccp(65*DevicewidthRatio,290*DeviceheightRatio);
    [bg addChild:karmaBox];
    
    CCMenuItemImage *karmaMenuItem = [CCMenuItemImage itemWithNormalImage:@"Box #3.png" selectedImage:@"Box #3.png" target:self selector:@selector(showKarmaPopUp)];
    CCMenu *karmaPopUpMenu = [CCMenu menuWithItems:karmaMenuItem, nil];
    karmaPopUpMenu.position = ccp(65*DevicewidthRatio,290*DeviceheightRatio);
    [bg addChild:karmaPopUpMenu];
    
    CCLabelTTF *karmalbl = [CCLabelTTF labelWithString:karmastr fontName:@"Helvetica" fontSize:12];
    karmalbl.position = ccp(63*DevicewidthRatio,295*DeviceheightRatio);
    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        karmalbl.position = ccp(63*DevicewidthRatio,294*DeviceheightRatio);
        karmalbl.fontSize = 24;
        
    }
    

    karmalbl.color = ccc3(1, 1, 1);
    [bg addChild:karmalbl];
    
    CCMenuItemImage *goldItemMenu = [CCMenuItemImage itemWithNormalImage:@"Gold.png" selectedImage:@"Gold.png" target:self selector:@selector(showGoldPopUp)];
    goldItemPopUPMenu = [CCMenu menuWithItems:goldItemMenu , nil];
   // CCSprite *goldSprite =[CCSprite spriteWithFile:@"Gold.png"];
    goldItemPopUPMenu.position = ccp(265*DevicewidthRatio,350*DeviceheightRatio);
    [bg addChild:goldItemPopUPMenu];
    
    CCMenuItemImage *goldMenuItem = [CCMenuItemImage itemWithNormalImage:@"Box #1.png" selectedImage:@"Box #1.png" target:self selector:@selector(showGoldPopUp)];
    CCMenu *goldPopUpMenu = [CCMenu menuWithItems:goldMenuItem, nil];
    goldPopUpMenu.position = ccp(265*DevicewidthRatio,290*DeviceheightRatio);
    [bg addChild:goldPopUpMenu];
    
    goldlbl = [CCLabelTTF labelWithString:goldstr fontName:@"Helvetica" fontSize:12];
    goldlbl.color = ccc3(1, 1, 1);
    goldlbl.position =  ccp(263*DevicewidthRatio,295*DeviceheightRatio);
    if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
        goldlbl.position = ccp(263*DevicewidthRatio,294*DeviceheightRatio);
    }

    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        goldlbl.position = ccp(263*DevicewidthRatio,293*DeviceheightRatio);
        goldlbl.fontSize = 24;
    }

    [bg addChild:goldlbl];
    
    CCMenuItemImage *knopItemMenu = [CCMenuItemImage itemWithNormalImage:@"KNOPs.png" selectedImage:@"KNOPs.png" target:self selector:@selector(showKnopPopUp)];
    knopItemPopUPMenu = [CCMenu menuWithItems:knopItemMenu , nil];
    //CCSprite *knopSprite =[CCSprite spriteWithFile:@"KNOPs.png"];
    knopItemPopUPMenu.position = ccp(165*DevicewidthRatio,430*DeviceheightRatio);
    [bg addChild:knopItemPopUPMenu];
    CCMenuItemImage *knopItemImage = [CCMenuItemImage itemWithNormalImage:@"Box #4.png" selectedImage:@"Box #4.png" target:self selector:@selector(showKnopPopUp)];
    CCMenu *knopMenu = [CCMenu menuWithItems:knopItemImage, nil];
    knopMenu.position = ccp(160*DevicewidthRatio,365*DeviceheightRatio);
    [bg addChild:knopMenu];
    
    CCLabelTTF *knoplbl = [CCLabelTTF labelWithString:knopstr fontName:@"Helvetica" fontSize:12];
    knoplbl.position = ccp(157*DevicewidthRatio,370*DeviceheightRatio);
    if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
        knoplbl.position = ccp(157*DevicewidthRatio,369*DeviceheightRatio);
    }
    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        knoplbl.position = ccp(157*DevicewidthRatio,368*DeviceheightRatio);
        knoplbl.fontSize = 24;
    }
    knoplbl.color = ccc3(1, 1, 1);
    [bg addChild:knoplbl];
    
    CCMenuItemImage *energyItemMenu = [CCMenuItemImage itemWithNormalImage:@"Energy.png" selectedImage:@"Energy.png" target:self selector:@selector(showEnergyPopUp)];
    energyItemPopUPMenu = [CCMenu menuWithItems:energyItemMenu, nil];
    //CCSprite *energySprite =[CCSprite spriteWithFile:@"Energy.png"];
    energyItemPopUPMenu.position = ccp(165*DevicewidthRatio,290*DeviceheightRatio);
    [bg addChild:energyItemPopUPMenu];
    
    CCMenuItemImage *energyMenuItem = [CCMenuItemImage itemWithNormalImage:@"Box #2.png" selectedImage:@"Box #2.png" target:self selector:@selector(showEnergyPopUp)];
    CCMenu *energyPopUpMenu = [CCMenu menuWithItems:energyMenuItem, nil];
    energyPopUpMenu.position = ccp(165*DevicewidthRatio,230*DeviceheightRatio);
    [bg addChild:energyPopUpMenu];
    
    
    CCLabelTTF *energylbl = [CCLabelTTF labelWithString:energystr fontName:@"Helvetica" fontSize:12];
    energylbl.position = ccp(161*DevicewidthRatio,235*DeviceheightRatio);
    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        energylbl.position = ccp(161*DevicewidthRatio,234*DeviceheightRatio);
        energylbl.fontSize = 24;
    }
    energylbl.color = ccc3(1, 1, 1);
    [bg addChild:energylbl];
    inAppMenuBg = [CCSprite spriteWithFile:@"TheRedbuttonandshadow.png"];
    inAppMenuBg.position = ccp(170*DevicewidthRatio,100*DeviceheightRatio);
    [bg addChild:inAppMenuBg];
    [self createFooterMenu];
}

-(void)createFooterMenu{
    
    CCMenuItemImage *levelitem = [CCMenuItemImage itemWithNormalImage:@"YellowButtonWithShadow.png" selectedImage:@"YellowButtonWithShadow.png" target:self selector:@selector(goToTowerofWisdom:)];
    profilemenu = [CCMenu menuWithItems:levelitem, nil];
    NSString *labelString = @"";
    switch (playerLabel) {
        case 1:
            labelString = @"st";
            break;
        case 2:
            labelString = @"nd";
            break;
        case 3:
            labelString = @"rd";
            break;
        default:
            labelString = @"th";
            break;
    }
    NSString *labelStr;
    if(playerLabel == 0){
        labelStr = @"Era - 0";
    }
    

    else{
        Myquslist *dbHandler = [[Myquslist alloc]init];

        labelStr = [NSString stringWithFormat:@"Era - %d : %@",playerLabel,[dbHandler getEraName:playerLabel]];
        [dbHandler release];
    }
    CCLabelTTF *label = [CCLabelTTF labelWithString:labelStr fontName:@"Times" fontSize:17];
    label.position = ccp(165*DevicewidthRatio,183*DeviceheightRatio);
    if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
        label.position = ccp(165*DevicewidthRatio,181*DeviceheightRatio);
    }
    else if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        label.position = ccp(165*DevicewidthRatio,182*DeviceheightRatio);
        label.fontSize = 34;
    }
    label.color = ccc3(1, 1, 1);
            profilemenu.position = ccp(165*DevicewidthRatio,175*DeviceheightRatio);
    
           [bg addChild:profilemenu];
        [bg addChild:label];
    
    energyitem = [CCMenuItemImage itemWithNormalImage:@"3Keys_Energy.png" selectedImage:@"3Keys_Energy.png" target:self selector:@selector(buyenergy:)];
    if(![[GameData GameDataManager]returnkeyofenergy])
        energyitem.opacity = 100;
    energyMenu = [CCMenu menuWithItems:energyitem, nil];
    
    energyMenu.position = ccp(51,49);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        energyMenu.position = ccp(43*DevicewidthRatio,46*DeviceheightRatio);
    }
    [inAppMenuBg addChild:energyMenu];
    
    strengthitem = [CCMenuItemImage itemWithNormalImage:@"3Keys_Strength.png" selectedImage:@"3Keys_Strength.png" target:self selector:@selector(buystrength:)];
    if(![[GameData GameDataManager] returnkeyofstrength])
        strengthitem.opacity = 100;
    
    strengthMenu = [CCMenu menuWithItems:strengthitem, nil];
    strengthMenu.position = ccp(107,49);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        strengthMenu.position = ccp(89*DevicewidthRatio,46*DeviceheightRatio);
    }
    [inAppMenuBg addChild:strengthMenu];
    
    wisdomitem = [CCMenuItemImage itemWithNormalImage:@"3Keys_Wisdom.png" selectedImage:@"3Keys_Wisdom.png" target:self selector:@selector(buywisdom:)];
    if(![[GameData GameDataManager]returnkeyofwisdom])
        wisdomitem.opacity = 100;
    wisdomMenu =[CCMenu menuWithItems:wisdomitem, nil];
    wisdomMenu.position = ccp(164 ,49);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        wisdomMenu.position = ccp(137*DevicewidthRatio,46*DeviceheightRatio);
    }
    [inAppMenuBg  addChild:wisdomMenu];
    
    CCMenuItemImage *homeitem = [CCMenuItemImage itemWithNormalImage:@"TheBackbuttonandshadow.png" selectedImage:@"TheBackbuttonandshadow.png" target:self selector:@selector(goToHome:)];
    
    homemenu = [CCMenu menuWithItems:homeitem, nil];
    homemenu.position = ccp(35*DevicewidthRatio,30*DeviceheightRatio);
    [self addChild:homemenu];
    
    
    //This Allows to go into Debug Mode
    //CCMenuItemImage *statitem = [CCMenuItemImage itemWithNormalImage:@"statisticbutton.png" selectedImage:@"statisticbutton.png" target:self selector:@selector(goToPlayerStat:)];
    
    CCMenuItemImage *statitem = [CCMenuItemImage itemWithNormalImage:@"statisticbutton.png" selectedImage:@"statisticbutton.png" target:self selector:@selector(goToPlayerStat:)];
    
    statisticsMenu = [CCMenu menuWithItems:statitem, nil];
    statisticsMenu.position = ccp(160*DevicewidthRatio,30*DeviceheightRatio);
    [bg addChild:statisticsMenu];
    
    CCMenuItemImage *uscoreItem = [CCMenuItemImage itemWithNormalImage:@"Box#5.png" selectedImage:@"Box#5.png" target:self selector:@selector(showUscorePopUp:)];
    uscoreMenu = [CCMenu menuWithItems:uscoreItem, nil];
    uscoreMenu.position = ccp(280*DevicewidthRatio,20*DeviceheightRatio);
    [bg addChild:uscoreMenu];
    sc = [[Score alloc]init];
    CCLabelTTF *uscoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",(int)[sc calculateUScore]] fontName:@"Times" fontSize:18 dimensions:CGSizeZero hAlignment:kCCTextAlignmentCenter];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        uscoreLabel.fontSize = 36;
    }
    uscoreLabel.position = ccp(283*DevicewidthRatio,23*DeviceheightRatio);
    uscoreLabel.color = ccBLACK;
    [bg addChild:uscoreLabel];
}

-(void)showKarmaPopUp{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    NSString *str = [NSString stringWithFormat:@"Your %d Karma points determine your luck in the game. \n\n Scale: 1 (min) to 10 (max)",[gamedata returnkarma]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Karma" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void)showGoldPopUp{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    NSString *str = [NSString stringWithFormat:@"Your wealth is %d pieces of Gold. ",(int)[gamedata returngold]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Gold" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Buy Gold", nil];
    alert.tag = goldPopup;
    [alert show];
    [alert release];
}

-(void)showEnergyPopUp{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    NSString *str = [NSString stringWithFormat:@"You have %d Energy Points remaining today.Your current daily Energy gain is %d",(int)[gamedata returnenergy],30 + 45*[gamedata returnpremium] + 50*[gamedata returnkeyofenergy]+3*([gamedata returnkarma]-5)];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Energy" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void)showKnopPopUp{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    NSString *str = [NSString stringWithFormat:@"You have earned %d KNOwledge Points",(int)[gamedata returnknop]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"KNOPs" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
}
-(void)showUscorePopUp:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"UScore" message:@"Your UScore is a comprehensive score that combines your Level, KNOPs, Gold, Karma, Quests, with all your Intelligence and Knowledge Statistics, into one value." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Share", nil];
    alert.tag = UScorePopUpTag;
    [alert show];
    [alert release];
}

-(void)enableTouch{
    homemenu.enabled = YES;
    statisticsMenu.enabled = YES;
    strengthMenu.enabled = YES;
    energyMenu.enabled = YES;
    wisdomMenu.enabled = YES;
    profilemenu.enabled = YES;
}

-(void)disableTouch{
    homemenu.enabled = NO;
    statisticsMenu.enabled = NO;
    strengthMenu.enabled = NO;
    energyMenu.enabled = NO;
    wisdomMenu.enabled = NO;
    profilemenu.enabled = NO;
}

-(void)goToPlayerStat:(id)sender{
 //This allows to go into debug mode
    //[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[PlayerInfo scene]]];
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[KnowledgePathstat scene]]];
}

-(void)goToTowerofWisdom:(id)sender{
 [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[NewTower scene]]];
}
-(void)goToHome:(id)sender{
[[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)buyenergy:(id)sender{
    [Flurry logEvent:@"EnergyClicked"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
    if([gamedata returnpremium]){
    if(![[GameData GameDataManager] returnkeyofenergy]){
        NSString *typestr = @"Do you want to buy the Key of Energy?It will cost you 1800 Pieces of Gold.";
        [self showAlert:typestr :energyalert];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Energy" message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag =alreadyHave;
        [alert show];
    }
    }
    else{
        [self showNoPremiumAlert];
    }
}

-(void)buywisdom:(id)sender{
    [Flurry logEvent:@"WisdomClicked"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
    if([gamedata returnpremium]){
        if(![[GameData GameDataManager] returnkeyofwisdom]){
            NSString *typestr = @"Do you want to buy the Key of Wisdom?It will cost you 1800 Pieces of Gold.";
            [self showAlert:typestr :wisdomalert];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Wisdom" message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag =alreadyHave;
            [alert show];
        }
    }
    else{
        [self showNoPremiumAlert];
    }
}

-(void)buystrength:(id)sender{
    [Flurry logEvent:@"StrengthClicked"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
    if([gamedata returnpremium]){
    if(![[GameData GameDataManager] returnkeyofstrength]){
        NSString *typestr = @"Do you want to buy the Key of Strength?It will cost you 1800 Pieces of Gold.";
        [self showAlert:typestr :strengthalert];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Strength" message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag =alreadyHave;
        [alert show];
    }
    }
    else{
        [self showNoPremiumAlert];
    }
    
}


-(void)showNoPremiumAlert{
    UIAlertView *noPremiumAlert = [[UIAlertView alloc]initWithTitle:@"Need Premium" message:@"To be able to buy keys you need to upgrade to Premium first. Do you want to Upgrade to Premium?" delegate:self  cancelButtonTitle:@"Why?" otherButtonTitles: @"Yes, Sure",@"No, Thanks",nil];
    noPremiumAlert.tag =premiumAlert;
    [noPremiumAlert show];
    [noPremiumAlert release];
}
-(void)showAlert:(NSString *)str :(int)type{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"In App Purchase" message:str delegate:self cancelButtonTitle:@"Why?" otherButtonTitles:@"Yes, Sure",@"No, Thanks", nil];
    alert.tag = type;
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == premiumAlert){
        if([title isEqualToString:@"Yes, Sure"]){
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[OptionView scene]]];
        }
        else if ([title isEqualToString:@"Why?"]){
            [self showReasonsForPremium];
        }

    }
    else if (alertView.tag == UScorePopUpTag){
        if([title isEqualToString:@"Share"]){
            [Flurry logEvent:@"UScore_Share"];
//            FBShareViewController* tweetComposer = [[FBShareViewController alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) IntialText:[NSString stringWithFormat:@"Total Score of %d via KWEST",(int)[sc calculateUScore]] ShareImage:[UIImage imageNamed:@"Default~ipad"] ShareUrl:[NSURL URLWithString:@"http://bit.ly/33kWst"]];
//            [[[CCDirector sharedDirector]view ]addSubview:tweetComposer.view];
//            [tweetComposer shareinFB:TRUE];
            
            
//            __block __weak SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            [slComposeViewController setInitialText:[NSString stringWithFormat:@"Total Score of %d via KWEST",(int)[sc calculateUScore]]];
//            [slComposeViewController addImage:[UIImage imageNamed:@"Default~ipad"]];
//            [slComposeViewController addURL:[NSURL URLWithString:@"http://bit.ly/33kWst"]];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:slComposeViewController animated:YES completion:nil];
//            
//            [slComposeViewController setCompletionHandler:^
//             (SLComposeViewControllerResult result){
//                 
//                 if (result == SLComposeViewControllerResultDone) {
////                     if(![[GameData GameDataManager]getFirstTimeShared]){
////                         [[GameData GameDataManager]setFirstTimeShared:TRUE];
////                         int currentGold = [[GameData GameDataManager]returngold];
////                         [[GameData GameDataManager]setgold:currentGold+50];
////                     }
//                     
//                 }
//                 else{
//                     NSLog(@"Cancelled");
//                 }
//                 
//                 [slComposeViewController dismissViewControllerAnimated:YES completion:nil];
//             }];
            [self performSelector:@selector(showShareSheet) withObject:nil afterDelay:0.7];

        }
    }
    else if(alertView.tag == goldPopup){
        if([title isEqualToString:@"Buy Gold"]){
            InAppPurchase *iApp = [[InAppPurchase alloc]init];
            [iApp showStoreInfo];
        }
    }
    else if(alertView.tag != UScorePopUpTag){
        if([title isEqualToString:@"Yes, Sure"]){
            if(alertView.tag==energyalert){
                [self performPurchase:energyalert];
//                [gamedata setkeyofenergy:YES];
//                energyitem.opacity = 255;
            }
            else if(alertView.tag == wisdomalert){
                [self performPurchase:wisdomalert];
//                [gamedata setkeyofwisdom:YES];
//                wisdomitem.opacity = 255;
            }
            else if(alertView.tag ==strengthalert){
                [self performPurchase:strengthalert];
//                [gamedata setkeyofstrength:YES];
//                strengthitem.opacity =255;
            }
        }
        else if([title isEqualToString:@"Why?"]){
            [self createTutorialBaseView];
            if(alertView.tag==energyalert){
                [self createBoostSubTutorial:3 ShowBoostButton:YES];
                
            }
            else if(alertView.tag == wisdomalert){
                [self createBoostSubTutorial:1 ShowBoostButton:YES];
            }
            else if(alertView.tag ==strengthalert){
                [self createBoostSubTutorial:2 ShowBoostButton:YES];
            }

        }
    }
}

-(void)showShareSheet{

    __block __weak SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slComposeViewController setInitialText:[NSString stringWithFormat:@"Achieved UScore of %d via KWEST",(int)[sc calculateUScore]]];
    [slComposeViewController addImage:[UIImage imageNamed:@"Default~ipad"]];
    [slComposeViewController addURL:[NSURL URLWithString:@"http://bit.ly/33kWst"]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:slComposeViewController animated:YES completion:nil];
    
    [slComposeViewController setCompletionHandler:^
     (SLComposeViewControllerResult result){
         
         if (result == SLComposeViewControllerResultDone) {
            // if(![[GameData GameDataManager]getFirstTimeShared]){
            //     [[GameData GameDataManager]setFirstTimeShared:TRUE];
             //    int currentGold = [[GameData GameDataManager]returngold];
            //     [[GameData GameDataManager]setgold:currentGold+50];
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook - Success" message:@"Thank you for Sharing." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alert show];
                 [alert release];
            // }
             
         }
         else{
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook - Fail" message:@"Sorry, Couldn't Post to Facebook." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
             [alert release];
         }
         
         [slComposeViewController dismissViewControllerAnimated:YES completion:nil];
     }];

}

-(void)showReasonsForPremium{
    [self disableTouch];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"PremiumVsBasic"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/4, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2, DeviceHeight/5, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//            tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+225, DeviceHeight/4.3, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//        }
//    }
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+90, DeviceHeight/4.3, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }
    
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    
}

-(void)performPurchase:(int)itemNumber{
  
    if([gamedata returngold]>=1800){
        [gamedata setgold:[gamedata returngold]-1800];
        goldlbl.string = [NSString stringWithFormat:@"%d",(int)[gamedata returngold]];
        NSString *identifier = @"";
        NSString *TitleString = @"Successful";
        NSString *message ;//= [NSString stringWithFormat:@"You have successfully Purchased the  %@",identifier];
        switch (itemNumber) {
            case energyalert:
                identifier = @"Key of Energy";
                [[GameData GameDataManager]setkeyofenergy:YES];
                energyitem.opacity = 255;
                message = @"Congrats ! You have acquired the Key of Energy, and your daily Energy will be much higher now, while everything will take less effort. For a quick energy boost, go Beyond, to the Well of Energy.";
                break;
            case wisdomalert:
                identifier = @"Key of Wisdom";
                [[GameData GameDataManager]setkeyofwisdom:YES];
                wisdomitem.opacity = 255;
                message = [NSString stringWithFormat:@"You have successfully Purchased the  %@",identifier];
                break;
            case strengthalert:
                identifier = @"Key of Strength";
                [[GameData GameDataManager]setkeyofstrength:YES];
                strengthitem.opacity = 255;
                message = [NSString stringWithFormat:@"You have successfully Purchased the  %@",identifier];
                break;
            default:
                break;
        }
//        NSString *TitleString = @"Successful";
//        NSString *message = [NSString stringWithFormat:@"You have successfully Purchased the  %@",identifier];
        UIAlertView *succesfulPurchaseAlert = [[UIAlertView alloc]initWithTitle:TitleString message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [succesfulPurchaseAlert show];
        [succesfulPurchaseAlert release];
    }else{
         inApp = [[InAppPurchase alloc]init];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InAppPurchase" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(purchaseSuccessful) name:@"InAppPurchase" object:nil];
        NSString *title = @"Not Enough Gold.";
        NSString *message = @"You need 1800 Pieces of Gold to Buy this Key. Do you want to Buy Gold? ";
        UIAlertView *buyGold = [[UIAlertView alloc]initWithTitle:title message:message delegate:inApp cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        buyGold.tag = BuyGoldAlert;
        [buyGold show];
    }
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InAppPurchase" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(purchaseSuccessful) name:@"InAppPurchase" object:nil];
   
//    [inApp startPurchaseWithIdentifier:identifier];
    
}
-(void)purchaseSuccessful{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InAppPurchase" object:nil];
    goldlbl.string = [NSString stringWithFormat:@"%d",(int)[gamedata returngold]];
}

//-(void)purchaseSuccessful{
//    if([identifier isEqualToString:@"energykey"]){
//        [Flurry logEvent:@"EnergyBought"];
//        [[GameData GameDataManager]setkeyofenergy:YES];
//        energyitem.opacity = 255;
//    }
//    else if([identifier isEqualToString:@"wisdomkey"]){
//        [Flurry logEvent:@"WisdomBought"];
//        [[GameData GameDataManager]setkeyofwisdom:YES];
//        wisdomitem.opacity = 255;
//    }
//    else if ([identifier isEqualToString:@"strengthkey"]){
//        [Flurry logEvent:@"StrengthBought"] ;
//        [[GameData GameDataManager]setkeyofstrength:YES];
//        strengthitem.opacity = 255;
//    }
//}

@end
