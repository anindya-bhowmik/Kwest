//
//  Score.h
//  kwest
//
//  Created by Tashnuba Jabbar on 15/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GCHelper.h"

@interface Score : NSObject{
    NSString *currentLeaderBoard;

}
-(NSString *)KnowledgePathBonusCalculation;
-(void)KnowledgepathScore:(int)qustype :(BOOL)isCorrect;

-(void)MemoryFinish:(NSInteger)digit LevelCompleted:(int)levelCompleted;
-(void)EnduranceFinsh:(NSInteger)qusnum;
-(void)SprintFinish:(float)speed;

-(void)setLevel:(int)k;
-(void)lstatOverall;
-(void)kstatOverall;
-(void)karmaCalculation;
-(float)calculateUScore;
-(void)sendAchievements:(NSString*)achivementType;
@end
