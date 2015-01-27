//
//  BrainTeaserView.m
//  kwest
//
//  Created by Anindya on 5/1/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "BrainTeaserView.h"
#import "BrainArenaMenu.h"
#import "BrainTeaserProblemScene.h"
#import "Myquslist.h"
//#import "ResolutionConstant.h"
#import "BTSolution.h"
#import "GameData.h"
#import "BasePopUpView.h"
#import "Utility.h"
#import "Chartboost.h"
#define BrainTeaserSceneTag 444
@implementation BrainTeaserView
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    BrainTeaserView *layer = [BrainTeaserView node];
    layer.tag = BrainTeaserSceneTag;
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}


-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"Brain Teaser"];
        [self showMainView];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
            [self createTutorialBaseView];
        }
        if(![[GameData GameDataManager] returnpremium]){
            if ([[GameData GameDataManager] returnknop]>20)
                [[Chartboost sharedChartboost] showInterstitial];
//            [[RevMobAds session] showFullscreen];
//            ad = [[RevMobAds session] bannerView];
//            ad.delegate = self;
//            [ad loadAd];
        }
        //        if(![[GameData GameDataManager] returnpremium]){
        //            [[RevMobAds session] showFullscreen];
        //            ad = [[RevMobAds session] bannerView];
        //            // ad.delegate = self;
        //            [ad loadAd];
        //            ad.frame = CGRectMake(DeviceWidth/2-RevMobBannerWidth/2, DeviceHeight-50, RevMobBannerWidth, 50);
        //            //            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //            //                ad.frame = CGRectMake(0, 0, 768, 114);
        //            //            } else {
        //            //                ad.frame = CGRectMake(DeviceWidth/2, 430, 320/2, 50);
        //            //
        //            //            }
        //
        //            [[CCDirector sharedDirector]setView:ad];
        //        }
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        effectID =  [[SimpleAudioEngine sharedEngine]playEffect:@"Brain.mp3"];
}

-(void)onExit{
    [super onExit];
    if(adDidRecieve){
        [ad removeFromSuperview];
    }
    [[SimpleAudioEngine sharedEngine]stopEffect:effectID];
}
-(void)createTutorialBaseView{
    [self disableTouch];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"BrainTeaserstxt"];
    
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
    //tutorialView.backgroundColor = [UIColor blackColor];
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+30, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(clearTutorialBaseView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/8.72, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-53);
    
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/8.72, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-53);
    }
    
    [tutorialView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = NO;
    [scrollView addSubview:sprintTextImageView];
    [UIView animateWithDuration:2.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    //  [self showBeyondTutorial];
}


-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}

-(void)enableTouch{
    //  solutionMenu.enabled = YES;
    back.enabled = YES;
    
    for (int i = 0; i<[menuArray count];i++){
        CCMenu *menuItem = (CCMenu *)[menuArray objectAtIndex:i];
        menuItem.enabled = YES;
    }
    for (int i = 0; i<[solutionArray count];i++){
        CCMenu *menuItem = (CCMenu *)[solutionArray objectAtIndex:i];
        menuItem.enabled = YES;
    }
    
    
}

-(void)disableTouch{
    //solutionMenu.enabled = NO;
    for (int i = 0; i<[menuArray count];i++){
        CCMenu *menuItem = (CCMenu *)[menuArray objectAtIndex:i];
        menuItem.enabled = NO;
    }
    for (int i = 0; i<[solutionArray count];i++){
        CCMenu *menuItem = (CCMenu *)[solutionArray objectAtIndex:i];
        menuItem.enabled = NO;
    }
    
    back.enabled = NO;
    // menu.enabled = NO;
}

-(void)clearTutorialBaseView{
    [UIView animateWithDuration:1.0 delay:0.7 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [tutorialView removeFromSuperview];
                         [self enableTouch];
                     }];
    
    
}

-(void)showMainView{
    [self createBackground];
    [self createMenuButtons];
    
    CCMenuItemImage    *backitem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(back:)];
    back  = [CCMenu menuWithItems:backitem, nil];
    back.position = ccp(50*DevicewidthRatio,40*DeviceheightRatio);
    [self addChild:back];
}

-(void)createBackground{
    backgroundBg = [CCSprite spriteWithFile:@"brainteaserbg.png"];
    backgroundBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:backgroundBg];
}

-(void)createMenuButtons{
    float menuYpos = 98.0f*DeviceheightRatio;
    menuArray = [[NSMutableArray alloc]init];
    solutionArray = [[NSMutableArray alloc]init];
    for (int i= 1 ;i<=8;i++){
        NSString *btnImageName = [NSString stringWithFormat:@"brainteasermenubtn_%d.png",i];
        CCMenuItemImage *menuBtn = [CCMenuItemImage itemWithNormalImage:btnImageName selectedImage:btnImageName target:self selector:@selector(menuBtnPressed:)];
        menuBtn.tag = i;
        CCMenu *menu  = [CCMenu menuWithItems:menuBtn, nil];
        menu.position = ccp(127*DevicewidthRatio,menuYpos);
        [menuArray addObject:menu];
        [backgroundBg addChild:menu];
        if(i>=3){
            CCMenuItemImage *solution = [CCMenuItemImage itemWithNormalImage:@"Solution.png" selectedImage:@"Solution.png" target:self selector:@selector(checkSolution:)];
            solution.tag = i;
            CCMenu *solutionMenu = [CCMenu menuWithItems:solution, nil];
            solutionMenu.position = ccp(277*DevicewidthRatio,menuYpos);
            [solutionArray addObject:solutionMenu];
            [backgroundBg addChild:solutionMenu];
            //            CCMenuItemImage *spriteWithFile = [CCSprite spriteWithFile:@"Solution.png"];
            //            spriteWithFile.position  = ccp(290,menuYpos);
            //            [self addChild:spriteWithFile];
        }
        menuYpos += 50.0f*DeviceheightRatio;
    }
}

-(void)showSolution:(int)num{
    BTSolution *solutionscene;
    switch (num) {
        case 3:
            solutionscene =  [BTSolution nodeWithGameLevel:3];
            break;
            //                break;
        case 4:
            solutionscene =  [BTSolution nodeWithGameLevel:4];
            break;
        case 5:
            solutionscene =  [BTSolution nodeWithGameLevel:5];
            
            break;
        case 6:
            solutionscene =  [BTSolution nodeWithGameLevel:6];
            break;
        case 7:
            solutionscene =  [BTSolution nodeWithGameLevel:7];
            break;
        case 8:
            solutionscene =  [BTSolution nodeWithGameLevel:8];
            break;
        default:
            break;
    }
    
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[solutionscene scene]]];
    //[self addChild:brainTeaserProblemScene];
    
}


-(void)back:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainArenaMenu scene]]];
    //    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[BrainArenaMenu scene]]];
}

-(void)checkSolution:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click3.mp3"];
    
    CCMenuItemImage *solutionButton = (CCMenuItemImage*)sender;
    Myquslist *qus = [[Myquslist alloc]init];
    int isLocked = [qus isBought:solutionButton.tag];
    if(isLocked==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"It will cost you 50 gold to unlock the solution" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = solutionButton.tag;
        [alert show];
    }
    else {
        [self showSolution:solutionButton.tag];
    }
}
-(void)menuBtnPressed:(id)sender{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click3.mp3"];
    
    BrainTeaserProblemScene *brainTeaserProblemScene;
    CCMenuItemImage *brainTeaserBtn = (CCMenuItemImage*)sender;
    
    switch (brainTeaserBtn.tag) {
        case 1:
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:0];
            break;
        case 2:
            //pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight) ProblemNumner:1];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:1];
            
            break;
        case 3:
            //   pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight)ProblemNumner:2];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:2];
            
            break;
        case 4:
            // pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight) ProblemNumner:3];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:3];
            break;
        case 5:
            // pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight) ProblemNumner:4];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:4];
            
            break;
        case 6:
            //   pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight)ProblemNumner:5];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:5];
            
            break;
        case 7:
            //pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight) ProblemNumner:6];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:6];
            
            break;
        case 8:
            //pop = [[BrainTeaserPopUp alloc]initWithFrame:CGRectMake(DeviceWidth/10.666, DeviceHeight/10.6667, DeviceWidth, DeviceHeight)ProblemNumner:7];
            brainTeaserProblemScene =  [BrainTeaserProblemScene nodeWithGameLevel:7];
            
            break;
        default:
            break;
    }
    
    // [[[CCDirector sharedDirector]openGLView]addSubview:pop];
    //    NSString *probImage = [NSString stringWithFormat:@"BT%d.png",brainTeaserBtn.tag];
    //    CCSprite *probSprite = [CCSprite  spriteWithFile:probImage];
    //    probSprite.position = ccp(160,240);
    //    [self addChild:probSprite];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[brainTeaserProblemScene scene]]];
    //    [backgroundBg removeAllChildrenWithCleanup:YES];
    //    [self addChild:brainTeaserProblemScene];
    
}

//- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
//    CGPoint location = [touch locationInView: [touch view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    //NSLog(@"Toucx=%f touchy=%f",location.x,location.y);
//    //  if([self checkCircle:location])
//    //     NSLog(@"Toucx=%f touchy=%f",location.x,location.y);
//
//    return YES;
//    // returning YES means we want to receive the moved/ended/cancelled info. if we return NO, it'll just ignore those events
//}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        GameData *gameData = [GameData GameDataManager];
        float gold = [gameData returngold];
        if(gold-50<0){
            UIAlertView *noGoldAlert = [[UIAlertView alloc]initWithTitle:@"Low gold" message:@"You do not have enough gold to buy this solution" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [noGoldAlert show];
            [noGoldAlert release];
        }
        else{
            [gameData setgold:gold-50];
            Myquslist *updateFlag = [[Myquslist alloc]init];
            [updateFlag  upDateFlagTable:alertView.tag];
            [self showSolution:alertView.tag];
        }
    }
}

- (void)revmobAdDidReceive{
    CCArray *layers =[[CCDirector sharedDirector]runningScene].children;
    for(int i = 0 ;i < [layers count];i++){
        CCLayer *layer = [layers objectAtIndex:i];
        if(layer.tag == BrainTeaserSceneTag){
            adDidRecieve = YES;
            ad.frame = CGRectMake(DeviceWidth/2-RevMobBannerWidth/2, DeviceHeight-50, RevMobBannerWidth, 50);
          
                [[[CCDirector sharedDirector]view ]addSubview:ad];
                break;
        }
    }
    //}
//    if(!adDidRecieve){
//        [ad release];
//    }
}
- (void)revmobAdDidFailWithError:(NSError *)error{
       // [ad release];
    [[Chartboost sharedChartboost] showInterstitial];
}





@end
