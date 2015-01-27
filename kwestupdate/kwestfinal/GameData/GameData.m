//
//  GameData.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import "GameData.h"
#import "Score.h"
#import "QusList.h"
static GameData *GameDataManager = nil;
@implementation GameData
@synthesize qus,endurancequsnum,playerData;
@synthesize sprintqusnum,memoryn,memorycounter,sprintquscounter,memoryquscounter,endurancequscounter,sprintTimer,playerenergy,date,previousmemoryn,previouscounter,knowledgepath4counter,quest,testcounter,isHelpOn,isTutorialShown;
@synthesize sciencenum,logicnum,humanitiesnum,deepernum;
+(id) GameDataManager{
    @synchronized(self){
        if(GameDataManager  ==nil)
            GameDataManager = [[super allocWithZone:NULL]init];
    }
    return GameDataManager;
}
- (id)init {
    if((self=[super init])) {
        quslist = [[Myquslist alloc]init];
        testcounter =0;
        knowledgepath4counter=0;
		sprintqusnum=1;
        endurancequsnum=1;
        memoryn=2;
        memorycounter=1;
        memoryquscounter=1;
        sprintquscounter=1;
        endurancequscounter=1;
        sprintTimer=0.0;
        playerenergy=0;
        previousmemoryn=0;
        previouscounter=0;
        endurancetrynum=0;
        sprinttrynum=0;
        memorytrynum=0;
        prefs = [NSUserDefaults standardUserDefaults];
        
        sciencenum = [quslist getQusCount:1];
        logicnum = [quslist getQusCount:2];
        humanitiesnum = [quslist getQusCount:3];
        deepernum = [quslist getQusCount:4];
        isTutorialShown = FALSE;
    }
    return self;
}

+(id)allocWithZone:(NSZone *)zone{
    return [[self GameDataManager]retain];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}

-(void)readQusfromdb{
    self.qus = [[NSMutableArray alloc]init];
    
    
    self.qus =   [quslist   getQusList];
    NSLog(@"qusno=%d",self.qus.count);
    //[quslist release];
}

-(void)readPlayerDatafromdb{
    playerData = [[NSMutableArray alloc]init];
    
    //Myquslist *info = [[Myquslist alloc]init];
    playerData =   [quslist   getPlayerInfo];
   // [info release];
}

-(NSString*)playerName{
    NSString *name;
    [self readPlayerDatafromdb];
    QusList *playername = (QusList*)[playerData objectAtIndex:0];
    name = playername.playername;
    return name;
}

-(void)setknop:(float)f{
    [prefs setFloat:f forKey:@"knop"];
}
-(float)returnknop{
    
    float knop;
    knop = [prefs floatForKey:@"knop"];
    return knop;
    
}

-(void)setgold:(float)f{
    [prefs setFloat:f forKey:@"gold"];
}
-(float)returngold{
    float gold;
    gold = [prefs floatForKey:@"gold"];
    return gold;
}

-(void)setEnergy:(NSInteger)i{
    [prefs setInteger:i forKey:@"energy"];
}
-(NSInteger)returnenergy{
    
    NSInteger energy;
    energy = [prefs integerForKey:@"energy"];
    return energy;
}
-(void)setKarma:(NSInteger)i{
    [prefs setInteger:i forKey:@"karma"];
}
-(NSInteger)returnkarma{
   
    NSInteger karma = [prefs integerForKey:@"karma"];
    return karma;
}
-(void)setLevel:(NSInteger)i{
    if(i == 10){
        [Flurry logEvent:@"Token_Generate"];
    }
    [prefs setInteger:i forKey:@"level"];
    [[[Score alloc] init] sendAchievements:@"TowerBuilder"];
}

-(NSInteger)returnlevel{
    NSInteger level;
    level = [prefs integerForKey:@"level"];
    return level;
}

-(NSString*)getToken{
    return [prefs stringForKey:@"token"];
}
-(void)setToken:(NSString *)string{
    [prefs setObject:string forKey:@"token"];
}

-(float)getUScore{
    return [prefs floatForKey:@"uscore"];
}

-(void)setUScore:(float)value{
    [prefs setFloat:value forKey:@"uscore"];
}

-(void)setkeyofenergy:(BOOL)b{
    [prefs setBool:b forKey:@"keyofenergy"];
}

-(BOOL)returnkeyofenergy{
    BOOL keyofenergy;
    
    keyofenergy = [prefs boolForKey:@"keyofenergy"];
    NSLog(@"boolval=%i",keyofenergy);
    return keyofenergy;
}

-(void)setkeyofwisdom:(BOOL)b{
    [prefs setBool:b forKey:@"keyofwisdom"];
}

-(BOOL)returnkeyofwisdom{
    
    BOOL keyofwisdom;
    keyofwisdom = [prefs boolForKey:@"keyofwisdom"];
    return keyofwisdom;
}

-(void)setkeyofstrength:(BOOL)b{
    [prefs setBool:b forKey:@"keyofstrength"];
}

-(BOOL)returnkeyofstrength{
    
    BOOL keyofstrength;
    keyofstrength = [prefs boolForKey:@"keyofstrength"];
    return keyofstrength;
}

-(void)setpremium:(BOOL)b{
    [prefs   setBool:b forKey:@"premium"];
}

-(BOOL)returnpremium{
    
    BOOL premium;
    premium = [prefs boolForKey:@"premium"];
    return premium;
}



-(NSInteger)getQusindex:(NSInteger)difficulty{
    NSInteger d=0;
    NSInteger ran=0;
    while (d!=difficulty) {
        ran = arc4random()%[self.qus count];
        QusList *qusselect = (QusList*)[self.qus objectAtIndex:ran];
        d=qusselect.difficulty;
    }
   
    return ran;
}

-(NSInteger)getType:(NSInteger)type{
    QusList *typeselect = (QusList *)[self.qus objectAtIndex:type];
    NSInteger t = typeselect.type;
    return t;
}

-(NSString *)getLeader:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.leader;
    return str;
}
-(NSString *)getSubtype:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.subtype;
    return str;
}
-(NSInteger)getDifficulty:(NSInteger)index{
    NSInteger difficulty=0;;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    difficulty= qusselect.difficulty;
  //  NSLog(@"right=%d",qusselect.correct);
    return difficulty;
}
-(NSString *)getQus:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.qus;
    //str= [NSString stringWithFormat:@"Question difficulty =%d type = %d %@",str];
    return str;
}
-(NSInteger)getID:(NSInteger)index{
  QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    return qusselect.q_id;
}
-(NSString *)getOpt1:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.opt1;
    return str;
}
-(NSString *)getOpt2:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.opt2;
    return str;
}
-(NSString *)getOpt3:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.opt3;
    return str;
}
-(NSString *)getOpt4:(NSInteger)index{
    NSString *str;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    str= qusselect.opt4;
    return str;
}
-(int )getRightTag:(NSInteger)index{
    NSInteger right=0;;
    QusList *qusselect = (QusList*)[self.qus objectAtIndex:index];
    right= qusselect.correct;
    NSLog(@"right=%d",qusselect.correct);
    return right;
}

-(NSString *)getEndergydate{
    NSString *datestr;
    datestr = [prefs objectForKey:@"lastrefilldate"];
    return datestr;
}


-(void)setEndurancebest:(NSInteger)score{
    [prefs setInteger:score forKey:@"endurancebest"];
}

-(void)setEnduranceavg:(float)score{
    [prefs setFloat:score forKey:@"enduranceavg"];
}

-(void)setEnduranceLast:(NSInteger)score{
    [prefs setInteger:score forKey:@"endurancelast"];
}

-(NSInteger)getendurancebest{
    NSInteger tempscore = [prefs integerForKey:@"endurancebest"];
    return tempscore;
}

-(float)getEnduranceavg{
    float tempavg = [prefs floatForKey:@"enduranceavg"];
    return tempavg;

}
-(NSInteger)getEnduranceLast{
    NSInteger temp = [prefs integerForKey:@"endurancelast"];
    return temp;
}

-(void)setSprintBest:(float)score{
    [prefs setFloat:score forKey:@"sprintbest"];
}
-(void)setSprintavg:(float)score{
    [prefs setFloat:score forKey:@"sprintaverage"];
}
-(void)setSprintLast:(float)score{
    [prefs setFloat:score forKey:@"sprintlast"];
}
-(float)getSprintBest{
    float temp = [prefs floatForKey:@"sprintbest"];
    return temp;
}

-(float)getSprinteavg{
    float temp = [prefs floatForKey:@"sprintaverage"];
    return temp;
}
-(float)getSprintlast{
    float temp = [prefs floatForKey:@"sprintlast"];
    return temp;
}


-(NSInteger)getMemorybest{
    NSInteger tempscore = [prefs integerForKey:@"memorybest"];
    return tempscore;
}
-(float)getMemoryavg{
    float temp = [prefs floatForKey:@"memoryavg"];
    return temp;
}
-(void)setMemorybest:(NSInteger)score{
    [prefs setInteger:score forKey:@"memorybest"];
}

-(void)setMemoryavg:(float)score{
    [prefs setFloat:score forKey:@"memoryavg"];
}
-(void)setMemoryLast:(NSInteger)score{
    [prefs setInteger:score forKey:@"memorylast"];
}
-(NSInteger)getMemoryLast{
    NSInteger temp = [prefs integerForKey:@"memorylast"];
    return temp;
}

-(void)setEnergydate:(NSString*)str{
    NSLog(@"str=%@",str);
    [prefs setObject:str forKey:@"lastrefilldate"];
}

-(void)setQuestCompleted:(float)n{
    [prefs setFloat:n forKey:@"QuestCompleted"];
}

-(float)getQuestCompleted{
    float n = [prefs floatForKey:@"QuestCompleted"];
    return n;
}
-(NSInteger)getsprinttry{
    NSInteger n = [prefs integerForKey:@"sprinttrynum"];
    return n;
}
-(void)setsprinttry:(NSInteger)n{
    [prefs setInteger:n forKey:@"sprinttrynum"];
}
-(NSInteger)getendurancetry{
    NSInteger n = [prefs integerForKey:@"endurancetrynum"];
    return n;
}
-(void)setendurancetry:(NSInteger)n{
    [prefs setInteger:n forKey:@"endurancetrynum"];
}

-(NSInteger)getmemorytry{
    NSInteger n = [prefs integerForKey:@"memorytrynum"];
    return n;
}
-(void)setmemorytry:(NSInteger)n{
    [prefs setInteger:n forKey:@"memorytrynum"];
}


-(void)setoveralltry:(int)num{
    [prefs setInteger:num forKey:@"overalltry"];
}
-(NSInteger)getoveralltry{
    NSInteger num = [prefs integerForKey:@"overalltry"];
    return num;
}
-(void)setoverallbest:(float)num{
    [prefs setFloat:num forKey:@"overallbest"];
}
-(float)getoverallbest{
    float num = [prefs floatForKey:@"overallbest"];
    return num;
}
-(void)setoverallavg:(float)num{
    [prefs setFloat:num forKey:@"overallavg"];
}
-(float)getoverallavg{
    float num = [prefs floatForKey:@"overallavg"];
    return num;
}
-(void)setoveralllast:(float)num{
    [prefs setFloat:num forKey:@"overalllast"];
}
-(float)getoveralllast{
    float num = [prefs floatForKey:@"overalllast"];
    return num;
}

///////////////////////////////////// QUEST \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-(void)readquestfromdb{
    self.quest = [[NSMutableArray alloc]init];
    self.quest = [quslist getQuestList];
}



-(void)clearData{
    knowledgepath4counter=0;
    [self.qus removeAllObjects];
}

-(int)getEasterFlag{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"EasterFlag"];
}

-(void)setEasterFlag:(int)flag{
    [[NSUserDefaults standardUserDefaults]setInteger:flag forKey:@"EasterFlag"];
}
-(BOOL)getFirstTimeShared{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTimeShared"];
}
-(void)setFirstTimeShared:(BOOL)shared{
    [[NSUserDefaults standardUserDefaults]setBool:shared forKey:@"FirstTimeShared"];
}

-(void)setStartDate:(NSString*)startDate{
    [[NSUserDefaults standardUserDefaults]setObject:startDate forKey:@"StartDate"];
}

-(NSString*)getStartDate{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"StartDate"];
}

-(void)setWisdomDate:(NSString*)achivedDate{
    [[NSUserDefaults standardUserDefaults]setObject:achivedDate forKey:@"WisdomDate"];
}

-(NSString*)getWisdomDate{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"WisdomDate"];
}

-(double)growthRate{
    return ([self returnknop]/(24*[self numberOfDaysPlayed]));
}

-(int)numberOfDaysPlayed{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:today];
    int startDateInt = [[self getStartDate]intValue];
    int todayInt = [dateString intValue];
    return (todayInt-startDateInt)+1;
}

-(int)daysToWisdom{
    NSString *wisdomDate = [self getWisdomDate];
    if([wisdomDate length]<= 0){
        return 0;
    }
    else{
        return  ([[self getWisdomDate]intValue]-[[self getStartDate]intValue]+1);
    }
}

-(void)dealloc{
     [quslist release];
    [super dealloc];
   
}
@end
