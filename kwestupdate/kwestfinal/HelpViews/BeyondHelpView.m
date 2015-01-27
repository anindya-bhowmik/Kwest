//
//  BeyondHelpView.m
//  kwest
//
//  Created by Anindya on 9/11/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "BeyondHelpView.h"
#import "BoostsHelpView.h"
#import "Utility.h"
@implementation BeyondHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self createBeyondBaseView];
    }
    return self;
}

-(void)createBeyondBaseView{
    //self.backgroundColor = [UIColor redColor];
    UIImage *beyondTextImage = [UIImage imageNamed:@"Beyondtxt"];
    
    UIImage *theWellofEnergyButtonImage = [UIImage imageNamed:@"Well"];
    UIImage *theTreeofKnowledgeButtonImage = [UIImage imageNamed:@"Tree"];
    
    UIImage *oracleButtonImage = [UIImage imageNamed:@"Oracletut"];
    UIImage *boostsButtonImgae = [UIImage imageNamed:@"Boosts"];
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, beyondTextImage.size.width, beyondTextImage.size.height)];
    beyondTextImageView.image = beyondTextImage;
    [self addSubview:beyondTextImageView];
    
    float xMargin = (self.frame.size.width - (theWellofEnergyButtonImage.size.width+theTreeofKnowledgeButtonImage.size.width))/3;
    
    float yMargin = (self.frame.size.height-beyondTextImageView.frame.size.height)-(theWellofEnergyButtonImage.size.height+oracleButtonImage.size.height+beyondTextImageView.frame.size.height)/3;
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        yMargin -= 15;
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        xMargin = ((self.frame.size.width - (theWellofEnergyButtonImage.size.width+theTreeofKnowledgeButtonImage.size.width))/3)-15;
        yMargin = ((self.frame.size.height-beyondTextImageView.frame.size.height)-(theWellofEnergyButtonImage.size.height+oracleButtonImage.size.height+beyondTextImageView.frame.size.height)/3-70);
    }
    
    UIButton *theWellofEnegergyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theWellofEnegergyButton.frame = CGRectMake(xMargin, yMargin+beyondTextImageView.frame.size.height, theWellofEnergyButtonImage.size.width, theWellofEnergyButtonImage.size.height);
    [theWellofEnegergyButton setBackgroundImage:theWellofEnergyButtonImage forState:UIControlStateNormal];
    [theWellofEnegergyButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    theWellofEnegergyButton.tag = 0;
    [self addSubview:theWellofEnegergyButton];
    
    
    UIButton *theTreeofKnowledgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theTreeofKnowledgeButton.frame = CGRectMake(xMargin*2+theWellofEnegergyButton.frame.size.width, yMargin+beyondTextImageView.frame.size.height, theTreeofKnowledgeButtonImage.size.width, theTreeofKnowledgeButtonImage.size.height);
    [theTreeofKnowledgeButton setBackgroundImage:theTreeofKnowledgeButtonImage forState:UIControlStateNormal];
    [theTreeofKnowledgeButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    theTreeofKnowledgeButton.tag = 1;
    [self addSubview:theTreeofKnowledgeButton];
    
    
    UIButton *oracleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oracleButton.frame = CGRectMake(xMargin, yMargin+theWellofEnegergyButton.frame.size.height+beyondTextImageView.frame.size.height, oracleButtonImage.size.width, oracleButtonImage.size.height);
    [oracleButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    oracleButton.tag = 2;
    [oracleButton setBackgroundImage:oracleButtonImage forState:UIControlStateNormal];
    [self addSubview:oracleButton];
    
    UIButton *boostsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boostsButton.frame = CGRectMake(xMargin*2+theWellofEnegergyButton.frame.size.width, yMargin+beyondTextImageView.frame.size.height+theTreeofKnowledgeButton.frame.size.height, boostsButtonImgae.size.width, boostsButtonImgae.size.height);
    [boostsButton setBackgroundImage:boostsButtonImgae forState:UIControlStateNormal];
    [boostsButton addTarget:self action:@selector(showBeyondSubTutorials:) forControlEvents:UIControlEventTouchUpInside];
    boostsButton.tag = 3;
    [self addSubview:boostsButton];

}

-(void)clearView{
    for(UIView *subViews in self.subviews){
        [subViews removeFromSuperview];
    }
}

-(IBAction)showBeyondSubTutorials:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 0:
        case 1:
        case 2:
            [self clearView];
            [self showSubTutorial:btn.tag];
            break;
        case 3:
            [self showBoosttutorial];
            break;
        default:
            break;
    }
}

-(void)showBoosttutorial{
    [self clearView];
    BoostsHelpView *helpView = [[BoostsHelpView alloc]initWithFrame:self.frame];
    [self addSubview:helpView];
}

-(void)showSubTutorial:(int)btnTag{
    UIImage *beyondsubTextImage = [UIImage imageNamed:[NSString stringWithFormat:@"Beyond%dtxt",btnTag]];
    
    
    UIImage *beyondButtonImage = [UIImage imageNamed:@"Beyond"];
    
    UIImageView *beyondSubTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-beyondsubTextImage.size.width/2, 0, beyondsubTextImage.size.width, beyondsubTextImage.size.height)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        beyondSubTextImageView.frame = CGRectMake(self.frame.size.width/2-beyondsubTextImage.size.width/2, 0, beyondsubTextImage.size.width, beyondsubTextImage.size.height);
    }
    beyondSubTextImageView.image = beyondsubTextImage;
    [self addSubview:beyondSubTextImageView];
    
    UIButton *beyondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beyondButton.frame = CGRectMake(self.frame.size.width/2-beyondButtonImage.size.width/2,(DeviceHeight/1.89), beyondButtonImage.size.width, beyondButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        beyondButton.frame = CGRectMake(self.frame.size.width/2-beyondButtonImage.size.width/2,(DeviceHeight/2.2), beyondButtonImage.size.width, beyondButtonImage.size.height);
    }
    //beyondButton.tag = 2;
    [beyondButton setBackgroundImage:beyondButtonImage forState:UIControlStateNormal];
    [beyondButton addTarget:self action:@selector(showBeyondTutorial) forControlEvents:UIControlEventTouchDown];
    [self addSubview:beyondButton];
}

-(void)showBeyondTutorial{
    [self clearView];
    [self createBeyondBaseView];
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
