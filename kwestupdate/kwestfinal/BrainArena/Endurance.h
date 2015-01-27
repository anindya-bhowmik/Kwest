//
//  Endurance.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "EnergyCalculation.h"
#import "PlayerStatistics.h"
#import "BrainArenaResult.h"
#import "Score.h"
@interface Endurance : CCLayer {
    GameData *gamedata;
    int answer;
    CCLabelTTF *anslbl;
    CCLabelTTF *counterlbl;
    float counter;
    bool isCLicked;
    PlayerStatistics *stat;
    CCSprite *keyPadBg;
    
    UIView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *scrollView;
    GLuint countDownEffectId;
}
+(CCScene*)scene;
-(void)checkAnswer:(NSString*)ans;
-(void)fail;
-(void)calculateScore:(NSInteger)qusnum;
-(void)setLevel:(int)k;
//-(void)karmaCalculation;
-(void)showScoreLayer:(float)g :(float)k;
@end
