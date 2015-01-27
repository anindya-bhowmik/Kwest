//
//  Beyond.h
//  kwest
//
//  Created by Future Tech on 4/28/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "cocos2d.h"

@class BasePopUpView;
@class GameData;
@interface Beyond : CCLayer<UITextFieldDelegate> {
    CCSprite *beyondBg;
    GameData *gameData;
    CCSprite *slider1;
    CCSprite *slider2;
    CGPoint touchPoint;
    UISlider *sliderOne;
    UISlider *sliderTwo;
    CCLabelTTF *goldToKnopLbl1;
    CCLabelTTF *goldToKnopLbl2;
    CCLabelTTF *goldToEnergyLbl1;
    CCLabelTTF *goldToEnergyLbl2;
    BOOL *ok1Pressed;
    BOOL *ok2Pressed;
    
    CCMenuItemImage *strengthitem;
    CCMenuItemImage *energyitem;
    CCMenuItemImage *wisdomitem;
    CCMenu *back;
    CCMenu *oracleMenu;
    CCMenu *energyMenu;
    CCMenu *strengthMenu;
    CCMenu *wisdomMenu;
    NSMutableArray *oracleFirstsay;
    NSMutableArray *oracleSecondSayForRight;
    NSMutableArray *oracleSecondSayForWrong;
    NSMutableArray *oracleRightAnswerArray;
    UITextField *answertextField;
    UIAlertView *conversationAlert;
    NSString *answerText;
    
    BasePopUpView *tutorialView;
    UIButton *tutorialCloseButton;
    UIImageView *tutorialBackgroundImageView;
    
    GLuint effectID;
   // NSString *identifier;
}
+(CCScene*)scene;
@end
