//
//  TutorialView.m
//  kwest
//
//  Created by Anindya on 7/1/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "TutorialView.h"
//#import "ResolutionConstant.h"
@implementation TutorialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        [self createMainView];
    }
    return self;
}

-(void)createMainView{
    UIImage *bgImage = [UIImage imageNamed:@"BlueBG"];
    backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-bgImage.size.width/2, DeviceHeight/16, bgImage.size.width, bgImage.size.height)];
    backgroundImageView.image = bgImage;
    [self addSubview:backgroundImageView];
    scrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(20, 30, backgroundImageView.frame.size.width-40, backgroundImageView.frame.size.height-60)];
    [scrollView setBackgroundColor:[UIColor redColor]];
    [backgroundImageView addSubview:scrollView];
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
