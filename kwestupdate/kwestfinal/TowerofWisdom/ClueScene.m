//
//  ClueScene.m
//  kwest
//
//  Created by Anindya on 5/9/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "ClueScene.h"
#import "QuestScene.h"
#import "Clues.h"
#import "ClueFlag.h"
#import "GameData.h"
#import <Chartboost/Chartboost.h>
#define PriceDialogTag 1

@implementation ClueScene

+(CCScene*)scene{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ClueScene *layer = [ClueScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self=[super init]){
        gameData = [GameData GameDataManager];
        if(![gameData returnpremium]){
          //  int probAd=arc4random()%100;
        if ([[GameData GameDataManager] returnknop]>30)
            [Chartboost showInterstitial:CBLocationQuests];
        }
        float yPos = 440*DeviceheightRatio;
        clueBg = [CCSprite spriteWithFile:@"questBg.png"];
        clueBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
        [self addChild:clueBg];
        for(int i = 1; i<=7 ; i++){
            NSString *clueBtn = [NSString stringWithFormat:@"clues%d.png",i];
            CCMenuItemImage *clueItem = [CCMenuItemImage itemWithNormalImage:clueBtn selectedImage:clueBtn target:self selector:@selector(goToClue:)];
            clueItem.tag = i;
            CCMenu *menu = [CCMenu menuWithItems:clueItem, nil];
            menu.position = ccp(160*DevicewidthRatio,yPos);
            [clueBg addChild:menu];
            yPos = yPos - 50*DeviceheightRatio;
        }
        CCMenuItemImage *backItem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(backToQuest)];
        CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
        backMenu.position = ccp(160*DevicewidthRatio,35*DeviceheightRatio);
        [clueBg addChild:backMenu];
    }
    return self;
}
-(void)onEnter{
    [super onEnter];
 }

-(void)onExit{
    [super onExit];
    //[[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

-(void)backToQuest{
[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[QuestScene scene]]];
}

-(void)goToClue:(id)sender{
    
    CCMenuItemImage *btn = (CCMenuItemImage*)sender;
    clueNum = btn.tag;
    ClueFlag *flag = [ClueFlag ClueFlags];
    if([flag checkClueFlag:btn.tag]==0){
         price = [flag getPrice:btn.tag];
        NSString *priceDialog = [NSString stringWithFormat:@"You have to pay %d gold for this clue",price];
        UIAlertView *priceAlert = [[UIAlertView alloc]initWithTitle:priceDialog message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Pay", nil];
        priceAlert.tag = PriceDialogTag;
        [priceAlert show];
        [priceAlert release];
    }
    else{
    Clues * cl = [[Clues alloc]initWithClueNumber:btn.tag];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[cl scene]]];
    }
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == PriceDialogTag){
        if([buttonTitle isEqualToString:@"Pay"]){
            if([gameData returngold]-price<0){
                UIAlertView *notEnoughGoldAlert = [[UIAlertView alloc]initWithTitle:@"You do not have enough gold" message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [notEnoughGoldAlert  show];
                [notEnoughGoldAlert release];
            }
            else{
                [gameData setgold:[gameData returngold]-price];
                 ClueFlag *flag = [ClueFlag ClueFlags];
                [flag updateClueFlag:clueNum];
                Clues * cl = [[Clues alloc]initWithClueNumber:clueNum];
                [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[cl scene]]];
            }
        }
    }
}
@end
