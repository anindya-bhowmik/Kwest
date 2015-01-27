//
//  BTSolution.h
//  kwest
//
//  Created by Anindya on 5/6/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BTSolution : CCNode {
    
    UIScrollView *scrollView;
    UIButton *crossButton;
}
-(CCScene*)scene;
-(id)initWithSolutionNumer :(int)solNum;
+(id)nodeWithGameLevel:(int)level;

@end
