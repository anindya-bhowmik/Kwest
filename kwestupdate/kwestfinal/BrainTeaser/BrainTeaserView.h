//
//  BrainTeaserView.h
//  kwest
//
//  Created by Anindya on 5/1/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RevMobAds/RevMobAds.h>
#import "cocos2d.h"

@class BasePopUpView;

@interface BrainTeaserView : CCNode {
    CCSprite *backgroundBg;
    UIView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIScrollView *scrollView;
    
   
    CCMenu *back;
    NSMutableArray *menuArray;
    NSMutableArray *solutionArray;
    
    GLuint effectID;
    RevMobBannerView *ad;
    BOOL adDidRecieve;
}
+(CCScene*)scene;

@end
