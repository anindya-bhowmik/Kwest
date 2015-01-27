//
//  PlayerInfo.h
//  kwest
//
//  Created by Tashnuba Jabbar on 19/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
//#import "CCUIViewWrapper.h"
@interface PlayerInfo : CCLayer {
   // CCUIViewWrapper *wrapper;
    NSMutableArray *edited;
    NSMutableArray *lblname;
    NSMutableArray *prestored;
    NSMutableArray *lbls;
}
+(CCScene *) scene;
-(void)addTextFieldData;
-(void)karmaCalculation;
@end
