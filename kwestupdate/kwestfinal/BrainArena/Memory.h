//
//  Memory.h
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
@interface Memory : CCLayer {
     float counter;
    GameData *gamedata;
    long long int answer;
    CCLabelTTF *anslbl;
    CCLabelTTF *quslbl;
    CCLabelTTF *counterlbl;
    float displaycounter;
    bool isCLicked;
    PlayerStatistics *stat;
    CCSprite *keyPadBg;
    
    UIView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *scrollView;
    
    CCLabelTTF *displayText;
    CCLabelTTF *displayLabel;
    
    GLuint coundownEffectId;
    
}
+(CCScene*)scene;
-(void)checkAnswer:(NSString*)ans;
-(void)addButtons;
-(void)calculateScore;
-(void)setLevel:(int)k;

-(void)showScoreLayer:(float)g :(float)k;

@end
