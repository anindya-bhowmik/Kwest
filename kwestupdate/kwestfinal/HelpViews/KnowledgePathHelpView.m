//
//  KnowledgePathHelpView.m
//  kwest
//
//  Created by Anindya on 9/10/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "KnowledgePathHelpView.h"
#import "Utility.h"
@implementation KnowledgePathHelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);//CGSizePointMake(frame.size.width/2, frame.size.height/2);
    }
    return self;
}

-(void)showKnowledgePathMainText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"KnowledgePath-I-txt"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height-80);
    }


    [self addSubview:scrollView];

    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];

    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
}

-(void)showKnowledgePathMoreText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"KnowledgePath-II-txt"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height);
    
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height-80);
    }
    
    [self addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/4);
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
