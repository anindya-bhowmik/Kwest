//
//  Clues.h
//  kwest
//
//  Created by Tashnuba Jabbar on 14/11/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Menu.h"
@interface Clues : CCNode {
    UIButton *crossButton;
    UIScrollView *scroll;
}
-(CCScene*)scene;
-(id)initWithClueNumber:(int)number;
+(id)nodeWithClue:(int)clueNumber;
@end
