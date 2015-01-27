//
//  HelpView.h
//  kwest
//
//  Created by Anindya on 9/7/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePopUpView.h"
@interface HelpView : UIView{
    BasePopUpView *tutorialView;
    UIView *contentView;
    UIButton *moreButton;
    UIImageView *tutorialBackgroundImageView;
    UIButton *tutorialCloseButton;
    BOOL isKwestMainTextShowing;
    BOOL isBrainArenaMainTextShowing;
    BOOL isKnowledgePathMainTextShowing;
}
-(void)createTutorialBaseView;

@end
