//
//  HelpView.m
//  kwest
//
//  Created by Anindya on 9/7/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "HelpView.h"
#import "TowerHelpView.h"
#import "BrainArenaHelpView.h"
#import "KnowledgePathHelpView.h"
#import "ProfileHelpView.h"
#import "BeyondHelpView.h"
#import "OptionView.h"
#import "Utility.h"
@implementation HelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isKwestMainTextShowing = YES;
        isBrainArenaMainTextShowing = NO;
        isKnowledgePathMainTextShowing = NO;
    }
    return self;
}

-(void)createTutorialBaseView{
    //    gamedata.isTutorialShown = FALSE;
    //    [self disableTouch];
    
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *moreButtonImage = [UIImage imageNamed:@"More"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    //    tutorialView.backgroundColor = [UIColor grayColor];
    //    tutorialView.alpha = 0.5;
    [self addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(DeviceWidth/16, DeviceHeight/16, tutorialBackgroundImageView.frame.size.width-40, tutorialBackgroundImageView.frame.size.height-55)];
   // contentView.backgroundColor = [UIColor redColor];
    [tutorialBackgroundImageView addSubview:contentView];
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+30, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }

    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
   
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.23, moreButtonImage.size.width, moreButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.18, moreButtonImage.size.width, moreButtonImage.size.height);
    }
    [moreButton setBackgroundImage:moreButtonImage forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showMoretext) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:moreButton];
    
     [self showKwestMainText];
}

-(void)clearTutorialBaseView{
    for(UIView *subViews in contentView.subviews){
        [subViews removeFromSuperview];
    }
    [OptionView enableTouch];
}

-(void)showMainView{
    [self removeFromSuperview];
}

-(void)showMoretext{
    moreButton.hidden = YES;
    if(isKwestMainTextShowing){
        isKwestMainTextShowing = NO;
        [self showKwestMoreText];
    }
    else if(isBrainArenaMainTextShowing){
        [self showBrainArenaMoreTextFromTutorial];
    }
    else if(isKnowledgePathMainTextShowing){
        [self showKnowledgePathMoreText];
    }
}


-(void)showKwestMainText{
    isKwestMainTextShowing = YES;
    UIImage *sprintTextImage = [UIImage imageNamed:@"KWEST_Maintxt"];
    //    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
    //    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
    //    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, sprintTextImage.size.height);
    ;
    
    
    [contentView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = NO;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width+60, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
    
}

-(void)showKwestMoreText{
     [self clearTutorialBaseView];
//    for(UIView *subViews in  [tutorialBackgroundImageView subviews]){
//        [subViews removeFromSuperview];
//    }
   // [moreButton removeFromSuperview];
    UIImage *sprintTextImage = [UIImage imageNamed:@"KWEST_Sectionstxt"];
    UIImage *brainArenaButtonImage = [UIImage imageNamed:@"BrainArena"];
    UIImage *beyondButtonImage = [UIImage imageNamed:@"Beyond"];
    UIImage *knowledgepathButtonImage = [UIImage imageNamed:@"KnowledgePath"];
    UIImage *profileButtonImage = [UIImage imageNamed:@"Profile"];
    UIImage *towerofWisdomButtonImage = [UIImage imageNamed:@"Tower"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(contentView.frame.origin.x-20, 0, sprintTextImage.size.width, sprintTextImage.size.height);
    ;
    
    
    [contentView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width+60, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
    float xmargin =(contentView.frame.size.width -(brainArenaButtonImage.size.width+beyondButtonImage.size.width))/3;
    float ymargin = (contentView.frame.size.height-(scrollView.frame.size.height+brainArenaButtonImage.size.height+knowledgepathButtonImage.size.height+towerofWisdomButtonImage.size.height))/4;
    UIButton *brainArenaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    brainArenaButton.frame = CGRectMake(xmargin+3, scrollView.frame.size.height+ymargin+scrollView.frame.origin.y, brainArenaButtonImage.size.width, brainArenaButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
     brainArenaButton.frame = CGRectMake(xmargin-10, scrollView.frame.size.height+5, brainArenaButtonImage.size.width, brainArenaButtonImage.size.height);
    }
    [brainArenaButton setBackgroundImage:brainArenaButtonImage forState:UIControlStateNormal];
    [brainArenaButton addTarget:self action:@selector(gotToBrainArenaFromTutorial) forControlEvents:UIControlEventTouchDown];
    [contentView addSubview:brainArenaButton];
    
    UIButton *beyondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beyondButton.frame = CGRectMake(xmargin+3+brainArenaButton.frame.size.width, scrollView.frame.size.height+ymargin+scrollView.frame.origin.y, beyondButtonImage.size.width, beyondButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
         beyondButton.frame = CGRectMake(xmargin+7+brainArenaButton.frame.size.width, scrollView.frame.size.height+5, beyondButtonImage.size.width, beyondButtonImage.size.height);
    }
    [beyondButton setBackgroundImage:beyondButtonImage forState:UIControlStateNormal];
    [beyondButton addTarget:self action:@selector(goToBeyondFromTutorial) forControlEvents:UIControlEventTouchDown];
    [contentView addSubview:beyondButton];
    
    UIButton *knowledgepathButton = [UIButton buttonWithType:UIButtonTypeCustom];
    knowledgepathButton.frame = CGRectMake(xmargin+3, brainArenaButton.frame.origin.y+brainArenaButtonImage.size.height+ymargin*2, knowledgepathButtonImage.size.width, knowledgepathButtonImage.size.height);
    
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        knowledgepathButton.frame = CGRectMake(xmargin-10, scrollView.frame.size.height+10+brainArenaButton.frame.size.height, knowledgepathButtonImage.size.width, knowledgepathButtonImage.size.height);
    }

    [knowledgepathButton setBackgroundImage:knowledgepathButtonImage forState:UIControlStateNormal];
    [knowledgepathButton addTarget:self action:@selector(gotToKnowledgePathFromTutorial) forControlEvents:UIControlEventTouchDown];
    [contentView addSubview:knowledgepathButton];
    
    
    UIButton *profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profileButton.frame = CGRectMake(xmargin+3+brainArenaButton.frame.size.width, brainArenaButton.frame.origin.y+brainArenaButtonImage.size.height+ymargin*2, profileButtonImage.size.width, profileButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        profileButton.frame = CGRectMake(xmargin+7+brainArenaButton.frame.size.width, scrollView.frame.size.height+10+beyondButton.frame.size.height, profileButtonImage.size.width, profileButtonImage.size.height);
    }

    [profileButton setBackgroundImage:profileButtonImage forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(gotToProfileFromTutorial) forControlEvents:UIControlEventTouchDown];
    [contentView addSubview:profileButton];
    
    UIButton *towerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    towerButton.frame = CGRectMake(contentView.frame.size.width/2-towerofWisdomButtonImage.size.width/2, knowledgepathButton.frame.origin.y+knowledgepathButtonImage.size.height+ymargin*2, towerofWisdomButtonImage.size.width, towerofWisdomButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        towerButton.frame = CGRectMake((contentView.frame.size.width/2-towerofWisdomButtonImage.size.width/2)-20, scrollView.frame.size.height+10+beyondButton.frame.size.height+profileButton.frame.size.height, towerofWisdomButtonImage.size.width, towerofWisdomButtonImage.size.height);
    }
    [towerButton setBackgroundImage:towerofWisdomButtonImage forState:UIControlStateNormal];
    [towerButton addTarget:self action:@selector(goToTowerofWisdomfromTutorial) forControlEvents:UIControlEventTouchDown];
    [contentView addSubview:towerButton];
    
}

-(void)goToTowerofWisdomfromTutorial{
    [self clearTutorialBaseView];
    [moreButton removeFromSuperview];
    TowerHelpView *towerHelp = [[TowerHelpView alloc]initWithFrame:contentView.frame];
    [contentView addSubview:towerHelp];
}

-(void)gotToBrainArenaFromTutorial{
    [self clearTutorialBaseView];
    moreButton.hidden = NO;
    isBrainArenaMainTextShowing = YES;
    BrainArenaHelpView *brainArenaHelp = [[BrainArenaHelpView alloc]initWithFrame:contentView.frame];
    [brainArenaHelp showBrainArenaMainText];
    [contentView addSubview:brainArenaHelp];
}

-(void)showBrainArenaMoreTextFromTutorial{
    [self clearTutorialBaseView];
    isBrainArenaMainTextShowing = NO;
    BrainArenaHelpView *brainArenaHelp = [[BrainArenaHelpView alloc]initWithFrame:contentView.frame];
    [brainArenaHelp showBrainArenaMoreText];
    [contentView addSubview:brainArenaHelp];
}

-(void)gotToKnowledgePathFromTutorial{
    [self clearTutorialBaseView];
    moreButton.hidden = NO;
    isKnowledgePathMainTextShowing = YES;
    KnowledgePathHelpView *knowledgePathHelp = [[KnowledgePathHelpView alloc]initWithFrame:contentView.frame];
    [knowledgePathHelp showKnowledgePathMainText];
    [contentView addSubview:knowledgePathHelp];
}
-(void)showKnowledgePathMoreText{
     [self clearTutorialBaseView];
     isKnowledgePathMainTextShowing = NO;
     KnowledgePathHelpView *knowledgePathHelp = [[KnowledgePathHelpView alloc]initWithFrame:contentView.frame];
     [knowledgePathHelp showKnowledgePathMoreText];
     [contentView addSubview:knowledgePathHelp];
}
-(void)gotToProfileFromTutorial{
    [self clearTutorialBaseView];
    ProfileHelpView *helpView = [[ProfileHelpView  alloc]initWithFrame:contentView.frame];
    [contentView addSubview:helpView];
}

-(void)goToBeyondFromTutorial{
    [self clearTutorialBaseView];
    BeyondHelpView *helpView = [[BeyondHelpView alloc]initWithFrame:contentView.frame];
    [contentView addSubview:helpView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
