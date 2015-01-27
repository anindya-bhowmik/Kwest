//
//  EnergyCalculation.m
//  kwest
//
//  Created by Tashnuba Jabbar on 21/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import "EnergyCalculation.h"

@implementation EnergyCalculation
-(id)init{
    if(self =[super init]){
        gamedata = [GameData GameDataManager];
    }
    return self;
}

-(void)dealloc{
   // [gamedata release];
    [super dealloc];
}

-(NSInteger)calculateKnowledgePathEnergy{
    NSInteger energy = [gamedata returnenergy];
    NSInteger w = [gamedata returnkeyofwisdom];
    NSInteger e = [gamedata returnkeyofenergy];
    energy=energy-3+w+e;
    NSLog(@"energy=%d",energy);
    return energy;

}
-(NSInteger)calculateIntelligenceQuestionEnergy{
    NSInteger energy = [gamedata returnenergy];
    NSInteger s = [gamedata returnkeyofwisdom];
    NSInteger e = [gamedata returnkeyofenergy];
    energy =energy-3+s+e;
    NSLog(@"energy=%d",energy);
    return energy;

}
@end
