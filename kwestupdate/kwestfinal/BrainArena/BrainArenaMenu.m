//
//  BrainArenaMenu.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "BrainArenaMenu.h"
#import "Sprint.h"
#import "Endurance.h"
#import "Memory.h"
#import "Menu.h"
#import "BasePopUpView.h"
#import "Beyond.h"
#import "OptionView.h"
#import "BrainTeaserView.h"
#import "Utility.h"
#import <Chartboost/Chartboost.h>


#define noEnergyPremium 2
#define noEnergyBasic 3
#define BrainArenaSceneTag 222
CCMenu *brainarenamenu;
@implementation BrainArenaMenu

+(CCScene*)scene{
    CCScene *scene = [CCScene node];

// 'layer' is an autorelease object.
    BrainArenaMenu *layer = [BrainArenaMenu node];
    layer.tag = BrainArenaSceneTag;
// add layer as a child to scene
    [scene addChild: layer];

// return the scene
    return scene;
}

-(id)init{
    if(self =  [super init]){
       // [self createBackgroundView];
        adDidRecieve = FALSE;
        gamedata = [GameData GameDataManager];
        ec = [[EnergyCalculation alloc]init];
            [self createBackgroundView];
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
                [self createTutorialBaseView];
                [self disableTouch];
            }
        
       
    }
    return self;
}

-(void)onExit{
    [super onExit];
    
}

-(void)createTutorialBaseView{
    gamedata.isTutorialShown = FALSE;
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *moreButtonImage = [UIImage imageNamed:@"More"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
    //tutorialView.backgroundColor = [UIColor blackColor];
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
    [self showKnowledgePathMainText];
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(DeviceWidth/1.46, DeviceHeight/1.23, moreButtonImage.size.width, moreButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.18, moreButtonImage.size.width, moreButtonImage.size.height);
    }

    [moreButton setBackgroundImage:moreButtonImage forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showKnowledgePathMoreText) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:moreButton];
    
    [UIView animateWithDuration:2.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)showMainView{
    [UIView animateWithDuration:0.5 delay:0.7 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [tutorialView removeFromSuperview];
                         [self enableTouch];}];
    
}

-(void)clearTutorialView{
    
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}
-(void)showKnowledgePathMoreText{
    [self clearTutorialView];
    [moreButton removeFromSuperview];
    UIImage *sprintTextImage = [UIImage imageNamed:@"BrainArena-II-txt"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    ;
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);
    }
//

    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/4);
    [scrollView addSubview:sprintTextImageView];
    
}

-(void)showKnowledgePathMainText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"BrainArena-I-txt"];
    //    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
    //    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
    //    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, sprintTextImage.size.height);
    ;
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        scrollView.frame = CGRectMake(DeviceWidth/30, DeviceHeight/30, sprintTextImage.size.width, sprintTextImage.size.height);
//    }

    
    [tutorialBackgroundImageView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width+60, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
}



-(void)createBackgroundView{
    brainArenaMenuBg =[CCSprite spriteWithFile:@"BrainArenaMenuBackground.png"];
    brainArenaMenuBg.anchorPoint = ccp(0.5,0.5);
    brainArenaMenuBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:brainArenaMenuBg];
    
    CCMenuItemImage *focus = [CCMenuItemImage itemWithNormalImage:@"Focus.png" selectedImage:@"Focuspressed.png" target:self  selector:@selector(goToIntelligent:)];
    focus.tag =1;
    focusMenu = [CCMenu menuWithItems:focus, nil];
    focusMenu.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [brainArenaMenuBg addChild:focusMenu];
    
    CCMenuItemImage *sprint = [CCMenuItemImage itemWithNormalImage:@"Speed.png" selectedImage:@"Speedpressed.png" target:self  selector:@selector(goToIntelligent:)];
    sprint.tag =0 ;
    sprintMenu = [CCMenu menuWithItems:sprint, nil];
    sprintMenu.position = ccp(90*DevicewidthRatio,360*DeviceheightRatio);
    [brainArenaMenuBg addChild:sprintMenu];
    
    CCMenuItemImage *memory = [CCMenuItemImage itemWithNormalImage:@"Memory.png" selectedImage:@"Memorypressed.png" target:self  selector:@selector(goToIntelligent:)];
    memory.tag =2 ;
    memoryMenu = [CCMenu menuWithItems:memory, nil];
    memoryMenu.position = ccp(250*DevicewidthRatio,360*DeviceheightRatio);
    [brainArenaMenuBg addChild:memoryMenu];
    
    CCMenuItemImage *brainTeaser = [CCMenuItemImage itemWithNormalImage:@"BrainTeasers.png" selectedImage:@"BrainTeaserspressed.png" target:self  selector:@selector(goToBrainTeaser:)];
    brainTeaser.tag =3 ;
    brainTeaserMenu = [CCMenu menuWithItems:brainTeaser, nil];
    brainTeaserMenu.position = ccp(240*DevicewidthRatio,120*DeviceheightRatio);
    [brainArenaMenuBg addChild:brainTeaserMenu];
    
    CCMenuItemImage *backitem =[CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButtonpressed.png" target:self selector:@selector(back:)];
    back = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(55*DevicewidthRatio,70*DeviceheightRatio);
    [self addChild:back];

}

-(void)back:(id)sender{
//    if(adDidRecieve){
//        [ad removeFromSuperview];
//    }
//    [ad release ];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)goToIntelligent:(id)sender{
 //[RevMobAds session];
    CCMenuItemImage *btn = (CCMenuItemImage*)sender;
  [self energyCalculation:btn.tag];
   
}

-(void)goToBrainTeaser:(id)sender{
//    if (adDidRecieve) {
//        [ad removeFromSuperview];
//    }
//    
//    [ad release ];
   
     [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainTeaserView   scene]]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tagValue = alertView.tag;
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
     if (tagValue ==noEnergyPremium){
        if (buttonIndex == 2){
            [self back];
        }
        else if (buttonIndex ==1){
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Beyond scene]]];
        }
        else if (buttonIndex == 0){
            [self createEnergyText];
        }
        
    }
    
    else if (tagValue ==noEnergyBasic){
        if (buttonIndex == 0){
            [self back];
        }
        else if (buttonIndex ==1){
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[OptionView scene]]];
        }
        else if (buttonIndex == 2){
            [self showReasonsForPremium];
        }
        
    }

   
}

-(void)back{
    [[RevMobAds session]hideBanner];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[Menu scene]]];
}

-(void)energyCalculation:(int)tag{
//    if(adDidRecieve){
//        [ad removeFromSuperview];
//    }
    int energy = [ec calculateIntelligenceQuestionEnergy];
    
    if(energy<0){
          brainarenamenu.visible=NO;
         [Flurry logEvent:@"No Energy"];
        if([gamedata returnpremium]){
            
            if(![gamedata returnkeyofenergy]){
                UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"You don't have enough Energy. If you get the Key of Energy your base daily Energy will become 125, All questions will consume less of your Energy, and you will unlock the magic Well. Do you want to Unlock the Key of Energy?" delegate:self cancelButtonTitle:@"Why?" otherButtonTitles: @"Yes, Sure!",@"No, Thanks",nil];
                noEnergyAlert.tag = noEnergyPremium;
                [noEnergyAlert show];
                [noEnergyAlert release];
            }
            else if ([gamedata returnkeyofenergy]){
                UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"Sorry! You don't have any more Energy. You can wait till tomorrow, or Use the Well of Energy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                noEnergyAlert.tag = noEnergyBasic;
                [noEnergyAlert show];
                [noEnergyAlert release];
            }

        }
        
        else{
            UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"You don't have enough Energy. In Premium mode you will receive a much higher daily Energy. Do you want to Upgrade to Premium?" delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles: @"Yes, Sure!",@"Why?",nil];
            noEnergyAlert.tag = noEnergyBasic;
            [noEnergyAlert show];
            [noEnergyAlert release];
        }
    }else{
//        [ad removeFromSuperview];
//        ad.delegate = nil;
//        [ad release ];
        
        [[GameData GameDataManager]setEnergy:[ec calculateIntelligenceQuestionEnergy]];
        if(tag==0){
            
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[Sprint scene]]];
        }
        else if(tag==1){
            NSInteger n = [gamedata getendurancetry];
            n++;
            [gamedata setendurancetry:n];
             [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[Endurance scene]]];
        }
        else if(tag==2){
            NSInteger n = [gamedata getmemorytry];
            n++;
            [gamedata setmemorytry:n];
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[Memory scene]]];
        }
    }
}

//-(void)backToHome:(id)sender{
//  
//    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
//}

-(void)enableTouch{
    brainTeaserMenu.enabled = YES;
    back.enabled = YES;
    focusMenu.enabled = YES;
    sprintMenu.enabled = YES;
    memoryMenu.enabled = YES;
   
}

-(void)disableTouch{
    brainTeaserMenu.enabled = NO;
    back.enabled = NO;
    focusMenu.enabled = NO;
    sprintMenu.enabled = NO;
    memoryMenu.enabled = NO;
}

-(void)showReasonsForPremium{
    // [self disableTouch];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"PremiumVsBasic"];
    premimuReasonView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    premimuReasonView.alpha = 0;
    [[[CCDirector sharedDirector]view]addSubview:premimuReasonView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/4, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [premimuReasonView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2, DeviceHeight/5, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+85, DeviceHeight/4.8, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }

    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchDown];
    [premimuReasonView addSubview:tutorialCloseButton];
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         premimuReasonView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    
}

-(void)backToMainView{
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         premimuReasonView.alpha = 0;
                         energyTextView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [premimuReasonView removeFromSuperview];
                         [energyTextView removeFromSuperview];
                         [self back];
                     }];
    
}

-(void)createEnergyText{
    //[self clearTutorialView];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *beyondTextImage = [UIImage imageNamed:@"boostSubtutorialtext3"];
    
    energyTextView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    energyTextView.alpha = 0;
    [[[CCDirector sharedDirector]view ]addSubview:energyTextView];
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [energyTextView addSubview:tutorialBackgroundImageView];
    
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, beyondTextImage.size.width, beyondTextImage.size.height)];
    beyondTextImageView.image = beyondTextImage;
    [tutorialBackgroundImageView addSubview:beyondTextImageView];
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+225, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//    }
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchDown];
    [energyTextView addSubview:tutorialCloseButton];
    
    [UIView animateWithDuration:1.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         energyTextView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
}

//- (void)revmobAdDidReceive{
//    CCArray *layers =[[CCDirector sharedDirector]runningScene].children;
//    for(int i = 0 ;i < [layers count];i++){
//        CCLayer *layer = [layers objectAtIndex:i];
//     if(layer.tag == BrainArenaSceneTag){
//         adDidRecieve = YES;
//         ad.frame = CGRectMake(DeviceWidth/2-RevMobBannerWidth/2, DeviceHeight-50, RevMobBannerWidth, 50);
//
//         [[[CCDirector sharedDirector]view]addSubview:ad];
//         break;
//     }
//    }
////    if(!adDidRecieve){
////        [ad release];
////    }
//}
- (void)revmobAdDidFailWithError:(NSError *)error{
   // [ad release];
    [Chartboost showInterstitial:CBLocationGameOver];
    
}

-(void)dealloc{
    
    [super dealloc];
    
//    if (ad) {
//        [ad release];
//    }
   // [ad removeFromSuperview];
   // [[RevMobAds session]hideBanner];
      [ec release];
//    if(adDidRecieve){
//    ad.delegate  = nil;
//    [ad removeFromSuperview];
////    }
//    [ad release];
}
@end
