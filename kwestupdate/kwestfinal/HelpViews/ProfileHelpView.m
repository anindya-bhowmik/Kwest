//
//  ProfileHelpView.m
//  kwest
//
//  Created by Anindya on 9/10/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "ProfileHelpView.h"
#import "ProfileSubView.h"
#import "BoostsHelpView.h"
#import "Utility.h"
@implementation ProfileHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self showProfileMainText];
    }
    return self;
}
-(void)showProfileMainText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"Profiletxt"];
    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
//    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.frame = CGRectMake(25, 30, sprintTextImage.size.width, self.frame.size.height-60);
//    ;
//    
//    
//    [self addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-sprintTextImage.size.width/2, 0, sprintTextImage.size.width, sprintTextImage.size.height)];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
  //  scrollView.scrollEnabled = NO;
    sprintTextImageView.image = sprintTextImage;
    [self addSubview:sprintTextImageView];
    float xmargin =(self.frame.size.width -(attributeButtonImage.size.width+statisticsButtonImage.size.width))/3;
    
    UIButton *attributesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attributesButton.frame = CGRectMake(xmargin+5,sprintTextImageView.frame.size.height+10, attributeButtonImage.size.width, attributeButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        attributesButton.frame = CGRectMake(xmargin-10,sprintTextImageView.frame.size.height+10, attributeButtonImage.size.width, attributeButtonImage.size.height);
    }
    // attributesButton.tag = keyofwisdombtntag;
    [attributesButton setBackgroundImage:attributeButtonImage forState:UIControlStateNormal];
    [attributesButton addTarget:self action:@selector(showAttributesTutorial) forControlEvents:UIControlEventTouchDown];
    [self addSubview:attributesButton];
    
    UIButton *statisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    statisticsButton.frame = CGRectMake(attributesButton.frame.size.width+xmargin*2,sprintTextImageView.frame.size.height+10, statisticsButtonImage.size.width, statisticsButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        statisticsButton.frame = CGRectMake((attributesButton.frame.size.width+xmargin*2)-15,sprintTextImageView.frame.size.height+10, statisticsButtonImage.size.width, statisticsButtonImage.size.height);
    }

    //keyodStrengthButton.tag = keyofstrengthbtntag;
    [statisticsButton setBackgroundImage:statisticsButtonImage forState:UIControlStateNormal];
    [statisticsButton addTarget:self action:@selector(showStatisticsTutorial) forControlEvents:UIControlEventTouchDown];
    [self addSubview:statisticsButton];
    
    UIButton *boostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostButton.frame = CGRectMake(self.frame.size.width/2-boostButtonImage.size.width/2,sprintTextImageView.frame.size.height+statisticsButton.frame.size.height+10, boostButtonImage.size.width, boostButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
           boostButton.frame = CGRectMake((self.frame.size.width/2-boostButtonImage.size.width/2)-15,sprintTextImageView.frame.size.height+statisticsButton.frame.size.height+10, boostButtonImage.size.width, boostButtonImage.size.height);
    }
    // keyofEnergyButton.tag = keyofenergybtntag;
    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
    [self addSubview:boostButton];
}


-(void)clearView{
    for(UIView *subViews in self.subviews){
        [subViews removeFromSuperview];
    }
}


-(void)showAttributesTutorial{
    [self clearView];
    ProfileSubView *subView = [[ProfileSubView alloc]initWithFrame:self.frame];
    [subView showAttributeText];
    [self addSubview:subView];
}

-(void)showStatisticsTutorial{
    [self clearView];
    ProfileSubView *subView = [[ProfileSubView alloc]initWithFrame:self.frame];
    [subView showStatisticsText ];
    [self addSubview:subView];
}

-(void)showBoosttutorial{
    [self clearView];
    BoostsHelpView *helpView = [[BoostsHelpView alloc]initWithFrame:self.frame];
    [self addSubview:helpView];
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
