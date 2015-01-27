//
//  BrainArenaHelpView.m
//  kwest
//
//  Created by Anindya on 9/10/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "BrainArenaHelpView.h"
#import "Utility.h"
@implementation BrainArenaHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        // Initialization code
//        scrollView = [[UIScrollView alloc]initWithFrame:frame];
//        [self addSubview:scrollView];
//        brainArenaTextView = [[UIImageView alloc]init];
//        [scrollView addSubview:brainArenaTextView];
    }
    return self;
}

-(void)showBrainArenaMainText{
    UIImage *brainAreneTextImage = [UIImage imageNamed:@"BrainArena-I-txt"];
    UIImageView *brainArenaTextView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, brainAreneTextImage.size.width, brainAreneTextImage.size.height)];
    brainArenaTextView.image = brainAreneTextImage;
    [self addSubview:brainArenaTextView];
}


-(void)showBrainArenaMoreText{
        UIImage *brainAreneTextImage = [UIImage imageNamed:@"BrainArena-II-txt"];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, 0, brainAreneTextImage.size.width, self.frame.size.height);
        ;
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(0, 0, brainAreneTextImage.size.width, self.frame.size.height-80);
        ;
    }
        
        [self addSubview:scrollView];
        
        UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:brainAreneTextImage];
        scrollView.scrollEnabled = YES;
        scrollView.contentSize = CGSizeMake(brainAreneTextImage.size.width, brainAreneTextImage.size.height+brainAreneTextImage.size.height/4);
        [scrollView addSubview:sprintTextImageView];
        
    
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
