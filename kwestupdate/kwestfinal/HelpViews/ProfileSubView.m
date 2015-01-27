//
//  ProfileSubView.m
//  kwest
//
//  Created by Anindya on 9/11/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "ProfileSubView.h"
#import "Utility.h"
@implementation ProfileSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = CGPointMake(frame.size.width/2,frame.size.height/2);
    }
    return self;
}

-(void)showAttributeText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"Attributestxt"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(self.frame.size.width/2-sprintTextImage.size.width/2, 0, sprintTextImage.size.width, self.frame.size.height);
    
    
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height-70);
    }
    [self addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, scrollView.frame.size.height+sprintTextImage.size.height/1.5);
    [scrollView addSubview:sprintTextImageView];

}

-(void)showStatisticsText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"Statisticstxt"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(self.frame.size.width/2-sprintTextImage.size.width/2, 0, sprintTextImage.size.width, self.frame.size.height);
    
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(0, 0, sprintTextImage.size.width, self.frame.size.height-70);
    }
    
    [self addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
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
