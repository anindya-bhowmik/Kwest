//
//  MissionVIew.h
//  kwest
//
//  Created by Anindya on 7/30/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Myquslist;
@class PlayerStatistics;
@class GameData;
@class Score;
@interface MissionVIew : CCLayer {
    
    UIScrollView *scrollview;
    UIButton *backButton;
    CCSprite *backgroundImage;
    CCSprite *headerImage;
    Myquslist *databaseManager;
    int missionClicked;
    PlayerStatistics *stat;
    GameData *gameData;
    NSMutableArray *completeImageArray;
    UIImage *completeImage;
    Score *scoreCalculation;
    ALuint effectID;
}
+(CCScene *)scene;
@end
