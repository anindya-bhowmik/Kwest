//
//  BrainTeaserProblemScene.h
//  kwest
//
//  Created by Anindya on 5/4/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface BrainTeaserProblemScene : CCNode<UIScrollViewDelegate> {
    CCSprite *probSprite;
    CGPoint *oldPoint;
    UIScrollView *scrollView;
    UIButton *crossButton;
    
    BOOL adDidRecieve;
    int problemNumber;
}

@property (nonatomic,assign)int problemNumber;
-(CCScene*)scene;
+(id)nodeWithGameLevel:(int)level;
-(id)initWithProblemNumer :(int)probNum;
@end
