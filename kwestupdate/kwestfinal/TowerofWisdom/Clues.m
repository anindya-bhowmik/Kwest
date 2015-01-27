//
//  Clues.m
//  kwest
//
//  Created by Tashnuba Jabbar on 14/11/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "Clues.h"
//#import "ResolutionConstant.h"
#import "QuestScene.h"
@implementation Clues

-(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    Clues *layer = [Clues node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;

}


+(id)nodeWithClue:(int)clueNumber{
    return  [[self alloc] initWithClueNumber:clueNumber];

}

-(id)initWithClueNumber:(int)number{
    if(self = [super init]){
        NSString *clueImage = [NSString stringWithFormat:@"Clue%dimage",number];
        NSString *crossImage = [NSString stringWithFormat:@"BackButton"];
        UIImage *crosBtnImage = [UIImage imageNamed:crossImage];
        UIImage *image = [UIImage imageNamed:clueImage];
        
        scroll = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2,DeviceHeight/20,image.size.width,image.size.height)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        scroll.contentSize  = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
        [scroll addSubview:imageView];
        [[[CCDirector sharedDirector]view ]addSubview:scroll];
                //        UIImageView *probImageView = [[UIImageView alloc]initWithFrame:scrollView.frame];
        //        probImageView.image = image;
        //
        //        scrollView.scrollEnabled = YES;
        //        [scrollView addSubview:probImageView];
        crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [crossButton setBackgroundImage:crosBtnImage forState:UIControlStateNormal];
        crossButton.frame = CGRectMake((DeviceWidth-crosBtnImage.size.width)/2,DeviceHeight-crosBtnImage.size.height,crosBtnImage.size.width,crosBtnImage.size.height);
        [crossButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        [[[CCDirector sharedDirector]view ]addSubview:crossButton];
    }
    return self;
}

-(void)goToClues:(id)sender{
   
}

-(void)back{
   
    [crossButton removeFromSuperview];
    [scroll removeFromSuperview];

    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[QuestScene scene]]];
}
@end
