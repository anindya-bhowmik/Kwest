//
//  PlayerStat.h
//  kwest
//
//  Created by Tashnuba Jabbar on 07/11/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Menu.h"
#import "GameData.h"
#import "PlayerStatistics.h"
#import "Score.h"
@interface PlayerStat : CCLayer {
    PlayerStatistics *stat;
    GameData *gamedata;
    CCSprite *backgroundImage;
    CCSprite *headerImage;
    CCSprite *table;
    
    ALuint effectID;
}
+(CCScene*)scene;
-(void)addLstat;
-(void)removeUI;
//-(void)addktable;
@end
