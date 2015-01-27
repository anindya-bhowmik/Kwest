//
//  BTSolution.m
//  kwest
//
//  Created by Anindya on 5/6/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "BTSolution.h"
#import "BrainTeaserView.h"

#define solutionAlertTag     1
//#import "ResolutionConstant.h"
@implementation BTSolution


-(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    BTSolution *layer = [BTSolution node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}
+(id)nodeWithGameLevel:(int)level{
    return  [[self alloc] initWithSolutionNumer:level];
}

-(id)initWithSolutionNumer:(int)solNum{
    if(self = [super init]){
        if(solNum==7 || solNum==8 || solNum == 3){
        NSString *probImage = [NSString stringWithFormat:@"BTS%d",solNum];
        NSString *crossImage = [NSString stringWithFormat:@"BackButton.png"];
        UIImage *crosBtnImage = [UIImage imageNamed:crossImage];
        UIImage *image = [UIImage imageNamed:probImage];
        
        
        //        UIImageView *probImageView = [[UIImageView alloc]initWithFrame:scrollView.frame];
        //        probImageView.image = image;
        //
        //        scrollView.scrollEnabled = YES;
        //        [scrollView addSubview:probImageView];
        crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [crossButton setBackgroundImage:crosBtnImage forState:UIControlStateNormal];
        if(solNum ==0){
            crossButton.frame = CGRectMake((DeviceWidth-crosBtnImage.size.width)/2,0,crosBtnImage.size.width,crosBtnImage.size.height);
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, crossButton.frame.size.height, image.size.width, image.size.height)];
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
            
        }
        else if(solNum == 1){
            
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, DeviceHeight/48, image.size.width, image.size.height+crosBtnImage.size.height)];
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            crossButton.frame = CGRectMake((probImageView.frame.size.width-crosBtnImage.size.width)/2,probImageView.frame.size.height,crosBtnImage.size.width,crosBtnImage.size.height);
            [scrollView addSubview:crossButton];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
        }
        else if(solNum==2){
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, DeviceHeight/48, image.size.width, image.size.height+crosBtnImage.size.height)];
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            crossButton.frame = CGRectMake((probImageView.frame.size.width-crosBtnImage.size.width)/2,0,crosBtnImage.size.width,crosBtnImage.size.height);
            [scrollView addSubview:crossButton];
            
            probImageView.frame = CGRectMake(0,crossButton.frame.size.height,image.size.width,image.size.height);
            [scrollView addSubview:probImageView];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+crosBtnImage.size.height+(image.size.height/1.5));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
        }
        else{
            crossButton.frame = CGRectMake((DeviceWidth-crosBtnImage.size.width)/2,(DeviceHeight-crosBtnImage.size.height),crosBtnImage.size.width,crosBtnImage.size.height);
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(DeviceWidth/2-image.size.width/2,DeviceHeight/48,image.size.width,image.size.height)];
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
        }
        //        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, crosBtnImage.size.height, image.size.width, image.size.height)];
        //        scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
        [crossButton addTarget:self action:@selector(backToBrainTeaserView) forControlEvents:UIControlEventTouchDown];
        // [probImageView addSubview:crossButton];
        /// [[[CCDirector sharedDirector]openGLView]addSubview:scrollView];
        }
        else{
            NSString *alertTitle;
            NSString *alertText = @"";
            switch (solNum) {
                case 6:
                    alertTitle = @"Solutions for Riddles - 1";
                    alertText = @"1. Your Son \n 2. Nothing \n 3. A coffin \n 4. Dead people won't really care if its legal";
                    break;
                case 5:
                     alertTitle = @"Solutions for Riddles - 2";
                    alertText = @"1. White. Only in the north pole can all directions be south.\n 2. There are more of them \n 3. Throw it up \n 4. 12.44";
                    break;
                case 4:
                    alertTitle = @"Solutions for Riddles - 3";
                    alertText = @"1. Exchange Camels \n\n 2. You will either give me the gold coin or nothing. \n\n 3. Fill the 5-L , and pour into the 3-L. You have 2 Liters left in the 5-L , empty the 3-L, and put the 2 Liters in there... Fill the 5-L , and empty 1 Liter from it into the 3-L bowl. You're left with 4 Liters. \n\n 4. Divide them into 3 groups of 3. Compare two groups ... Now you have a group of 3 balls that contain the heavier one. Use similar logic to find the heaviest out of these 3. ";
                    break;
                default:
                    break;
            }
                    UIAlertView *solutionAlert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertText delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    solutionAlert.tag = solutionAlertTag;
                    [solutionAlert show];
            
        }
    }
    return self;
}
-(void)backToBrainTeaserView{
    //[[[CCDirector sharedDirector]openGLView]removeFromSuperview];
    [crossButton removeFromSuperview];
    [scrollView removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainTeaserView scene]]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag ==solutionAlertTag){
[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainTeaserView scene]]];
    }
}

@end
