//
//  HelloWorldLayer.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 10/10/2012.
//  Copyright AITL 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "GameData.h"

// HelloWorldLayer
@class TutorialView;
@class BasePopUpView;
@class CCUIViewWrapper;
@interface Menu : CCLayer
{
    GameData *gamedata;
    CCSprite *menuBg;
    TutorialView *tutView;
    
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    UIButton *moreButton;
    CCMenu *knowledgePathMenu;
    CCMenu *profileMenu;
    CCMenu *brainArenaMenu;
    CCMenu *towerOfWisdomMenu;
    CCMenu *beyondMenu;
    CCMenu *threePointsMenu;
    CCUIViewWrapper *wrapper;
    GLuint effectId;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)currentTime:(NSString*)refildate;
//-(void)addTable;
@end
