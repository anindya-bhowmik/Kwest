//
//  QuestScene.h
//  kwest
//
//  Created by Anindya on 5/7/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BasePopUpView;

@interface QuestScene : CCLayer {
    CCSprite *questBg;
    NSMutableArray *questArray;
    CCMenu *quest1ItemMenu;
    CCMenu *quest2ItemMenu;
    CCMenu *quest3ItemMenu;
    CCMenu *quest4ItemMenu;
    CCMenu *quest5ItemMenu;
    CCMenu *quest6ItemMenu;
    CCMenu *quest7ItemMenu;
    CCMenu *clueBtnMenu;
    CCMenu *backBtnMenu;
    UITextField *ansField;
    BOOL isRight;
    
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *scrollView;
}

+(CCScene *)scene;

@end
