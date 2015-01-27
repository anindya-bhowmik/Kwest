//
//  BrainTeaserProblemScene.m
//  kwest
//
//  Created by Anindya on 5/4/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "BrainTeaserProblemScene.h"
#import "BrainTeaserView.h"
//#import "ResolutionConstant.h"
#import "Utility.h"
#import "GameData.h"
#define BrainTeaserProblemSceneTag 333
@implementation BrainTeaserProblemScene
@synthesize problemNumber;

-(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    BrainTeaserProblemScene *layer = [BrainTeaserProblemScene node];
    layer.tag = BrainTeaserProblemSceneTag;
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}
+(id)nodeWithGameLevel:(int)level{
    return  [[self alloc] initWithProblemNumer:level];
}

-(void)onExit{
    [super onExit];
   
   
}

-(id)initWithProblemNumer :(int)probNum{
    if(self = [super init]){
        adDidRecieve = FALSE;
        problemNumber = probNum;
        NSString *probImage = [NSString stringWithFormat:@"BT%d.png",probNum];
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
        if(probNum ==0){
        crossButton.frame = CGRectMake((DeviceWidth-crosBtnImage.size.width)/2,0,crosBtnImage.size.width,crosBtnImage.size.height);
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, crossButton.frame.size.height, image.size.width, image.size.height)];
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
            
            
        }
        else if(probNum == 1){
            
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, DeviceHeight/48, image.size.width, image.size.height+crosBtnImage.size.height)];
            if (![[GameData GameDataManager]returnpremium]) {
                scrollView.frame = CGRectMake((DeviceWidth-image.size.width)/2, (DeviceHeight/48)+50, image.size.width, image.size.height+crosBtnImage.size.height);
            }
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            crossButton.frame = CGRectMake((probImageView.frame.size.width-crosBtnImage.size.width)/2,probImageView.frame.size.height,crosBtnImage.size.width,crosBtnImage.size.height);
            [scrollView addSubview:crossButton];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
            [probImageView release];
        }
        else if(probNum==2){
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
            [probImageView release];
        }
        else{
            crossButton.frame = CGRectMake((DeviceWidth-crosBtnImage.size.width)/2,(DeviceHeight-crosBtnImage.size.height),crosBtnImage.size.width,crosBtnImage.size.height);
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(DeviceWidth/2-image.size.width/2,DeviceHeight/48,image.size.width,image.size.height)];
            if (![[GameData GameDataManager]returnpremium]) {
                scrollView.frame = CGRectMake((DeviceWidth-image.size.width)/2, (DeviceHeight/48)+50, image.size.width, image.size.height+crosBtnImage.size.height);
            }
            UIImageView *probImageView = [[UIImageView alloc]initWithImage:image];
            [scrollView addSubview:probImageView];
            scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
            scrollView.scrollEnabled = YES;
            [[[CCDirector sharedDirector]view ]addSubview:scrollView];
            [[[CCDirector sharedDirector]view ]addSubview:crossButton];
            [probImageView release];
        }
    //        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, crosBtnImage.size.height, image.size.width, image.size.height)];
//        scrollView.contentSize = CGSizeMake(image.size.width, image.size.height+(image.size.height/2));
        [crossButton addTarget:self action:@selector(backToBrainTeaserView) forControlEvents:UIControlEventTouchDown];
       // [probImageView addSubview:crossButton];
       /// [[[CCDirector sharedDirector]openGLView]addSubview:scrollView];
      
    }
    return self;
}

//- (void)revmobAdDidFailWithError:(NSError *)error{
//   // [ad release];
//}

-(void)onEnter{
    
    
    [super onEnter];
}

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
//    CGPoint location = [touch locationInView: [touch view]];
//    if(touch && probSprite != nil) {
//        CGPoint location = [touch locationInView: [touch view]];
//        CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
//        oldPoint =convertedPoint;
//        return YES;
//    };
    
    return NO;
    // returning YES means we want to receive the moved/ended/cancelled info. if we return NO, it'll just ignore those events
}


- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    if(touch &&  probSprite!= nil) {
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedPoint = [[CCDirector sharedDirector]convertToGL:location];
        CGPoint newPoint = CGPointMake(40, (probSprite.anchorPoint.y+ (convertedPoint.y - oldPoint->y)));
        probSprite.position = newPoint;
}
}

-(void)backToBrainTeaserView{
    //[[[CCDirector sharedDirector]openGLView]removeFromSuperview];'
//    if (adDidRecieve) {
//        [ad removeFromSuperview];
//    }
//    
//    [ad release];
    [crossButton removeFromSuperview];  
    [scrollView removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainTeaserView scene]]];
}

//- (void)revmobAdDidReceive{
//    CCArray *layers =[[CCDirector sharedDirector]runningScene].children;
//    for(int i = 0 ;i < [layers count];i++){
//        CCLayer *layer = [layers objectAtIndex:i];
//        if(layer.tag == BrainTeaserProblemSceneTag){
//            adDidRecieve = YES;
//            ad.frame = CGRectMake(DeviceWidth/2-RevMobBannerWidth/2, DeviceHeight-50, RevMobBannerWidth, 50);
//           // if (problemNumber!= 0 && problemNumber!=2) {
//                [[[CCDirector sharedDirector]view ]addSubview:ad];
//          //  }
//          //  [[[CCDirector sharedDirector]view]addSubview:ad];
//            break;
//        }
//    }
////    if(!adDidRecieve){
////        [ad release];
////    }
//}

@end
