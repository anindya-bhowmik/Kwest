//
//  Myquslist.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface Myquslist : NSObject{
    sqlite3 *data;
}

-(NSMutableArray *)getQusList;
-(NSMutableArray *)getQuestList;
-(NSMutableArray*)getClueList;
-(void)updateQuestSolved:(NSInteger)solvedVal :(NSInteger)q_id;
-(void)updateQuestHint:(BOOL)isUsed :(NSInteger)q_id;
-(NSMutableArray*)getPlayerInfo;
-(int)getQusCount:(int)type;
-(void)updateClues:(int)locked :(NSInteger)clue_id;
-(void)copyToFileManager;

-(int)isBought:(int)idPrimary;
-(void)upDateFlagTable:(int)idPrimary;
//-(BOOL)checkClueFlag:(int)clueNum;
-(int)getKnopThreshold:(int)level;
-(BOOL)getMissionFlag:(int)primaryId;
-(void)upDatemissionFlagTable:(int)idPrimary;
-(int)getQuestSolvedNumber;


-(void)resetPlayerData;
-(void)resetClue;
-(void)resetFlag;
-(void)resetMissionFlag;
-(void)resetLStat;
-(void)resetKStat;
-(void)resetQuest;
-(NSMutableArray *)getKnopThresholds;
-(NSString *)getEraName:(int)level;

-(NSMutableArray*)getUnsendAchivements;
-(void)updateAchivementSendStatus:(NSString*)idPrimary;
-(void)updateAchivementAchiveStatus:(NSString*)idPrimary;
@end
