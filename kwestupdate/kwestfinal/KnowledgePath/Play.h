//
//  Play.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnergyCalculation.h"
#import "PlayerStatistics.h"
#import "Score.h"
#import "GameData.h"
#import "Menu.h"
@class BasePopUpView;
@interface Play : CCLayer {
    //Score *sc;
    bool is4complete;
    int q_id;
    bool isEnergygainorloss;
    NSString *qus;
    NSString *opt1;
    NSString *opt2;
    NSString *opt3;
    NSString *opt4;
    NSInteger correct;
    NSInteger type;
    NSInteger level;
    CCMenu *home;
    bool isClicked;
    CCLabelTTF *counterlbl;
    int counter;
    NSMutableArray *optArray;
    NSString *rightanswerstr;
    float knop;
    float gold;
    int karma;
    NSInteger qustry;
    NSInteger quscorrect;
    PlayerStatistics *stat;
    EnergyCalculation *ec;
    bool isCorrect;
    int energy;
    bool isDifficulty;
    bool isType;
    NSMutableArray *qusIndex;
    CCMenu *ansButton[4];
    CCMenu *typeSelectionMenu[4];
    CCLabelTTF *typeSelectionMenuLabel[4];
    CCMenu *difficultySelectionMenu[3];
    CCLabelTTF *difficultySelectionMenuLabel[3];
    CCSprite *knowledgePathBg;
    UIView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIButton *moreButton;
    
    ALuint countDownEffect;
    ALuint writeAnswerEffect;
    ALuint wrongAnswerEffect;
    ALuint bonusEffect;
    
    BasePopUpView *premimuReasonView;
    BasePopUpView *energyTextView;

}

-(void)showCorrectText;
-(void)showKnowledgePathSelectionOption;
-(BOOL)selection;
-(void)knowledgepathType:(int)t Difficulty:(int)d Level:(int)l;
+(CCScene *) scene;
-(NSInteger)getQusIndex:(NSInteger)difficulty :(int)t :(int)l;
-(void)bonusEnergy;
//-(void)calculateScore;
-(void)showScoreLayer;
//-(NSString *)KnowledgePathBonusCalculation;
//-(void)setLevel:(int)k;
//-(void)karmaCalculation;
@end
