
//
//  Score.m
//  kwest
//
//  Created by Tashnuba Jabbar on 15/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import "Score.h"
#import "GameData.h"
#import "PlayerStatistics.h"
#import "Myquslist.h"
#import "Utility.h"
#import "AppDelegate.h"
#import "GameKitHelper.h"
GameData *gamedata;
PlayerStatistics *stat;
@implementation Score

-(id)init{
    if(self = [super init]){
        gamedata = [GameData GameDataManager];
        stat = [PlayerStatistics StatManager];
    }
    return self;
}
///////////////////////////////////// KARMA CALCUALTION \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            
-(void)karmaCalculation{
    [self lstatOverall];
    [self kstatOverall];
    float k_totalrate = [stat getTotalRates];
    float l_totalavg = [gamedata getoverallavg];
    int level = [gamedata returnlevel];
    float noofquestcompleted = [gamedata getQuestCompleted] ;
    
    //int karma = 5+(((k_totalrate>=75)+(l_totalavg>=75)+(level>=5)+((level+1)/2.0f<=noofquestcompleted)+((level+1)/2.0f<noofquestcompleted))-((k_totalrate<50)+(l_totalavg<50)+((level-3)/2.0f>=noofquestcompleted)+((level-3)/2.0f>noofquestcompleted)));
    int ratingFlag = (k_totalrate>=75)+(l_totalavg>=75) - (k_totalrate<50) - (l_totalavg<50);
    int questFlag = ((level+1)/2.0f<=noofquestcompleted)+((level+1)/2.0f<noofquestcompleted) - (((level-3)/2.0f>=noofquestcompleted)+((level-3)/2.0f>noofquestcompleted)+((level-4)/2.0f>noofquestcompleted));
    //int karma = 5 +((k_totalrate>=75)+(l_totalavg>=75)+((level+1)/2.0f<=noofquestcompleted)+((level+1)/2.0f<noofquestcompleted)) -((k_totalrate<50)+(l_totalavg<50)+((level-3)/2.0f>=noofquestcompleted)+((level-3)/2.0f>noofquestcompleted)+((level-4)/2.0f>noofquestcompleted));
    NSLog(@"rating flag: %d",ratingFlag);
    NSLog(@"quest flag: %d",questFlag);

    int karma = 5 + ratingFlag + questFlag;
    //int karma = 7;
    [gamedata setKarma:karma];
    //[self calculateUScore];

}

-(float)calculateUScore{
    
    float uscore;
    
    
    
    
    
    // Putting an upper limit to Gold's contribution
    
    int g;
    
    g=([gamedata returngold]);
    
    if ([gamedata returngold]>=5000)
        
        g=5000;
    
    
    
    uscore = 0.3f*(g)+0.65f*[gamedata returnknop]+[gamedata getQuestCompleted]*80+(([gamedata getoverallavg]-50)*20*pow(2,(-30/([gamedata getoveralltry]+1))))+(([stat getTotalRates]-50)*20*pow(2, (-65/([stat getTotalTryRecord]+1))))+([gamedata returnkarma]-5)*80+[gamedata returnlevel]*50;
    
    
    
    [self submitScoreToGameCenter:uscore*10 :@"kwestuscore"];
    
    [gamedata setUScore:uscore];
    
    if(uscore>1500){
        
        Myquslist    *dbHandler = [[Myquslist alloc]init];
        
        [dbHandler updateAchivementAchiveStatus:BalancedPower];
        
        [self sendAchievements:BalancedPower];
        
    }
    
    return uscore;
    
}


/////////////////////////////////// LEVEL CALCULATION \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-(void)setLevel:(int)k{
    int level = 0;
    Myquslist *dbHandler = [[Myquslist alloc]init];
    NSMutableArray *knopThresolds = [dbHandler getKnopThresholds];
    for(int i = 0;i<[knopThresolds count];i++){
        NSNumber *number = [knopThresolds objectAtIndex:i];
        int knopThreshold =  [number intValue];
        if(k>= knopThreshold){
            level ++;
        }
        else
            break;
    }
//    if(k>=5 && k<100)
//        level=1;
//    else if(k>=100 && k<220)
//        level=2;
//    else if(k>=220 && k<360)
//        level=3;
//    else if(k>=360 && k<600)
//        level=4;
//    else if(k>=600 && k<900)
//        level=5;
//    else if(k>=900 && k<1200)
//        level=6;
//    else if(k>=1200 &&k<1600)
//        level=7;
//    else if(k>=1600 && k<2000)
//        level=8;
//    else if(k>=2000 && k<2500)
//        level=9;
//    else if(k>=2500)
//        level=10;
    [gamedata setLevel:level];
    if(level<10){
        if(level>=1){
            Myquslist *dbHandler = [[Myquslist alloc]init];
            [dbHandler updateAchivementAchiveStatus:TowerBuilder];
            [self sendAchievements:TowerBuilder];
             NSLog(@"Reporting TowerBuilder (setLevel) with %g ",([[GameData GameDataManager] returnlevel]*25));

        }
    }
    else if(level == 10){
        if([[gamedata getWisdomDate] length]<=0){
            NSDate *wisdomDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            NSString *dateString = [dateFormatter stringFromDate:wisdomDate];
            [gamedata setWisdomDate:dateString];
            if([gamedata daysToWisdom]<=10){
                [self sendAchievements:@"fastwisdom"];
            }
        }
        Myquslist *dbHandler = [[Myquslist alloc]init];
        [dbHandler updateAchivementAchiveStatus:Saga];
        [self sendAchievements:Saga];
    }
}

/////////////////////////////////////// K_STATISTICSTABLE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-(void)kstatOverall{
    int totaltry = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
    int totalcorrect = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];

    [stat setTotalTryRecord:totaltry];
    [stat setTotalcorrectRecord:totalcorrect];
    float rate=0.0f;
    if(totaltry>0)
        rate = ((float)totalcorrect/(float)totaltry)*100;
   // [stat setTotalTryRecord:totalcorrect];

    [stat setTotalRate:rate];
   // if(totalcorrect>=50){
        Myquslist *dbHandler = [[Myquslist alloc]init];
        [dbHandler updateAchivementAchiveStatus:PathofLearning];
        [self sendAchievements:PathofLearning];
    //}
    /*int overalltry = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
     int overallcorrect = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getTotalCorrectRecord];
     [stat setOverallTryRecord:overalltry];
     [stat setOverallcorrectRecord:overallcorrect];
     float rate = (float)(overallcorrect/overalltry);
     rate = rate*100;
     
     [stat setOverallTryRecord:rate];*/
}

//////////////////////////////////// L_STATISTICSTABLE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-(void)lstatOverall{
    float sp_best = [gamedata getSprintBest];
    float endurance_best = [gamedata getendurancebest];
    float memory_best = [gamedata getMemorybest];
    float sp_avg = [gamedata getSprinteavg];
    float endurance_avg = [gamedata getEnduranceavg];
    float mem_avg = [gamedata getMemoryavg];
    float sp_last = [gamedata getSprintlast];
    float endurance_last = [gamedata getEnduranceLast];
    float mem_last = [gamedata getMemoryLast];
    int sptry = [gamedata getsprinttry];
    int endtry = [gamedata getendurancetry];
    int memtry = [gamedata getmemorytry];
    
    NSInteger overalltry = sptry+endtry+memtry;
    float overall_best = 100*((endurance_best/30.0f)+(1-(sp_best-20)/40.0f)+(memory_best/8))/3;
    float overall_avg =  100*((endurance_avg/30.0f)+(1-(sp_avg-20)/40.0f)+(mem_avg/8))/3;
    float overall_last =  100*((endurance_last/30.0f)+(1-(sp_last-20)/40.0f)+(mem_last/8))/3;
    NSLog(@"overallavg =%.2f",overall_avg);
    [gamedata setoveralltry:overalltry];
    [gamedata setoverallbest:overall_best];
    [gamedata setoverallavg:overall_avg];
    [gamedata setoveralllast:overall_last];
  //  if(overalltry>=15){
        Myquslist *dbHandler = [[Myquslist alloc]init];
        [dbHandler updateAchivementAchiveStatus:BrainPower];
        [self sendAchievements:BrainPower];
  //  }
}

///////////////////////////////// SPRINT SCORE CALCULATION \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


-(void)sprintscore:(float)time{
    bool kos = [gamedata returnkeyofstrength];
    int g=0;
    int k=0;
    float knop;
    float gold;
    knop = [gamedata returnknop];
    gold = [gamedata returngold];
    kos = [gamedata returnkeyofstrength];
    NSLog(@"goldbefore=%.f",gold);
    NSLog(@"knopbefore=%.f",knop);
    if(time<=25){
        g=8;
        k=3;
    }
    else if(time<=30){
        g=4;
        k=2;
    }
    else if(time<=35){
        g=3;
        k=1;
    }
    else if(time<=40){
        g=2;
        k=1;
    }
    else if(time<=50){
        g=1;
        k=0;
    }
    else{
        g=0;
        k=0;
    }
    if(g!=0){
        gold+=g+2*kos;
    }
    if(k!=0){
        knop+=k+kos;
    }
    
    [gamedata setgold:gold];
    [gamedata setknop:knop];
    [self setLevel:knop];

}
-(void)SetSprintSpeed:(float)speed {
    int trynum = [gamedata getsprinttry];
    float best = [gamedata getSprintBest];
    float avg = [gamedata getSprinteavg];
    if (trynum>6)
        avg=(0.85*avg) + (0.15*speed);
    else
        avg = (avg*(trynum-1)+speed)/trynum;
    if(best==0.0f)
        best = speed;
    else if(best>0.0f){
        if(speed<best)
            best = speed;
    }
    [gamedata setSprintBest:best];
    [gamedata setSprintavg:avg];
    [gamedata setSprintLast:speed];
    [self submitScoreToGameCenter:speed*10 :@"kwestspeed"];
}


-(void)SprintFinish:(float)speed{
    [self sprintscore:speed];
    [self SetSprintSpeed:speed];
  //  [self lstatOverall];
    [self karmaCalculation];
    
}

///////////////////////////////////////////// MEMORY SCORE CALCULATION\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-(void)memoryscore:(NSInteger)digit{
    float g=0.0f;
    float k=0.0f;
    float knop = [gamedata returnknop];
    float gold = [gamedata returngold];
    BOOL kos = [gamedata returnkeyofstrength];
    if(gamedata.previousmemoryn<6){
        g=0;
        k=0;
    }
    else if(gamedata.previousmemoryn==6){
        g=1;
        k=0;
    }
    else if(gamedata.previousmemoryn==7){
        g=(1+(1-gamedata.previouscounter));
        k=0;
    }
    else if(gamedata.previousmemoryn==8){
        g=(2+(1-gamedata.previouscounter));
        k=1;
    }
    else if(gamedata.previousmemoryn>=9){
        g=(3+(1-gamedata.previouscounter)+(gamedata.previousmemoryn-8));
        k=2;
    }
    if(g!=0){
        gold+= g+2*kos;
    }
    if(k!=0){
        knop+= k+kos;
    }
    [gamedata setknop:knop];
    [gamedata setgold:gold];
    [self setLevel:knop];
}

-(void)SetMemoryDigit:(NSInteger)digit LevelCompleted:(int)levelCompleted {
   // [memorytrynum setInteger:trynum forKey:@"memorytrynum"]
    NSInteger trynum = [gamedata getmemorytry];
    NSInteger best = [gamedata getMemorybest];
    float avg = [gamedata getMemoryavg];
    if (trynum>6)
        avg=(0.85*avg) + (0.15*digit);
    else
        avg = (avg*(trynum-1)+digit)/trynum;

    [gamedata setMemoryavg:avg];
    [gamedata setMemoryLast:digit];
   if(digit>best)
       [gamedata setMemorybest:digit];
    [self submitScoreToGameCenter:levelCompleted :@"kwestmemory"];
}

-(void)MemoryFinish:(NSInteger)digit LevelCompleted:(int)levelCompleted{
    [self memoryscore:digit];
//    if(levelCompleted>0){
//        levelCompleted --;
//    }
    [self SetMemoryDigit:digit LevelCompleted:levelCompleted-1];
  //  [self lstatOverall];
    [self karmaCalculation];

}


///////////////////////////////// ENDURANCE SCORE CALCULATION \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


-(void)endurancescore:(NSInteger)qusnum{
    bool kos = [gamedata returnkeyofstrength];
    int g;
    int k;
    float knop;
    float gold;
    knop = [gamedata returnknop];
    gold = [gamedata returngold];

    kos = [gamedata returnkeyofstrength];
    if(qusnum>=25){
        g=8;
        k=3;
    }
    else if(qusnum>=21){
        g=4;
        k=2;
    }
    else if(qusnum>=18){
        g = 3;
        k = 1;
    }
    else if(qusnum>=15){
        g=2;
        k=1;
    }
    else if(qusnum>=10){
        g=1;
        k=0;
    }
    else{
        g=0;
        k=0;
    }
    if(g!=0){
        gold += g+2*kos;
    }
    if(k!=0){
        knop+= k+kos;
    }
    
    [gamedata setgold:gold];
    [gamedata setknop:knop];
    [self setLevel:knop];

}
-(void)setEndurancequsno:(NSInteger)qusnum{
    
   // [endurancetrynum setInteger:trynum forKey:@"endurancetrynum"];
    NSInteger trynum = [gamedata getendurancetry];
    NSInteger best = [gamedata getendurancebest];
    float avg = [gamedata getEnduranceavg];
   if (trynum>6)
       avg=(0.85*avg) + (0.15*qusnum);
   else
       avg = (avg*(trynum-1)+qusnum)/trynum;
    
    [gamedata setEnduranceavg:avg];
    [gamedata setEnduranceLast:qusnum];
    if(qusnum>best)
        [gamedata setEndurancebest:qusnum];
    [self submitScoreToGameCenter:qusnum :@"kwestfocus"];
}
-(void)EnduranceFinsh:(NSInteger)qusnum {
    [self endurancescore:qusnum-1];
    [self setEndurancequsno:qusnum-1 ];
 //   [self lstatOverall];
    [self karmaCalculation];
}

///////////////////////////////// KNOWLEDGE PATH SCORE CALCULATION \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


-(NSString *)KnowledgePathBonusCalculation{
    NSString *giftstr;
    bool getGift = false;
    float k=0;
    float g=0; 
    int e=0;
    float knop = [gamedata returnknop];
    int karma = [gamedata returnkarma];
    float gold = [gamedata returngold];
    int energy = [gamedata returnenergy];
    k=2;
    int p_extra_gift = arc4random()%100+1;
    if(p_extra_gift<20+3*karma){
        getGift = true;
        int p_type = arc4random()%100+1;
        if(p_type<33){
             k +=(1+ceilf(karma/10));
        }
        else if(p_type<66){
             g=(1+ceilf(karma/10));
        }
        else{
             e=(2+ceilf(karma/10));
        }
        giftstr = [NSString stringWithFormat:@"%.2f knop %.2f gold %d energy",k,g,e];
        knop=knop+k;
        gold = gold+g;
        energy = energy+e;
        [gamedata setknop:knop];
        [[[Score alloc]init] setLevel:[[GameData GameDataManager] returnknop]];
        [gamedata setgold:gold];
        [gamedata setEnergy:energy];
    }
    return giftstr;
}

-(void)setQuestionRecord:(int)qustype :(BOOL)isCorrect{
    int sciencetryrecord = [stat getScienceTryRecord];
    int sciencecorrectrecord = [stat getScienceCorrectRecord];
    
    int logictryrecord  = [stat getLogicTryRecord];
    int logiccorrectrecord = [stat getLogicCorrectRecord];
    
    int humanitiestryrecord = [stat getHumanitiesTryRecord];
    int humanitiescorrectrecord = [stat getHumanitiesCorrectRecord];
    
    int deepertryrecord = [stat getDeeperTryRecord];
    int deepercorrectrecord = [stat getDeeperCorrectRecord];
   
    if(qustype==1 ){
        if(isCorrect)
            sciencecorrectrecord++;
        [stat setSciencecorrectRecord:sciencecorrectrecord];
        float rate =((float)sciencecorrectrecord/(float)sciencetryrecord)*100;
        [stat setSciencePercentRecord:rate];
    }
    else  if(qustype==2){
        if(isCorrect)
            logiccorrectrecord++;
        float rate = ((float)logiccorrectrecord/(float)logictryrecord)*100;
        [stat setLogiccorrectRecord:logiccorrectrecord];
        [stat setLogicPercentRecord:rate];

    }
    else if(qustype==3){
        if(isCorrect)
            humanitiescorrectrecord++;
        float rate = ((float)humanitiescorrectrecord/(float)humanitiestryrecord)*100;
        [stat setHumanitiescorrectRecord:humanitiescorrectrecord];
        [stat setHumanitiesPercentRecord:rate];
    }
    
   else if(qustype==4){
       if(isCorrect)
            deepercorrectrecord++;
        float rate = ((float)deepercorrectrecord/(float)deepertryrecord)*100;
        [stat setDeepercorrectRecord:deepercorrectrecord];
        [stat setDeeperPercentRecord:rate];
        }
}


-(void)KnowledgepathScore:(int)qustype :(BOOL)isCorrect{
    [self setQuestionRecord:qustype :isCorrect];
    float knop = [gamedata returnknop];
    float gold = [gamedata returngold];
    BOOL kew = [gamedata returnkeyofwisdom];
    if(isCorrect){
        knop+=3+(2*kew);
        gold+=2+kew;
    
    [gamedata setknop:knop];
    [gamedata setgold:gold];
    }
    [self setLevel:knop];
 //   [self kstatOverall];
    [self karmaCalculation];
}

-(void)submitScoreToGameCenter:(float)value :(NSString*)leaderboardName{
    if([Utility isEnableNetwork]){
        if ([[GKLocalPlayer localPlayer]isAuthenticated]) {
//            [[GameKitHelper sharedGameKitHelper]authenticateLocalPlayer];
//        }
        [[GameKitHelper sharedGameKitHelper]submitScore:(int64_t)value category:leaderboardName];
        }
//        if ([[GKLocalPlayer localPlayer]isAuthenticated]) {
//		
//		gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
//		[gameCenterManager setDelegate:self];
//            AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//            [gameCenterManager authenticateLocalUser:app.navController];
//	}
//    [gameCenterManager reportScore: value forCategory: leaderboardName];
    }
}

-(void)sendAchievements:(NSString*)achivementType{
//    if([Utility isEnableNetwork]){
//        GameCenterManager *gameManager;
//        if ([[GKLocalPlayer localPlayer]isAuthenticated]) {
//            gameManager = [[GameCenterManager alloc] init];
//            [gameManager setDelegate:self];
//              AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//            [gameManager authenticateLocalUser : app.navController];
//        }
//        [gameManager submitAchievement:[NSString stringWithFormat:@"%d",achivementType] percentComplete:100.0f];
//    }
    
    double percentCompleted;
    
    if([Utility isEnableNetwork]){
        if ([[GKLocalPlayer localPlayer]isAuthenticated]) {
//            [[GameKitHelper sharedGameKitHelper]authenticateLocalPlayer];
//        }
            [[GameKitHelper sharedGameKitHelper]submitAchievement:[NSString stringWithFormat:@"%@",achivementType] percentComplete:percentCompleted];
                   }
    }
}

@end
