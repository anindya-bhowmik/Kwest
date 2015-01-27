//
//  TowerHelpView.h
//  kwest
//
//  Created by Anindya on 9/8/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TowerHelpView : UIView{
    UIImageView *tutorialText;
    UIButton *towerToggleButton;
    UIButton *backButton;
    BOOL isTowerTutorialShowing;
}
-(void)createTowerTutorial;
@end
