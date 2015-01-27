//
//  EnergyCalculation.h
//  kwest
//
//  Created by Tashnuba Jabbar on 21/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameData.h"

@interface EnergyCalculation : NSObject{
    GameData *gamedata;
}

-(NSInteger)calculateKnowledgePathEnergy;
-(NSInteger)calculateIntelligenceQuestionEnergy;

@end
