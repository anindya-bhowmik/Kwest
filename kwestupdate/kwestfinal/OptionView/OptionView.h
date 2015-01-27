//
//  OptionView.h
//  kwest
//
//  Created by Anindya on 6/13/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import <Social/Social.h>
@class  BasePopUpView;
@class InAppPurchase;
@interface OptionView : CCLayer<GKLeaderboardViewControllerDelegate> {
    CCSprite *backgroundImage;
    
    CCSprite *musicSwitchBg;
    CCSprite *helpSwitchBG;
    UISwitch *soundSwitch;
    UISwitch *helpSwitch;
    
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
 
    UIImageView *tutorialBackgroundImageView;
    UIViewController *temp;
    
    GLuint effectID;
    
    
    CCMenu *leaderboardMenu;
    CCMenu *buyGoldMenu;
    InAppPurchase *inApp;
}
+(CCScene*)scene;
+(void)enableTouch;
@end
