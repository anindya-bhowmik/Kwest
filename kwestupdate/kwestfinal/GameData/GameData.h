//
//  GameData.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Myquslist.h"

@interface GameData : NSObject{
    NSMutableArray *qus;
    NSMutableArray *quest;
    NSInteger sprintqusnum;
    NSInteger endurancequsnum;
    NSInteger knowledgepath4counter;
    long long int memoryn;
    long long int previousmemoryn;
    NSInteger memorycounter;
    NSInteger sprintquscounter;
    NSInteger memoryquscounter;
    NSInteger endurancequscounter;
    float sprintTimer;
    NSMutableArray *playerData;
    NSString *date;
       NSInteger previouscounter;
    NSInteger playerenergy;
    NSUserDefaults *prefs;
    NSUserDefaults *knops;
    NSUserDefaults *golds;
    NSUserDefaults *energys;
    NSUserDefaults *karmas;
    NSUserDefaults *levels;
    NSUserDefaults *koes;
    NSUserDefaults *kows;
    NSUserDefaults *koss;
    NSUserDefaults *prms;
    NSUserDefaults *dts;
 
    NSUserDefaults *endurancebest;
    NSUserDefaults *enduranceavg;
    NSUserDefaults *endurancelast;
    NSUserDefaults *sprintbest;
    NSUserDefaults *sprintavg;
    NSUserDefaults *sprintlast;
    NSUserDefaults *memorybest;
    NSUserDefaults *memoryavg;
    NSUserDefaults *memorylast;
    NSUserDefaults *questCompleted;
    NSUserDefaults *sprinttrynum;
    NSUserDefaults *endurancetrynum;
    NSUserDefaults *memorytrynum;
    NSUserDefaults *overalltry;
    NSUserDefaults *overallbest;
    NSUserDefaults *overallavg;
    NSUserDefaults *overalllast;
  /*  NSInteger endurancetrynum;
    NSInteger sprinttrynum;
    NSInteger memorytrynum;*/
    Myquslist *quslist;
    
    int sciencenum;
    int logicnum;
    int humanitiesnum;
    int deepernum;
}
@property (nonatomic,readwrite)float sprintTimer;
@property (nonatomic,retain)NSMutableArray *quest;
@property (nonatomic,retain)NSMutableArray *qus;
@property (nonatomic,retain)NSMutableArray *playerData;
@property(nonatomic,readwrite)NSInteger knowledgepath4counter;
@property(nonatomic,readwrite)NSInteger sprintqusnum;
@property(nonatomic,readwrite)NSInteger endurancequsnum;
@property(nonatomic,readwrite)long long int memoryn;
@property(nonatomic,readwrite)NSInteger memorycounter;
@property(nonatomic,readwrite)NSInteger endurancequscounter;
@property(nonatomic,readwrite)NSInteger sprintquscounter;
@property(nonatomic,readwrite)NSInteger memoryquscounter;
@property(nonatomic,readwrite)NSInteger playerenergy;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,readwrite)long long int previousmemoryn;
@property (nonatomic,readwrite)NSInteger previouscounter;

@property(nonatomic,readwrite)int sciencenum;
@property(nonatomic,readwrite)int logicnum;
@property(nonatomic,readwrite)int humanitiesnum;
@property(nonatomic,readwrite)int deepernum;

@property(nonatomic,readwrite)int testcounter;

@property (nonatomic,assign)BOOL isHelpOn;

@property (nonatomic,assign)BOOL isTutorialShown;

+(id) GameDataManager;
-(void)readquestfromdb;
-(void)readQusfromdb;
-(void)readPlayerDatafromdb;
-(NSInteger)getQusindex:(NSInteger)difficulty;
-(NSString *)getQus:(NSInteger)index;
-(NSString *)getOpt1:(NSInteger)index;
-(NSString *)getOpt2:(NSInteger)index;
-(NSString *)getOpt3:(NSInteger)index;
-(NSString *)getOpt4:(NSInteger)index;
-(NSInteger)getDifficulty:(NSInteger)index;
-(int)getRightTag:(NSInteger)index;
-(NSString *)getLeader:(NSInteger)index;
-(NSString *)getSubtype:(NSInteger)index;
-(NSInteger)getType:(NSInteger)type;
-(NSInteger)getID:(NSInteger)index;
-(NSString*)playerName;
-(void)setknop:(float)f;
-(float)returnknop;
-(void)setgold:(float)f;
-(float)returngold;
-(void)setEnergy:(NSInteger)i;
-(NSInteger)returnenergy;
-(void)setKarma:(NSInteger)i;
-(NSInteger)returnkarma;
-(void)setLevel:(NSInteger)i;
-(NSInteger)returnlevel;
-(void)setkeyofenergy:(BOOL)b;
-(BOOL)returnkeyofenergy;
-(void)setkeyofwisdom:(BOOL)b;
-(BOOL)returnkeyofwisdom;
-(void)setkeyofstrength:(BOOL)b;
-(BOOL)returnkeyofstrength;
-(void)setpremium:(BOOL)b;
-(BOOL)returnpremium;
-(void)setEnergydate:(NSString*)str;
-(void)setQuestCompleted:(float)n;
-(float)getQuestCompleted;

-(NSInteger)getendurancebest;
-(void)setEndurancebest:(NSInteger)score;
-(float)getEnduranceavg;
-(void)setEnduranceavg:(float)score;
-(void)setEnduranceLast:(NSInteger)score;
-(NSInteger)getEnduranceLast;

-(float)getSprintBest;
-(void)setSprintBest:(float)score;
-(float)getSprinteavg;
-(void)setSprintavg:(float)score;
-(void)setSprintLast:(float)score;
-(float)getSprintlast;

-(NSInteger)getMemorybest;
-(void)setMemorybest:(NSInteger)score;
-(float)getMemoryavg;
-(void)setMemoryavg:(float)score;
-(void)setMemoryLast:(NSInteger)score;
-(NSInteger)getMemoryLast;

-(void)setsprinttry:(NSInteger)n;
-(NSInteger)getsprinttry;
-(void)setendurancetry:(NSInteger)n;
-(NSInteger)getendurancetry;
-(void)setmemorytry:(NSInteger)n;
-(NSInteger)getmemorytry;

-(void)setoveralltry:(int)num;
-(NSInteger)getoveralltry;
-(void)setoverallbest:(float)num;
-(float)getoverallbest;
-(void)setoverallavg:(float)num;
-(float)getoverallavg;
-(void)setoveralllast:(float)num;
-(float)getoveralllast;
-(void)clearData;
-(NSString *)getEndergydate;

-(void)setUScore:(float)value;
-(float)getUScore;
-(void)setToken:(NSString *)string;
-(NSString*)getToken;

-(int)getEasterFlag;
-(void)setEasterFlag:(int)flag;
-(BOOL)getFirstTimeShared;
-(void)setFirstTimeShared:(BOOL)shared;
-(void)setStartDate:(NSString*)startDate;
-(NSString*)getStartDate;
-(void)setWisdomDate:(NSString*)achivedDate;
-(NSString*)getWisdomDate;
-(int)numberOfDaysPlayed;
-(double)growthRate;
-(int)daysToWisdom;
@end
