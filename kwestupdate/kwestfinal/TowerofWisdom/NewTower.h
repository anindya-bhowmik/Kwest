//
//  NewTower.h
//  kwest
//
//  Created by Aitl on 1/23/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
@class BasePopUpView;
@interface NewTower : CCLayer<UIScrollViewDelegate> {
    GameData *gamedata;
    CCSprite *towerBg;
    float currentScale;
    float pinchScale;
    int zoomCount;
    UIScrollView *towerView;
    UIProgressView *progressView;
    UIImageView *image;
    UIButton *questButton;
    UIButton *backButton;
    UILabel *curLevel;
    UILabel *nextLevel;
    UIImageView *progressBgImageView;
    UIView *towerBaseView;
    int currentPopupNumber;
    int level;
    UIImageView  *bgImageView;
    UIImageView *towerTalkImageView;
    UIImageView  *talkImageView;
    UIImage *talkImage;
    BOOL isCleared;
    UIScrollView *towerTalkScrollView;
    
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *towerBackGroundView;
    
    UILabel *curLevelKnop;
    UILabel *nextLevelKnop;
    
    UILabel *tokenLabel;
    NSMutableArray * towerButtonArray;
    ALuint effectID;
    
    int curKNOP;
    int nextKNOP;
}
+(CCScene *) scene ;
@end
