//
//  BasePopUpView.m
//  Fullmiere
//
//  Created by Bjit Ltd on 12/5/12.
//
//

#import "BasePopUpView.h"
#import "ResolutionConstant.h"

@implementation BasePopUpView

@synthesize popUpView,alphaView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight);  //0, 0, 320, 480
     alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)]; //0, 0, 320, 480
        [self addSubview:alphaView];
        alphaView.backgroundColor = [UIColor grayColor];
        alphaView.alpha = 0.4;
        
        popUpView = [[UIView alloc] initWithFrame:CGRectMake(DeviceWidth/12.8, DeviceHeight/12, DeviceWidth/1.20754, DeviceHeight/1.263157)]; //25, 40, 265, 380
        [self addSubview:popUpView];
        popUpView.center = self.center;
        [UIView animateWithDuration: 1.0 animations:^{
            alphaView.alpha = 0.7;
        }];
        
        
    }
    return self;
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
