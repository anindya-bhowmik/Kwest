//
//  BrainArenaResult.m
//  kwest
//
//  Created by Tashnuba Jabbar on 14/11/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "BrainArenaResult.h"


@implementation BrainArenaResult
-(id)init{
    if(self = [super init]){
        gamedata = [GameData GameDataManager];
        CCSprite *bg = [CCSprite spriteWithFile:@"scorebg.png"];
        
        bg.position = ccp(160,240);
        [self addChild:bg];
        CCLabelTTF *knoplbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"knop=%.f",[gamedata returnknop]] fontName:@"Times" fontSize:22];
        knoplbl.position = ccp(83,150);
        knoplbl.color = ccBLUE;
        [bg addChild:knoplbl];
        CCLabelTTF *goldlbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"gold=%.f",[gamedata returngold]] fontName:@"Times" fontSize:22];
        goldlbl.position = ccp(83,100);
        goldlbl.color = ccBLUE;
        [bg addChild:goldlbl];
      
        id fadeIn = [CCFadeIn actionWithDuration:0.1];
		id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
		id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
		id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
		id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
        [bg runAction:pulse];
    }
    return self;
}

@end
