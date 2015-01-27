//
//  BoostsHelpView.m
//  kwest
//
//  Created by Anindya on 9/11/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "BoostsHelpView.h"
#import "Utility.h"

#define keyofwisdombtnhelptag 1
#define keyofstrengthbtnhelptag 2
#define keyofenergybtnhelptag 3
@implementation BoostsHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self createBoostBaseView];
    }
    return self;
}

-(void)createBoostBaseView{
    UIImage *boostTextImage = [UIImage imageNamed:@"Booststxt"];
    
    
    UIImage *keyofWisdomButtonImage = [UIImage imageNamed:@"Key_Wisdom_but"];
    UIImage *keyofEnergyButtonImage = [UIImage imageNamed:@"Key_Energy_but"];
    UIImage *keyofStrengthButtonImage = [UIImage imageNamed:@"Key_Strength_but"];
    

    UIImageView *beyondSubTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, boostTextImage.size.width, boostTextImage.size.height)];
    beyondSubTextImageView.image = boostTextImage;
    
    [self addSubview:beyondSubTextImageView];
    
    float xmargin =(self.frame.size.width -(keyofWisdomButtonImage.size.width+keyofStrengthButtonImage.size.width))/3;
    
    
    UIButton *keyodWisdomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyodWisdomButton.frame = CGRectMake(xmargin+5,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        keyodWisdomButton.frame = CGRectMake(xmargin-15,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    }
    keyodWisdomButton.tag = keyofwisdombtnhelptag;
    [keyodWisdomButton setBackgroundImage:keyofWisdomButtonImage forState:UIControlStateNormal];
    [keyodWisdomButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:keyodWisdomButton];
    
    UIButton *keyodStrengthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyodStrengthButton.frame = CGRectMake(keyodWisdomButton.frame.size.width+xmargin*2,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
         keyodStrengthButton.frame = CGRectMake((keyodWisdomButton.frame.size.width+xmargin*2)-15,beyondSubTextImageView.frame.size.height+30, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    }

    keyodStrengthButton.tag = keyofstrengthbtnhelptag;
    [keyodStrengthButton setBackgroundImage:keyofStrengthButtonImage forState:UIControlStateNormal];
    [keyodStrengthButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:keyodStrengthButton];
    
    UIButton *keyofEnergyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyofEnergyButton.frame = CGRectMake(self.frame.size.width/2-keyofEnergyButtonImage.size.width/2,beyondSubTextImageView.frame.size.height+keyodStrengthButton.frame.size.height+40, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        keyofEnergyButton.frame = CGRectMake((self.frame.size.width/2-keyofEnergyButtonImage.size.width/2)-15,beyondSubTextImageView.frame.size.height+keyodStrengthButton.frame.size.height+40, keyofWisdomButtonImage.size.width, keyofWisdomButtonImage.size.height);
    }
    keyofEnergyButton.tag = keyofenergybtnhelptag;
    [keyofEnergyButton setBackgroundImage:keyofEnergyButtonImage forState:UIControlStateNormal];
    [keyofEnergyButton addTarget:self action:@selector(showBoostSubTutorial:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:keyofEnergyButton];
}

-(void)createBoostSubTutorial:(int)number{
    //UIButton *btn = (UIButton*)sender;
    UIImage *beyondTextImage = [UIImage imageNamed:[NSString stringWithFormat:@"boostSubtutorialtext%d",number]];
    
    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, beyondTextImage.size.width, beyondTextImage.size.height)];
    beyondTextImageView.image = beyondTextImage;
    [self addSubview:beyondTextImageView];
    float yMargin = (self.frame.size.height - (beyondTextImageView.frame.size.height+boostButtonImage.size.height))/2;
    UIButton *boostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostButton.frame = CGRectMake(self.frame.size.width/2-boostButtonImage.size.width/2, beyondTextImageView.frame.size.height+yMargin, boostButtonImage.size.width, boostButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
     boostButton.frame = CGRectMake(self.frame.size.width/2-boostButtonImage.size.width/2, beyondTextImageView.frame.size.height+yMargin-10, boostButtonImage.size.width, boostButtonImage.size.height);
    }
    [boostButton setBackgroundImage:boostButtonImage forState:UIControlStateNormal];
    [boostButton addTarget:self action:@selector(showBoosttutorial) forControlEvents:UIControlEventTouchDown];
    [self addSubview:boostButton];
}

-(void)clearView{
    for(UIView *subViews in self.subviews){
        [subViews removeFromSuperview];
    }
}

-(void)showBoostSubTutorial:(id)Sender{
    [self clearView];
    UIButton *btn = (UIButton *)Sender;
    [self createBoostSubTutorial:btn.tag];
}

-(void)showBoosttutorial{
    [self clearView];
    [self createBoostBaseView];
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
