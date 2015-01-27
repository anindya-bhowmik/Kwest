//
//  ClueScene.h
//  kwest
//
//  Created by Anindya on 5/9/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameData;
@interface ClueScene : CCLayer {
    CCSprite *clueBg;
    GameData *gameData;
    int price;
    int clueNum;
}
+(CCScene*)scene;
@end
