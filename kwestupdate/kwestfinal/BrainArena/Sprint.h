//
//  Sprint.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 15/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "PlayerStatistics.h"
#import "BrainArenaResult.h"

@class Score;
@interface Sprint : CCLayer {
    float counter;
    GameData *gamedata;
    int answer;
    CCLabelTTF *anslbl;
    CCLabelTTF *counterlbl;
    bool isClicked;
    PlayerStatistics *stat;
    CCSprite *keyPadBg;
    CCSprite *bg;
    
    UIView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *scrollView;
    
    GLuint countdownEffectID;

}
+(CCScene*)scene;

-(void)checkAnswer:(NSString*)ans;
-(void)calculateScore:(float)time;
-(void)setLevel:(int)k;
//-(void)karmaCalculation;
-(void)showScoreLayer:(float)g :(float)k;
@end
