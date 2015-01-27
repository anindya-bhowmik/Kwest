//
//  Profile.h
//  kwest
//
//  Created by Aitl on 1/15/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "Score.h"
#import "PlayerInfo.h"
#import "Menu.h"
#import "NewTower.h"
#import <Social/Social.h>
#define energyalert 1
#define wisdomalert 2
#define strengthalert 3
@class BasePopUpView;
@class InAppPurchase;
@interface Profile : CCLayer {
    GameData *gamedata;
    CCSprite *bg;
    CCSprite *inAppMenuBg;
    int playerLabel;
    CCMenuItemImage *strengthitem;
    CCMenuItemImage *energyitem;
    CCMenuItemImage *wisdomitem;
    CCMenu *statisticsMenu;
    CCMenu *homemenu ;
    CCMenu *strengthMenu;
    CCMenu *wisdomMenu;
    CCMenu *energyMenu;
    CCMenu *profilemenu;
    CCMenu *uscoreMenu;
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    
    CCMenu *energyItemPopUPMenu;
    CCMenu * knopItemPopUPMenu;
    CCMenu *goldItemPopUPMenu;
    CCMenu *karmaItemPopUPMenu;
    Score *sc;
    InAppPurchase *inApp;
    CCLabelTTF *goldlbl;

}
+(CCScene *) scene;
@end
