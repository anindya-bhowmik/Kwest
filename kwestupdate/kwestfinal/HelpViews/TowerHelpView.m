//
//  TowerHelpView.m
//  kwest
//
//  Created by Anindya on 9/8/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "TowerHelpView.h"
#import "Utility.h"
@implementation TowerHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isTowerTutorialShowing = YES;
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
       // self.backgroundColor = [UIColor redColor];
        tutorialText = [[UIImageView alloc]init];
        [self addSubview:tutorialText];
        towerToggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [towerToggleButton addTarget:self action:@selector(toggleBetweenQuestandTower) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:towerToggleButton];
        [self createTowerTutorial];
    }
    return self;
}

-(void)createTowerTutorial{
      UIImage *towerImage = [UIImage imageNamed:@"TwrWsdmtxt"];
    tutorialText.image = towerImage;
    tutorialText.frame = CGRectMake(self.frame.size.width/2-towerImage.size.width/2, 0, towerImage.size.width, towerImage.size.height);
    UIImage *towerToggleButtonImage = [UIImage imageNamed:@"Quests"];
    towerToggleButton.frame = CGRectMake(self.frame.size.width/2-towerToggleButtonImage.size.width/2, tutorialText.frame.size.height+10, towerToggleButtonImage.size.width, towerToggleButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        towerToggleButton.frame = CGRectMake(self.frame.size.width/2-towerToggleButtonImage.size.width/2, tutorialText.frame.size.height+5, towerToggleButtonImage.size.width, towerToggleButtonImage.size.height);
    }
    [towerToggleButton setBackgroundImage:towerToggleButtonImage forState:UIControlStateNormal];
}

-(void)showQuestTutorial{
    UIImage *questImage = [UIImage imageNamed:@"Queststxt"];
    tutorialText.image = questImage;
    tutorialText.frame = CGRectMake(0, 0, questImage.size.width, questImage.size.height);
    UIImage *towerToggleButtonImage = [UIImage imageNamed:@"Tower"];
    towerToggleButton.frame = CGRectMake(self.frame.size.width/2-towerToggleButtonImage.size.width/2, tutorialText.frame.size.height+10, towerToggleButtonImage.size.width, towerToggleButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        towerToggleButton.frame = CGRectMake(self.frame.size.width/2-towerToggleButtonImage.size.width/2, tutorialText.frame.size.height+5, towerToggleButtonImage.size.width, towerToggleButtonImage.size.height);
    }
    [towerToggleButton setBackgroundImage:towerToggleButtonImage forState:UIControlStateNormal];

}

-(void)toggleBetweenQuestandTower{
    if(isTowerTutorialShowing){
        isTowerTutorialShowing = NO;
        [self showQuestTutorial];
    }
    else{
        isTowerTutorialShowing = YES;
        [self createTowerTutorial];
    }
}



-(void)backToBaseTutorial{

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
