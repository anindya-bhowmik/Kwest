//
//  BrainArenaMenu.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "EnergyCalculation.h"
#import "GameData.h"

@class BasePopUpView;
@interface BrainArenaMenu : CCLayer {
    GameData *gamedata;
    EnergyCalculation *ec;
    CCSprite *brainArenaMenuBg;
    BasePopUpView *tutorialView;
    CCMenu *sprintMenu;
    CCMenu *memoryMenu;
    CCMenu *brainTeaserMenu;
    CCMenu *back;
    CCMenu *focusMenu;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIButton *moreButton;
    
    BasePopUpView *premimuReasonView;
    BasePopUpView *energyTextView;
    
   
    BOOL adDidRecieve;
}
+(CCScene*)scene;
-(void)energyCalculation:(int)tag;
@end
