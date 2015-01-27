//
//  Beyond.m
//  kwest
//
//  Created by Future Tech on 4/28/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "Beyond.h"
#import "Menu.h"
#import "GameData.h"
//#import "ResolutionConstant.h"
#import "BasePopUpView.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>
#import "OptionView.h"
#import <RevMobAds/RevMobAds.h>
#import "InAppPurchase.h"
#import "Score.h"
#import "Chartboost.h"
#define slider_Min 80.0f
#define slider_Max 190.0f

#define energyalert 1
#define wisdomalert 2
#define strengthalert 3

#define alreadyHave 4

#define oracleCommonAlert 5
#define oracleFirstDealAlert 6
#define oracleConverSationAlert 7
#define rightOneCharge 8
#define rightTwoCharge 9
#define rightThreeCharge 10
#define rightFourCharge 11
#define rightFiveCharge 12
#define rightSixCharge 13

#define keyofwisdombtntag 14
#define keyofstrengthbtntag 15
#define keyofenergybtntag 16
#define premiumAlert 17

@implementation Beyond
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    Beyond *layer = [Beyond node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(id)init{
    if(self = [super init]){
        gameData = [GameData GameDataManager];
        
        [self showMainViewofBeyond];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
            [self createTutorialBaseView];
            [self showBeyondTutorial];
        }
        
        if(![gameData returnpremium]){
            [self showAd];
        }
        
    }
    return self;
}

-(void)showAd{
    
      if ([[GameData GameDataManager] returnknop]>30)
      {
          int probabilityOfChartBoost = arc4random()%100;
          int probabilityOfRevmob = arc4random()%100;
          if(probabilityOfChartBoost<30){
              [[Chartboost sharedChartboost]showInterstitial];
          }
          else if(probabilityOfRevmob<20){
              [[RevMobAds session] showFullscreen];
          }
      }
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        effectID = [[SimpleAudioEngine sharedEngine]playEffect:@"Beyond.mp3"];
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:effectID];
}


-(void)showMainViewofBeyond{
    [self initilize];
    [self enableTouch];
    UIImage *slider = [UIImage imageNamed:@"thesliders"];
    NSLog(@"sliderwidth%f",slider.size.width);
    UIImage *stretchLeftTrack = [[UIImage imageNamed:@"sliderImage.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]; //progress12.png
    UIImage *stretchRightTrack = [[UIImage imageNamed:@"sliderImage.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]; //rightSLider12.png
    ok1Pressed = FALSE;
    ok2Pressed = FALSE;
    beyondBg = [CCSprite spriteWithFile:@"background.png"];
    beyondBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:beyondBg];
    // self.enabled = YES;
    
    CCMenuItemImage *oracleItem  = [CCMenuItemImage itemWithNormalImage:@"Oracle.png" selectedImage:@"Oracle.png" target:self selector:@selector(talkToOracle)];
    oracleMenu = [CCMenu menuWithItems:oracleItem, nil];
    //CCSprite *oracleBg = [CCSprite spriteWithFile:@"Oracle.png"];
    oracleMenu.position =ccp(160*DevicewidthRatio,100*DeviceheightRatio);
    [beyondBg addChild:oracleMenu];
    
    
    CCMenuItemImage *backitem =[CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(back:)];
    back = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(55*DevicewidthRatio,50*DeviceheightRatio);
    [self addChild:back];
    
    CCSprite *wellofenergy  = [CCSprite spriteWithFile:@"well of energy_box.png"];
    wellofenergy.position = ccp(160*DevicewidthRatio,210*DeviceheightRatio);
    [self addChild:wellofenergy];
    
    CCMenuItemImage *slider2StepDown = [CCMenuItemImage itemWithNormalImage:@"fake.png" selectedImage:@"fake.png" target:self selector:@selector(decreaseSliderTwoValue)];
    CCMenu *slider2StepDownMenu =[CCMenu menuWithItems:slider2StepDown, nil];
    slider2StepDownMenu.position = ccp(37,55);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        slider2StepDownMenu.position = ccp(70,110);
    }
    [wellofenergy addChild:slider2StepDownMenu];
    
    
    CCMenuItemImage *slider2StepUp = [CCMenuItemImage itemWithNormalImage:@"fake.png" selectedImage:@"fake.png" target:self selector:@selector(increaseSliderTwoValue)];
    CCMenu *slider2StepUpMenu =[CCMenu menuWithItems:slider2StepUp, nil];
    slider2StepUpMenu.position = ccp(210,55);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        slider2StepUpMenu.position = ccp(420,110);
        
    }
    [wellofenergy addChild:slider2StepUpMenu];
    
    CCMenuItemImage *goldToEnergyDoneBtn = [CCMenuItemImage itemWithNormalImage:@"OK1.png" selectedImage:@"OK1pressed.png" target:self selector:@selector(doneButtonPressed:)];
    goldToEnergyDoneBtn.tag = 0;
    CCMenu *goldToEnergyDoneBtnMenu = [CCMenu menuWithItems:goldToEnergyDoneBtn, nil];
    goldToEnergyDoneBtnMenu.position = ccp(255,45);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToEnergyDoneBtnMenu.position = ccp(510,45*DeviceheightRatio);
    }
    
    [wellofenergy addChild:goldToEnergyDoneBtnMenu];
    //        CCSprite *ok1 = [CCSprite spriteWithFile:@"OK1.png"];
    //        ok1.position = ccp(265,55);
    //        [wellofenergy addChild:ok1];
    
    sliderTwo  = [[UISlider alloc]initWithFrame:CGRectMake(DeviceWidth/4.0f, DeviceHeight/1.97, 125.0f, 25.0f)];
    sliderTwo.alpha = 0.0;
    if([[Utility getInstance].deviceType isEqualToString:@"-568h"]){
        sliderTwo.frame  = CGRectMake(DeviceWidth/4.0f, DeviceHeight/1.94, 125.0f, 25.0f);
    }
    else if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        sliderTwo.frame  = CGRectMake(DeviceWidth/3.5f, DeviceHeight/1.9f, 250, 25.0f);
    }
    [sliderTwo setMinimumTrackImage:stretchLeftTrack forState:UIControlStateNormal];
    [sliderTwo setMaximumTrackImage:stretchRightTrack forState:UIControlStateNormal];
    [sliderTwo setThumbImage:slider forState:UIControlStateNormal];
    // [sliderOne  setMinimumTrackImage:stretchRightTrack forState:UIControlStateNormal];
    //        if([gameData returnkeyofenergy])
    //            sliderTwo.userInteractionEnabled = NO;
    sliderTwo.minimumValue = 0.0;
    sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
    sliderTwo.value = 0;
    sliderTwo.continuous = YES;
    
    [sliderTwo addTarget:self action:@selector(slider2Moved:) forControlEvents:UIControlEventValueChanged];
    
    [[[CCDirector sharedDirector]view ]addSubview:sliderTwo];
    
    CCSprite *box1 = [CCSprite spriteWithFile:@"SmallBox.png"];
    box1.position = ccp(38,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        box1.position = ccp(32*DevicewidthRatio,20*DeviceheightRatio);
    }
    [wellofenergy addChild:box1];
    
    goldToEnergyLbl1  = [CCLabelTTF labelWithString:@"0" fontName:@"Times" fontSize:14];
    goldToEnergyLbl1.position = ccp(38,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToEnergyLbl1.fontSize = 28;
        goldToEnergyLbl1.position = ccp(32*DevicewidthRatio,20*DeviceheightRatio);
    }
    [wellofenergy   addChild:goldToEnergyLbl1];
    CCSprite *box2 =  [CCSprite spriteWithFile:@"SmallBox.png"];
    box2.position = ccp(208,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        box2.position = ccp(172*DevicewidthRatio,20*DeviceheightRatio);
    }
    [wellofenergy addChild:box2];
    goldToEnergyLbl2  = [CCLabelTTF labelWithString:@"0" fontName:@"Times" fontSize:14];
    goldToEnergyLbl2.position = ccp(208,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToEnergyLbl2.fontSize = 28;
        goldToEnergyLbl2.position = ccp(172*DevicewidthRatio,20*DeviceheightRatio);
    }
    [wellofenergy   addChild:goldToEnergyLbl2];
    
    CCSprite *knowledBoxtree	  = [CCSprite spriteWithFile:@"tree of knowledge_box.png"];
    knowledBoxtree.position = ccp(160*DevicewidthRatio,315*DeviceheightRatio);
    [self addChild:knowledBoxtree];
    
    CCMenuItemImage *slider1StepDown = [CCMenuItemImage itemWithNormalImage:@"fake.png" selectedImage:@"fake.png" target:self selector:@selector(decreaseSliderOneValue)];
    CCMenu *slider1StepDownMenu =[CCMenu menuWithItems:slider1StepDown, nil];
    slider1StepDownMenu.position = ccp(37*DevicewidthRatio,55*DeviceheightRatio);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        slider1StepDownMenu.position = ccp(30*DevicewidthRatio,50*DeviceheightRatio);
        
    }
    else if([[[Utility    getInstance]deviceType]isEqualToString:iPhone5]){
        slider1StepDownMenu.position = ccp(37*DevicewidthRatio,45*DeviceheightRatio);
        
    }
    
    [knowledBoxtree addChild:slider1StepDownMenu];
    
    
    CCMenuItemImage *slider1StepUp = [CCMenuItemImage itemWithNormalImage:@"fake.png" selectedImage:@"fake.png" target:self selector:@selector(increaseSliderOneValue)];
    CCMenu *slider1StepUpMenu =[CCMenu menuWithItems:slider1StepUp, nil];
    slider1StepUpMenu.position = ccp(210*DevicewidthRatio,55*DeviceheightRatio);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        slider1StepUpMenu.position = ccp(175*DevicewidthRatio,50*DeviceheightRatio);
        
    }
    else if([[[Utility    getInstance]deviceType]isEqualToString:iPhone5]){
        slider1StepUpMenu.position = ccp(210*DevicewidthRatio,45*DeviceheightRatio);
        
    }
    
    [knowledBoxtree addChild:slider1StepUpMenu];
    
    CCMenuItemImage *goldToKnopDoneBtn = [CCMenuItemImage itemWithNormalImage:@"Ok2.png" selectedImage:@"Ok2pressed.png" target:self selector:@selector(doneButtonPressed:)];
    goldToKnopDoneBtn.tag = 1;
    CCMenu *goldToKnopDoneBtnMenu = [CCMenu menuWithItems:goldToKnopDoneBtn, nil];
    goldToKnopDoneBtnMenu.position = ccp(255,45);
    if([[[Utility    getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToKnopDoneBtnMenu.position = ccp(510,45*DeviceheightRatio);
    }
    [knowledBoxtree addChild:goldToKnopDoneBtnMenu];
    
    //        CCSprite *ok3 = [CCSprite spriteWithFile:@"Ok2.png"];
    //        ok3.position = ccp(265,55);
    //        [knowledBoxtree addChild:ok3];
    
    
    
    sliderOne  = [[UISlider alloc]initWithFrame:CGRectMake(DeviceWidth/4, DeviceHeight/3.5, 125.0f, 25.0f)];
    if ([[Utility getInstance].deviceType isEqualToString:iPhone5]) {
        sliderOne.frame =CGRectMake(DeviceWidth/4, DeviceHeight/3.4, 125.0f, 25.0f);
    }
    else if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        sliderOne.frame  = CGRectMake(DeviceWidth/3.5, DeviceHeight/3.25, 250.0f, 25.0f);
    }
    [sliderOne setMinimumTrackImage:stretchLeftTrack forState:UIControlStateNormal];
    [sliderOne setMaximumTrackImage:stretchRightTrack forState:UIControlStateNormal];
    [sliderOne setThumbImage:slider forState:UIControlStateNormal];
    // [sliderOne  setMinimumTrackImage:stretchRightTrack forState:UIControlStateNormal];
    
    sliderOne.minimumValue = 0.0;
    
    int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
    if ([[GameData GameDataManager]returnknop]+max > 1200)
        max=1200-[[GameData GameDataManager] returnknop];
    
    sliderOne.maximumValue = max;
    sliderOne.value = 0;
    sliderOne.continuous = YES;
    sliderOne.alpha = 0.0;
    [sliderOne addTarget:self action:@selector(slider1Moved:) forControlEvents:UIControlEventValueChanged];
    
    [[[CCDirector sharedDirector]view ]addSubview:sliderOne];
    
    
    CCSprite *box3 = [CCSprite spriteWithFile:@"SmallBox.png"];
    box3.position = ccp(38,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        box3.position = ccp(32*DevicewidthRatio,20*DeviceheightRatio);
    }
    [knowledBoxtree addChild:box3];
    goldToKnopLbl1  = [CCLabelTTF labelWithString:@"0" fontName:@"Times" fontSize:14];
    goldToKnopLbl1.position = ccp(38,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToKnopLbl1.fontSize = 28;
        goldToKnopLbl1.position = ccp(32*DevicewidthRatio,20*DeviceheightRatio);
    }
    [knowledBoxtree addChild:goldToKnopLbl1];
    CCSprite *box4 =  [CCSprite spriteWithFile:@"SmallBox.png"];
    box4.position = ccp(208,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        box4.position = ccp(172*DevicewidthRatio,20*DeviceheightRatio);
    }
    [knowledBoxtree addChild:box4];
    goldToKnopLbl2  = [CCLabelTTF labelWithString:@"0" fontName:@"Times" fontSize:14];
    goldToKnopLbl2.position = ccp(208,20);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldToKnopLbl2.fontSize = 28;
        goldToKnopLbl2.position = ccp(172*DevicewidthRatio,20*DeviceheightRatio);
    }
    [knowledBoxtree addChild:goldToKnopLbl2];
    
    CCSprite *topBtn =  [CCSprite spriteWithFile:@"Top-Red Button with shadow.png"];
    topBtn.position = ccp(160*DevicewidthRatio,420*DeviceheightRatio);
    [self addChild:topBtn];
    
    wisdomitem = [CCMenuItemImage itemWithNormalImage:@"key1.png" selectedImage:@"key1.png" target:self selector:@selector(buywisdom:)];
    wisdomMenu = [CCMenu menuWithItems:wisdomitem, nil];
    if(![[GameData GameDataManager]returnkeyofwisdom])
        wisdomitem.opacity = 100;
    wisdomMenu.position = ccp(237.5,62);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        wisdomMenu.position = ccp(197*DevicewidthRatio,59*DeviceheightRatio);
    }
    [topBtn addChild:wisdomMenu];
    
    strengthitem = [CCMenuItemImage itemWithNormalImage:@"key2.png" selectedImage:@"key2.png" target:self selector:@selector(buystrength:)];
    if(![[GameData GameDataManager]returnkeyofstrength])
        strengthitem.opacity = 100;
    strengthMenu = [CCMenu menuWithItems:strengthitem, nil];
    strengthMenu.position = ccp(148.5,62);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        strengthMenu.position = ccp(124*DevicewidthRatio,59*DeviceheightRatio);
    }
    [topBtn addChild:strengthMenu];
    
    energyitem = [CCMenuItemImage itemWithNormalImage:@"key3.png" selectedImage:@"key3.png" target:self selector:@selector(buyenergy:)];
    if(![[GameData GameDataManager]returnkeyofenergy])
        energyitem.opacity = 100;
    energyMenu =[CCMenu menuWithItems:energyitem, nil];
    energyMenu.position = ccp(56 ,62);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        energyMenu.position = ccp(49*DevicewidthRatio,59*DeviceheightRatio);
    }
    [topBtn  addChild:energyMenu];
    
    [UIView animateWithDuration:2.0 delay:0.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         sliderOne.alpha = 1;
                         sliderTwo.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    
}

-(void)decreaseSliderTwoValue{
    if([gameData returnkeyofenergy]){
        sliderTwo.value --;
        [goldToEnergyLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderTwo.value*(3-[gameData returnkeyofstrength]))]];
        [goldToEnergyLbl2 setString:[NSString stringWithFormat:@"%d",(int)sliderTwo.value]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Well of Energy (Convert Gold to Energy) ONLY if you have the Key of Energy." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = alreadyHave;
        [alert show];
        sliderTwo.value = sliderTwo.minimumValue;
    }
    
}

-(void)increaseSliderTwoValue{
    if([gameData returnkeyofenergy]){
        sliderTwo.value++;
        [goldToEnergyLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderTwo.value*(3-[gameData returnkeyofstrength]))]];
        [goldToEnergyLbl2 setString:[NSString stringWithFormat:@"%d",(int)sliderTwo.value]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Well of Energy (Convert Gold to Energy) ONLY if you have the Key of Energy." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = alreadyHave;
        [alert show];
        sliderTwo.value = sliderTwo.minimumValue;
    }
}

-(void)decreaseSliderOneValue{
    if([gameData returnlevel]<8){
        if([gameData returnkeyofwisdom]){
            sliderOne.value --;
            [goldToKnopLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderOne.value*(5-2*[gameData returnkeyofstrength]))]];
            [goldToKnopLbl2 setString:[NSString stringWithFormat:@"%d",(int)sliderOne.value]];
            NSLog(@"sliderOneValue = %f",sliderTwo.value);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Tree of Knowledge (Convert Gold to KNOPs) ONLY if you have the Key of Wisdom." message:@"\n" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            alert.tag = alreadyHave;
            [alert show];
            sliderOne.value = sliderOne.minimumValue;
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Interesting..." message:@"Since you've reached the Era of Intuition, you have realized that true knowledge lies elsewhere.." delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles: nil];
        [alert show];
        
    }
    
}

-(void)increaseSliderOneValue{
    if([gameData returnlevel]<8){
        if([gameData returnkeyofwisdom]){
            sliderOne.value++;
            [goldToKnopLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderOne.value*(5-2*[gameData returnkeyofstrength]))]];
            [goldToKnopLbl2 setString:[NSString stringWithFormat:@"%d",(int)sliderOne.value]];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Tree of Knowledge (Convert Gold to KNOPs) ONLY if you have the Key of Wisdom." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = alreadyHave;
            [alert show];
            sliderOne.value = sliderOne.minimumValue;
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Interesting..." message:@"Since you've reached the Era of Intuition, you have realized that true knowledge lies elsewhere.." delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles: nil];
        [alert show];
        
    }
}



-(void)initilize{
    oracleFirstsay = [[NSMutableArray alloc]init];
    [oracleFirstsay addObject:@"Hello Stranger (We all are). What do you need today?"];
    [oracleFirstsay addObject:@"YES?"];
    [oracleFirstsay addObject:@"Another lost soul.. What mysterious word do you have now?"];
    [oracleFirstsay addObject:@"We all wish we could see more… How can I help?"];
    
    oracleRightAnswerArray = [[NSMutableArray alloc]init];
    NSArray *array = [[NSArray alloc]initWithObjects:@"003002002",@"So You've seen the disc. Ok, leave 35 pieces of Gold at the door and come back.", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    array = [[NSArray alloc]initWithObjects:@"1341",@"Ahh Yes.. Struggling with Matrix of Letters. You have to Pay 35 pieces of Gold to proceed.", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    
    array = [[NSArray alloc]initWithObjects:@"24",@"You are looking for X. With 40 Pieces of Gold I might be able to help.", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    
    array = [[NSArray alloc]initWithObjects:@"sfumato",@"Haha ...Everything can seem so foggy. Leave 45 pieces of Gold at the altar and come back.", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    array = [NSArray arrayWithObjects:@"1.618",@"Gold. The Dream of Alchemists. Gold doesn't mean the gold. Do you have 50 pieces of Gold to listen to my advice?", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    array = [[NSArray alloc]initWithObjects:@"beauty",@"beauty.. Well, that is your answer - you don't always need me!", nil];
    [oracleRightAnswerArray addObject:array];
    [array release];
    NSLog(@"oracleRightAnswerArray= %@",oracleRightAnswerArray
          );
    oracleSecondSayForWrong = [[NSMutableArray alloc]init];
    [oracleSecondSayForWrong addObject:@"Nonsense"];
    [oracleSecondSayForWrong addObject:@"I have no idea what that is. Try again, or search some more and come back when you have something"];
    [oracleSecondSayForWrong addObject:@"That won’t lead you anywhere"];
    [oracleSecondSayForWrong addObject:@"That isn’t Right"];
    
}

- (void)slider1Moved:(UISlider *)sender {
    if([gameData returnlevel]<8){
        if([gameData returnkeyofwisdom]){
            sliderOne.value = floor(sender.value);
            [goldToKnopLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderOne.value*(5-2*[gameData returnkeyofstrength]))]];
            //This is how it was weirdly, and I replaced it with Value
            //[goldToKnopLbl2 setString:[NSString stringWithFormat:@"%d",(int)sender.value]];
            [goldToKnopLbl2 setString:[NSString stringWithFormat:@"%d",(int) sliderOne.value]];
            NSLog(@"The Label is (should be 1000) : %i", (int)sliderOne.value);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Tree of Knowledge (Convert Gold to KNOPs) ONLY if you have the Key of Wisdom." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = alreadyHave;
            [alert show];
            sliderOne.value = sliderOne.minimumValue;
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Interesting..." message:@"Since you've reached the Era of Intuition, you have realized that true knowledge lies elsewhere.." delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles: nil];
        [alert show];
        
    }
    
}
- (void)slider2Moved:(UISlider *)sender {
    if([gameData returnkeyofenergy]){
        
        sliderTwo.value = floor(sender.value);
        [goldToEnergyLbl1 setString:[NSString stringWithFormat:@"%d",(int)(sliderTwo.value*(3-[gameData returnkeyofstrength]))]];
        //[goldToEnergyLbl2 setString:[NSString stringWithFormat:@"%d",(int)sender.value]];
        [goldToEnergyLbl2 setString:[NSString stringWithFormat:@"%d",(int)sliderTwo.value]];

        NSLog(@"sliderOneValue = %f",sliderTwo.value);
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Well of Energy (Convert Gold to Energy) ONLY if you have the Key of Energy." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = alreadyHave;
        [alert show];
        sliderTwo.value = sliderTwo.minimumValue;
    }
    
}
-(void)doneButtonPressed:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
    
    NSString *alertString = @"";
    NSString *alertTitle  = @"";
    CCMenuItemImage *btn = (CCMenuItemImage*)sender;
    if(btn.tag == 0){
        if([gameData returnkeyofenergy]){
            alertTitle = @"Well of Energy";
            [Flurry logEvent:@"WellOfEnergy"];
            alertString = [NSString stringWithFormat:@"Do you confirm transforming %d Gold to %d Energy?",(int)(sliderTwo.value*(3-[gameData returnkeyofstrength])),(int)sliderTwo.value];
            ok1Pressed = TRUE;
            ok2Pressed = FALSE;
            UIAlertView *confirmAlert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
            confirmAlert.tag = 0;
            [confirmAlert show];
            [confirmAlert release];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Well of Energy (Convert Gold to Energy) ONLY if you have the Key of Energy." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
    else if(btn.tag == 1){
        [Flurry logEvent:@"TreeOfKnowledge"];
        if([gameData returnlevel]<8){
            if([gameData returnkeyofwisdom ]){
                alertTitle = @"Tree of Knowledge";
                alertString = [NSString stringWithFormat:@"Do you confirm transforming %d Gold to %d KNOPs?",(int)(sliderOne.value*(5-2*[gameData returnkeyofstrength])),(int)sliderOne.value];
                ok1Pressed = FALSE;
                ok2Pressed = TRUE;
                UIAlertView *confirmAlert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
                confirmAlert.tag = 0;
                [confirmAlert show];
                [confirmAlert release];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You can use the Tree of Knowledge (Convert Gold to KNOPs) ONLY if you have the Key of Wisdom." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [alert release];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not Interesting..." message:@"Since you've reached the Era of Intuition, you have realized that true knowledge lies elsewhere.." delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
    NSLog(@"string = %@",alertString);
    
    
}
-(void)buyenergy:(id)sender{
    [Flurry logEvent:@"EnergyClicked"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
    
    if([[GameData GameDataManager] returnpremium]){
        if(![[GameData GameDataManager] returnkeyofenergy]){
            NSString *typestr = @"Do you want to buy the Key of Energy? It will cost you 1800 Pieces of Gold.";
            [self showAlert:typestr :energyalert];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Energy." message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    if([[GameData GameDataManager] returnpremium]){
        if(![[GameData GameDataManager] returnkeyofwisdom]){
            NSString *typestr = @"Do you want to buy the Key of Wisdom? It will cost you 1800 Pieces of Gold.";
            [self showAlert:typestr :wisdomalert];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Wisdom." message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    if([[GameData GameDataManager] returnpremium]){
        if(![[GameData GameDataManager] returnkeyofstrength]){
            NSString *typestr = @"Do you want to buy the Key of Strength? It will cost you 1800 Pieces of Gold.";
            [self showAlert:typestr :strengthalert];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"You already have the Key of Strength." message:@"\n " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Get This Key" message:str delegate:self cancelButtonTitle:@"Why?" otherButtonTitles:@"Yes, Sure",@"No, Thanks", nil];
    alert.tag = type;
    [alert show];
    [alert release];
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
//
//    if([title isEqualToString:@"Ok"]){
//        if(alertView.tag==energyalert)
//           [[GameData GameDataManager]setkeyofenergy:YES];
//
//        else if(alertView.tag == wisdomalert)
//            [[GameData GameDataManager]setkeyofwisdom:YES];
//        else if(alertView.tag ==strengthalert)
//            [[GameData GameDataManager]setkeyofstrength:YES];
//    }
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if(alertView.tag == 0){
        if(buttonIndex == 1){
            if(ok1Pressed){
                
                [gameData setgold:[gameData returngold]-(int)(sliderTwo.value*(3-[gameData returnkeyofstrength]))];
                 [gameData setEnergy:(int)(sliderTwo.value + [gameData returnenergy])];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
            }
            else if(ok2Pressed){
                NSLog(@"The Value is (KNOP) : %i" , (int) sliderOne.value);
                [gameData setgold:[gameData returngold]-(sliderOne.value*(5-2*[gameData returnkeyofstrength]))];
                [gameData setknop:(sliderOne.value + [gameData returnknop])];
                Score *sc = [[Score alloc]init];
                [sc setLevel:[gameData returnknop]];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                
                
                
            }
            
            sliderOne.value = 0.0;
            sliderTwo.value = 0.0;
            int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
            if ([[GameData GameDataManager]returnknop]+max > 1200)
                max=1200-[[GameData GameDataManager] returnknop];
            
            sliderOne.maximumValue = max;
            sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
            [goldToKnopLbl1 setString:@"0"];
            [goldToKnopLbl2 setString:@"0"];
            [goldToEnergyLbl1 setString:@"0"];
            [goldToEnergyLbl2 setString:@"0"];
        }
    }
    
    else if([title isEqualToString:@"Pay"]){
        if(alertView.tag  == oracleFirstDealAlert){
            [gameData setgold:[gameData returngold]-2];
            int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
            if ([[GameData GameDataManager]returnknop]+max > 1200)
                max=1200-[[GameData GameDataManager] returnknop];
            
            sliderOne.maximumValue = max;
            sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
            [self startConversation];
        }
        else if (alertView.tag == rightOneCharge){
            if([self goldAvailable:35.0f]){
                [gameData setgold:[gameData returngold]-35];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                [self oracleAdviceOne];
            }
            else{
                [self showAlertToBuyGold];
            }
        }
        else if (alertView.tag == rightTwoCharge){
            if([self goldAvailable:35.0f]){
                [gameData setgold:[gameData returngold]-35];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                [self oracleAdviceTwo];
            }
            else{
                [self showAlertToBuyGold];
            }
            
        }
        else if (alertView.tag == rightThreeCharge){
            if([self goldAvailable:40]){
                [gameData setgold:[gameData returngold]-40];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                [self oracleAdviceThree];
            }
            else{
                [self showAlertToBuyGold];
            }
            
        }
        else if (alertView.tag == rightFourCharge){
            if([self goldAvailable:45]){
                [gameData setgold:[gameData returngold]-45];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                [self oracleAdviceFour];
            }
            else{
                [self showAlertToBuyGold];
            }
            
        }
        else if (alertView.tag == rightFiveCharge){
            if([self goldAvailable:50]){
                [gameData setgold:[gameData returngold]-50];
                int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
                if ([[GameData GameDataManager]returnknop]+max > 1200)
                    max=1200-[[GameData GameDataManager] returnknop];
                
                sliderOne.maximumValue = max;
                sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
                [self oracleAdviceFive];
            }
            else{
                [self showAlertToBuyGold];
            }
            
        }
    }
    else if(alertView.tag == oracleConverSationAlert){
        if([title isEqualToString:@"Say"]){
            UITextField *answerTextField = [alertView textFieldAtIndex:0];
            answerText = answerTextField.text;
            // answerText = [answerText lowercaseString];
            //answerText = answertextField.text;
            [self checkAnswer];
            //BOOL isRight =  [self checkAnswer];
            // NSLog(@"isRight%d",isRight);
            //            if(isRight){
            //                [self showNextDeal];
            //            }
            //            else {
            //                [self showFailAlert];
            //            }
        }
    }
    else if (alertView.tag == premiumAlert){
        if([title isEqualToString:@"Yes, Sure"]){
            [sliderOne removeFromSuperview];
            [sliderTwo removeFromSuperview];
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[OptionView scene]]];
        }
        else if ([title isEqualToString:@"Why?"]){
            [self showReasonsForPremium];
        }
        
    }
    else if(alertView.tag != alreadyHave){
        if([title isEqualToString:@"Yes, Sure"]){
            if(alertView.tag==energyalert){
                [self performPurchase:energyalert];
                //                   [[GameData GameDataManager]setkeyofenergy:YES];
                //                   energyitem.opacity = 255;
            }
            
            else if(alertView.tag == wisdomalert){
                [self performPurchase:wisdomalert];
                //                   [[GameData GameDataManager]setkeyofwisdom:YES];
                //                   wisdomitem.opacity = 255;
            }
            else if(alertView.tag ==strengthalert){
                [self performPurchase:strengthalert];
                //                   [[GameData GameDataManager]setkeyofstrength:YES];
                //                   strengthitem.opacity = 255;
            }
        }
        else if([title isEqualToString:@"Why?"]){
            [self createTutorialBaseView];
            if(alertView.tag==energyalert){
                //[self showBeyondTutorial];
                
                [self createBoostSubTutorial:3 ShowBoostButton:YES];
            }
            //
            else if(alertView.tag == wisdomalert){
                [self createBoostSubTutorial:1 ShowBoostButton:YES];
            }
            else if(alertView.tag ==strengthalert){
                [self createBoostSubTutorial:2 ShowBoostButton:YES];
                
            }
            
        }
    }
}

-(BOOL)goldAvailable:(float)goldRequired{
    if([gameData returngold]-goldRequired<0){
        return FALSE;
    }
    else{
        return TRUE;
    }
}

-(void)showAlertToBuyGold{
    InAppPurchase *inApp = [[InAppPurchase alloc]init];
    NSString *title = @"Not Enough Gold.";
    NSString *message = @"You don't have Enough Gold. Do you want to Buy Gold? ";
    UIAlertView *buyGold = [[UIAlertView alloc]initWithTitle:title message:message delegate:inApp cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    buyGold.tag = BuyGoldAlert;
    [buyGold show];
}


-(void)performPurchase:(int)itemNumber{
    
    if([gameData returngold]>=1800){
        [gameData setgold:[gameData returngold]-1800];
        int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
        if ([[GameData GameDataManager]returnknop]+max > 1200)
            max=1200-[[GameData GameDataManager] returnknop];
        
        sliderOne.maximumValue = max;
        sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
        NSString *identifier = @"";
        NSString *TitleString = @"Successful";
        NSString *message;// = [NSString stringWithFormat:@"You have successfully Purchased the  %@",identifier];
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
        InAppPurchase *inApp = [[InAppPurchase alloc]init];
        NSString *title = @"Not Enough Gold";
        NSString *message = @"You need 1800 Pieces of Gold to Buy this Key. Do you want to Buy Gold? ";
        UIAlertView *buyGold = [[UIAlertView alloc]initWithTitle:title message:message delegate:inApp cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        buyGold.tag = BuyGoldAlert;
        [buyGold show];
    }
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InAppPurchase" object:nil];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(purchaseSuccessful) name:@"InAppPurchase" object:nil];
    
    //    [inApp startPurchaseWithIdentifier:identifier];
    
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
//        [Flurry logEvent:@"StrengthBought"];
//        [[GameData GameDataManager]setkeyofstrength:YES];
//        strengthitem.opacity = 255;
//    }
//}

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
    //        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+225, DeviceHeight/4.3, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    //    }
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

-(void)showNextDeal{
    NSLog(@"SUCCESS");
}

-(void)showFailAlert{
    NSLog(@"FAIL");
    int ran =   arc4random()%3;
    NSString *alertString = [oracleSecondSayForWrong objectAtIndex:ran];
    UIAlertView * failAlert = [[UIAlertView alloc]initWithTitle:alertString message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [failAlert show];
}

-(void)checkAnswer{
    if([[answerText lowercaseString] isEqualToString:@"003002002"]){
        
        [self oracleDemandOne];
    }
    else if([answerText isEqualToString:@"1341"]){
        
        [self oracleDemandTwo];
    }
    else if([answerText isEqualToString:@"24"]){
        
        [self oracleDemandThree];
    }
    else if([[answerText lowercaseString] isEqualToString:@"sfumato"]){
        
        [self oracleDemandFour];
    }
    else if([answerText isEqualToString:@"1.618"]){
        
        [self oracleDemandFive];
    }
    else if([[answerText lowercaseString] isEqualToString:@"beauty"]){
        [self oracleDemandSix];
        
    }
    else if([self codeCheck]==1) {
        [Flurry logEvent:@"OracleUnlock"];
        UIAlertView *alert;
        if(![gameData returnpremium]){
            [gameData setpremium:YES];
            [gameData setEnergy:75];
            alert = [[UIAlertView alloc] initWithTitle: @"Correct Code" message: @"That code is correct. Your App is now upgraded to Premium." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else{
            alert = [[UIAlertView alloc] initWithTitle: @"Correct Code" message: @"Your app has already been upgraded to Premium." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else if([self easterCodeCheck]!=0){
        
        UIAlertView *alert;
        NSString *alertTitle;
        NSString *alertText;
        alertTitle = @"Bonus";
        if ([gameData getEasterFlag] == 0) {
            [gameData setEnergy:[gameData returnenergy]+25];
            [gameData setgold:[gameData returngold]+10];
            int max=floor([gameData returngold]/(5-2*[gameData returnkeyofstrength]));
            if ([[GameData GameDataManager]returnknop]+max > 1200)
                max=1200-[[GameData GameDataManager] returnknop];
            
            sliderOne.maximumValue = max;
            sliderTwo.maximumValue = MIN (500,floor([gameData returngold]/(3-[gameData returnkeyofstrength])));
            [gameData setknop:[gameData returnknop]+5];
            [gameData setEasterFlag:1];
            // Increase Energy by 25 , Gold by 10 , and KNOPs by 5
            
            alertText = @"Good Work ! You are granted 25 Extra Energy, 10 Gold, 5 KNOPs.";
            // Display Alert With Title 'Bonus'  and text : "Good Work ! You are granted 25 Extra Energy, 10 Gold, 5 KNOPs."
            
            // Set corresponding Flag in the flags table to 1
            
            // Flurry log EasterEgg }
            
            // else if (Easter_flag ==1) {
            
            // Display Alert with Title 'Bonus' , Saying : "You have already availed this Bonus. You get it only once."}
        }
        else if([gameData getEasterFlag] == 1){
            alertText = @"You have already availed this Bonus. You get it only once.";
        }
        alert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    else{
        [self showFailAlert];
    }
}

-(int) easterCodeCheck{
    
    NSString *readString;
    readString= answerText; // We will use the code that the user enters to the oracle here .. it is answerText in your code
    
    // readString is the code (NSString format) that the user enters ... Here we are using entry from the textField
    
    // Correct codes have the format of xcRLNcd1 or xcRLNcd2
    
    int flag=1;
    
    char a[8];
    
    if (readString.length != 8){
        flag=0;
        for (int i=0;i<8;i++)
            a[i]=' ';
        return flag;
    }
    else{
        for (int index=0;index<8;index++){
            a[index]=[readString characterAtIndex:index];
            //    a[index]='1';
        }
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    //NSInteger day = [components day];
    NSInteger month = [components month];
    //NSInteger year = [components year];
    
    
    //        Display.text=[NSString stringWithFormat:@"Month is %d and Year is %d .. a[5] is: %c", month,year,a[5]];
    
    
    
    if (a[0]!= 'x' || a[1]!='k' || a[5]!='c' || a[6]!='d')
        flag = 0;
    if ((int)a[2]<(int) 'A' || (int) a[2]> (int) 'Z') // has to be from A-Z
        flag = 0;
    if ((int)a[3]!=((int)'A' + month))
        flag = 0;
    if (((int) a[4] - 48)-2 != month%3) // a[4] = month%3 + 2
        flag = 0;
    if ((int)a[7]>4+48) // can't be more than 4
        flag = 0;
    
    
    
    if (flag ==1)
    {
        if (((int)a[7] - 48)==1 || ((int)a[7]-48==3))
            flag=1;
        if (((int)a[7] - 48)==2 || ((int)a[7]-48==4) || ((int)a[7]-48==0))
            flag=2;
    }
    
    return flag;
}

-(int)codeCheck{
    
    NSString *readString;
    readString= answerText; // We will use the code that the user enters to the oracle here .. it is answerText in your code
    
    // readString is the code (NSString format) that the user enters ... Here we are using entry from the textField
    
    int flag=1;
    
    char a[10];
    
    if (readString.length != 10){
        flag=0;
        for (int i=0;i<10;i++)
            a[i]=' ';
        return flag;
    }
    else{
        for (int index=0;index<10;index++){
            a[index]=[readString characterAtIndex:index];
            //    a[index]='1';
        }
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    //NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    
    //        Display.text=[NSString stringWithFormat:@"Month is %d and Year is %d .. a[5] is: %c", month,year,a[5]];
    
    
    
    if (a[0]== 'x' || a[0]=='y' || a[0]=='z' || a[0]=='X' || a[0]=='Y' ||a[0]== 'Z' || a[0]=='7' ||a[0]== '8' || a[0]=='9')
        flag = 0;
    
    NSLog(@"After a[0] flag is %i",flag);
    if ( a[1] != (char) ((int)a[0] + month + year%100)) // Previous + month + year
        flag=0;
    NSLog(@"After a[1] flag is %i",flag);
    
    if ( (int) a[2]<48 || (int) a[2]>57) // random number (0-9)
        flag=0;
    NSLog(@"After a[2] flag is %i",flag);
    int sumcheck = ((int) a[0] + (((int) a[2])-48))%100;
    int units = sumcheck%10;
    int tens=(sumcheck-(units))/10;
    
    NSLog(@"sumcheck is %i",sumcheck);
    if ((int)a[3]-48!=tens || (int)a[4]-48!=units) // the ascii code of a[0] advanced by a[2]
        flag=0;
    NSLog(@"After a[4] flag is %i , since a[3] (%i) and a[4] (%i)",flag,a[3], a[4]);
    if ( (int) a[5] <65 || (int)a[5]>90) // a random capital
        flag=0;
    NSLog(@"After a[5] flag is %i",flag);
    
    if ( ((int)a[6]<97) ||
        ((int)a[6]>116)) // a random lowercase
        flag=0;
    
    int delta = ((int) a[1] - (int) a[5])%100; // the difference between the capital and the initial lowercase
    int units1 = delta%10;
    int tens1=(delta-(units1))/10;
    
    if ((int)a[7]-48!=tens1 || (int)a[8]-48!=units1)
        flag=0;
    NSLog(@"After a[8] flag is %i",flag);
    
    if ((int)a[9] != ((int)a[6]-32)+(month%7) ) //Adding Month%7 to the lowercase letter and transforming to capital
        flag=0;
    
    
    return flag;
}

-(void)startConversation{
    int ran = arc4random()%3+1;
    NSString *message = [oracleFirstsay objectAtIndex:ran];
    conversationAlert = [[UIAlertView alloc]initWithTitle:message message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Say", nil];
    //    answertextField = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 65.0, 260.0, 25.0)];
    //    answertextField.layer.cornerRadius = 5.0;
    //    answertextField.backgroundColor = [UIColor whiteColor];
    conversationAlert.tag = oracleConverSationAlert;
    //    [conversationAlert addSubview:answertextField];
    conversationAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [conversationAlert show];
}


-(void)talkToOracle{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click3.mp3"];
    
    if([gameData returngold]<2){
        UIAlertView *oracleGeneric = [[UIAlertView alloc]initWithTitle:@"To talk to the Oracle, you need at least 2 Gold." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [oracleGeneric show];
        [oracleGeneric release];
    }
    else {
        UIAlertView *oracle = [[UIAlertView alloc]initWithTitle:@"To talk to the Oracle, You must leave 2 Gold at the door.." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
        oracle.tag = oracleFirstDealAlert;
        [oracle show];
        [oracle release];
    }
}

-(void)oracleDemandOne{
    UIAlertView *demandOneAlert = [[UIAlertView alloc]initWithTitle:@"So You've seen the disc. Ok, leave 35 pieces of Gold at the door and come back." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
    demandOneAlert.tag = rightOneCharge;
    [demandOneAlert show];
    [demandOneAlert release];
}
-(void)oracleDemandTwo{
    UIAlertView *demandTwoAlert = [[UIAlertView alloc]initWithTitle:@"Ahh Yes.. Struggling with Matrix of Letters. You have to Pay 35 pieces of Gold to proceed." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
    demandTwoAlert.tag = rightTwoCharge;
    [demandTwoAlert show];
    [demandTwoAlert release];
}

-(void)oracleDemandThree{
    UIAlertView *demandOneAlert = [[UIAlertView alloc]initWithTitle:@"You are looking for X. With 40 Pieces of Gold I might be able to help." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
    demandOneAlert.tag = rightThreeCharge;
    [demandOneAlert show];
    [demandOneAlert release];
}
-(void)oracleDemandFour{
    UIAlertView *demandTwoAlert = [[UIAlertView alloc]initWithTitle:@"Haha ...Everything can seem so foggy. Leave 45 pieces of Gold at the altar and come back." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
    demandTwoAlert.tag = rightFourCharge;
    [demandTwoAlert show];
    [demandTwoAlert release];
}

-(void)oracleDemandFive{
    UIAlertView *demandOneAlert = [[UIAlertView alloc]initWithTitle:@"Gold. The Dream of Alchemists. Gold doesn't mean the gold. Do you have 50 pieces of Gold to listen to my advice?" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
    demandOneAlert.tag = rightFiveCharge;
    [demandOneAlert show];
    [demandOneAlert release];
}
-(void)oracleDemandSix{
    UIAlertView *demandTwoAlert = [[UIAlertView alloc]initWithTitle:@"beauty.. Well, that is your answer - you don't always need me!" message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    demandTwoAlert.tag = rightFourCharge;
    [demandTwoAlert show];
    [demandTwoAlert release];
}

-(void)oracleAdviceOne{
    UIAlertView *AdviceOneAlert = [[UIAlertView alloc]initWithTitle:@"You are on a noble quest to find the first step toward greatness..  You have one part of the word, and ‘LINE’ is the second part of the word you’re looking for. You need two more letters for that word, and you have to find them on your own." message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    // demandOneAlert.tag = rightOneCharge;
    [AdviceOneAlert show];
    [AdviceOneAlert release];
}
-(void)oracleAdviceTwo{
    UIAlertView *AdviceTwoAlert = [[UIAlertView alloc]initWithTitle:@"First , Get the Matrix of Letters. Then, Go to  http://www.think-grow.biz/kwest/1341.jpg  .. This should be enough for you to SEE the answer" message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //AdviceTwoAlert.tag = rightTwoCharge;
    [AdviceTwoAlert show];
    [AdviceTwoAlert release];
}

-(void)oracleAdviceThree{
    UIAlertView *AdviceOneAlert = [[UIAlertView alloc]initWithTitle:@"Hmmm .. 24 is the number of the letter 'x' ...  but for your word, x is the number of fingers in a hand." message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [AdviceOneAlert show];
    [AdviceOneAlert release];
}
-(void)oracleAdviceFour{
    UIAlertView *AdviceTwoAlert = [[UIAlertView alloc]initWithTitle:@"Take the letters: “traincuneyt” - order them and you’ll have your word that is close to 'sfumato'" message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [AdviceTwoAlert show];
    [AdviceTwoAlert release];
}

-(void)oracleAdviceFive{
    UIAlertView *AdviceOneAlert = [[UIAlertView alloc]initWithTitle:@"Go to http://www.think-grow.biz/kwest/618 .. You will find beautiful paintings. Find the letters hidden in them. Get the letters, and come back." message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [AdviceOneAlert show];
    [AdviceOneAlert release];
}

-(void)back:(id)sender{
    //  [[[CCDirector sharedDirector]openGLView]removeFromSuperview];
    
    [sliderOne removeFromSuperview];
    [sliderTwo removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}


-(void)createTutorialBaseView{
    [self disableTouch];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
    // tutorialView.backgroundColor = [UIColor blackColor];
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

-(void)showMainView{
    [tutorialView removeFromSuperview];
    [self enableTouch];
    // [self showMainViewofBeyond];
}


-(void)showBeyondTutorial{
    [self clearTutorialView];
    UIImage *beyondTextImage = [UIImage imageNamed:@"Beyondtxt"];
    
    UIImage *theWellofEnergyButtonImage = [UIImage imageNamed:@"Well"];
    UIImage *theTreeofKnowledgeButtonImage = [UIImage imageNamed:@"Tree"];
    
    UIImage *oracleButtonImage = [UIImage imageNamed:@"Oracletut"];
    UIImage *boostsButtonImgae = [UIImage imageNamed:@"Boosts"];
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/16, DeviceHeight/16, beyondTextImage.size.width, beyondTextImage.size.height)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        beyondTextImageView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, beyondTextImage.size.width, beyondTextImage.size.height);
        
    }
    beyondTextImageView.image = beyondTextImage;
    [tutorialBackgroundImageView addSubview:beyondTextImageView];
    
    float xMargin = (tutorialBackgroundImageView.frame.size.width - (theWellofEnergyButtonImage.size.width+theTreeofKnowledgeButtonImage.size.width))/3;
    
    float yMargin = (tutorialBackgroundImageView.frame.size.height-(theWellofEnergyButtonImage.size.height+oracleButtonImage.size.height))/8;
    
    UIButton *theWellofEnegergyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theWellofEnegergyButton.frame = CGRectMake(xMargin+10, yMargin+beyondTextImageView.frame.size.height, theWellofEnergyButtonImage.size.width, theWellofEnergyButtonImage.size.height);
    [theWellofEnegergyButton setBackgroundImage:theWellofEnergyButtonImage forState:UIControlStateNormal];
    [theWellofEnegergyButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    theWellofEnegergyButton.tag = 0;
    [tutorialBackgroundImageView addSubview:theWellofEnegergyButton];
    
    
    UIButton *theTreeofKnowledgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theTreeofKnowledgeButton.frame = CGRectMake(10+xMargin+theWellofEnegergyButton.frame.size.width, yMargin+beyondTextImageView.frame.size.height, theTreeofKnowledgeButtonImage.size.width, theTreeofKnowledgeButtonImage.size.height);
    [theTreeofKnowledgeButton setBackgroundImage:theTreeofKnowledgeButtonImage forState:UIControlStateNormal];
    [theTreeofKnowledgeButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    theTreeofKnowledgeButton.tag = 1;
    [tutorialBackgroundImageView addSubview:theTreeofKnowledgeButton];
    
    
    UIButton *oracleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oracleButton.frame = CGRectMake(xMargin+10, yMargin*2+beyondTextImageView.frame.size.height+theWellofEnegergyButton.frame.size.height/2, oracleButtonImage.size.width, oracleButtonImage.size.height);
    [oracleButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    oracleButton.tag = 2;
    [oracleButton setBackgroundImage:oracleButtonImage forState:UIControlStateNormal];
    [tutorialBackgroundImageView addSubview:oracleButton];
    
    UIButton *boostsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostsButton.frame = CGRectMake(10+xMargin+theWellofEnegergyButton.frame.size.width, yMargin*2+beyondTextImageView.frame.size.height+theWellofEnegergyButton.frame.size.height/2, boostsButtonImgae.size.width, boostsButtonImgae.size.height);
    [boostsButton setBackgroundImage:boostsButtonImgae forState:UIControlStateNormal];
    [boostsButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    boostsButton.tag = 3;
    [tutorialBackgroundImageView addSubview:boostsButton];
    
}

-(IBAction)showBeyondSubTutorials:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 0:
        case 1:
        case 2:
            [self clearTutorialView];
            [self showSubTutorial:btn.tag];
            break;
        case 3:
            [self showBoosttutorial];
            break;
        default:
            break;
    }
}

-(void)showSubTutorial:(int)btnTag{
    UIImage *beyondsubTextImage = [UIImage imageNamed:[NSString stringWithFormat:@"Beyond%dtxt",btnTag]];
    
    
    UIImage *beyondButtonImage = [UIImage imageNamed:@"Beyond"];
    
    UIImageView *beyondSubTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/16, DeviceHeight/16, beyondsubTextImage.size.width, beyondsubTextImage.size.height)];
    //    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
    //        beyondSubTextImageView.frame = CGRectMake(0, 0, beyondsubTextImage.size.width, beyondsubTextImage.size.height);
    //    }
    beyondSubTextImageView.image = beyondsubTextImage;
    [tutorialBackgroundImageView addSubview:beyondSubTextImageView];
    
    UIButton *beyondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beyondButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-beyondButtonImage.size.width/2,beyondSubTextImageView.frame.size.height+30, beyondButtonImage.size.width, beyondButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        beyondButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-beyondButtonImage.size.width/2,beyondSubTextImageView.frame.size.height+60, beyondButtonImage.size.width, beyondButtonImage.size.height);
    }
    beyondButton.tag = 2;
    [beyondButton setBackgroundImage:beyondButtonImage forState:UIControlStateNormal];
    [beyondButton addTarget:self action:@selector(showBeyondTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:beyondButton];
}

-(void)showBoosttutorial{
    [self clearTutorialView];
    UIImage *boostTextImage = [UIImage imageNamed:@"Booststxt"];
    
    
    UIImage *keyofWisdomButtonImage = [UIImage imageNamed:@"Key_Wisdom_but"];
    UIImage *keyofEnergyButtonImage = [UIImage imageNamed:@"Key_Energy_but"];
    UIImage *keyofStrengthButtonImage = [UIImage imageNamed:@"Key_Strength_but"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(DeviceWidth/16, DeviceHeight/16, boostTextImage.size.width, boostTextImage.size.height)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, boostTextImage.size.width, boostTextImage.size.height);
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
    [self clearTutorialView];
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
    if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
        boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, DeviceHeight/2, boostButtonImage.size.width, boostButtonImage.size.height);
    }
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        boostButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width/2-boostButtonImage.size.width/2, DeviceHeight/1.66, boostButtonImage.size.width, boostButtonImage.size.height);
    }
    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
    boostButton.hidden = status;
    [tutorialBackgroundImageView addSubview:boostButton];
    
}

-(void)enableTouch{
    back.enabled = YES;
    oracleMenu.enabled = YES;
    energyMenu.enabled = YES;
    strengthMenu.enabled = YES;
    wisdomMenu.enabled = YES;
}

-(void)disableTouch{
    back.enabled = NO;
    oracleMenu.enabled = NO;
    energyMenu.enabled = NO;
    strengthMenu.enabled = NO;
    wisdomMenu.enabled = NO;
}
-(void)dealloc{
    [super dealloc];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"InAppPurchase" object:nil];
}

@end
