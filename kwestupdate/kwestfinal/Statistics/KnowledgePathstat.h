//
//  KnowledgePathstat.h
//  kwest
//
//  Created by Anindya on 6/14/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class PlayerStatistics;
@class GameData;
@interface KnowledgePathstat : CCLayer {
   CCSprite *backgroundImage;
   CCSprite *headerImage;
    CCSprite *detail;
    CCSprite *overall;
    GameData *gamedata;
    PlayerStatistics *stat;
    CCProgressTimer *worldProgressTimer;
    CCProgressTimer *logicProgressTimer;
    CCProgressTimer *humanProgressTimer;
    CCProgressTimer *deeperProgressTimer;
    CCProgressTimer *ratingProgressTimer;
    ALuint effectID;
}
+(CCScene*)scene;
@end
