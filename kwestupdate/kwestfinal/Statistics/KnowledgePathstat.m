//
//  KnowledgePathstat.m
//  kwest
//
//  Created by Anindya on 6/14/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "KnowledgePathstat.h"
#import "PlayerStat.h"
#import "Menu.h"
#import "GameData.h"
#import "PlayerStatistics.h"
#import <RevMobAds/RevMobAds.h>
#import "Utility.h"
@implementation KnowledgePathstat
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    KnowledgePathstat *layer = [KnowledgePathstat node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}
-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"Statistics"];
        gamedata = [GameData GameDataManager];
        if(![gamedata returnpremium] && [gamedata returnknop]>arc4random()%70){
            [[RevMobAds session] showFullscreen];
        }
        stat = [PlayerStatistics StatManager];
        backgroundImage = [CCSprite spriteWithFile:@"questBg.png"];
        backgroundImage.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
        [self addChild:backgroundImage];
        headerImage = [CCSprite spriteWithFile:@"Knowledge.png"];
        headerImage.position = ccp(160*DevicewidthRatio,440*DeviceheightRatio);
        [backgroundImage addChild:headerImage];
        
//        table = [CCSprite spriteWithFile:@"Table.png"];
//        table.position = ccp(157,240);
//        [backgroundImage addChild:table];
        CCMenuItemImage *backItem = [CCMenuItemImage itemWithNormalImage:@"Home_Green.png" selectedImage:@"Home_Green.png" target:self selector:@selector(back:)];
        //        CCMenuItem *backitem = [CCMenuItemFont itemFromString:@"back" target:self selector:@selector(back:)];
        CCMenu *back = [CCMenu menuWithItems:backItem, nil];
        back.position = ccp(35*DevicewidthRatio,35*DeviceheightRatio);
        [backgroundImage addChild:back];
        
        CCMenuItemImage *intelligentItem = [CCMenuItemImage itemWithNormalImage:@"Intel_Button.png" selectedImage:@"Intel_Button.png" target:self selector:@selector(goToInteligentStat)];
        CCMenu *inteligentMenu = [CCMenu menuWithItems:intelligentItem, nil];
        inteligentMenu.position = ccp(250*DevicewidthRatio,35*DeviceheightRatio);
        [backgroundImage addChild:inteligentMenu];
        
        overall = [CCSprite spriteWithFile:@"Overall.png"];
        overall.position = ccp(160*DevicewidthRatio,330*DeviceheightRatio);
        [backgroundImage addChild:overall];
        CCSprite *ratingProgressTimerSprite = [CCSprite spriteWithFile:@"Indicator_Big.png"];
        ratingProgressTimer = [CCProgressTimer progressWithSprite:ratingProgressTimerSprite];
        ratingProgressTimer.barChangeRate = ccp(1, 0);
        ratingProgressTimer.position = ccp(165,76);
        ratingProgressTimer.midpoint = ccp(0,76);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            ratingProgressTimer.position = ccp(135*DevicewidthRatio,74*DeviceheightRatio);
        }
        ratingProgressTimer.type = kCCProgressTimerTypeBar;
        ratingProgressTimer.percentage = 100;
        [overall addChild:ratingProgressTimer];
        detail = [CCSprite spriteWithFile:@"Details.png"];
        detail.position = ccp(160*DevicewidthRatio,160*DeviceheightRatio);
        [backgroundImage addChild:detail];
        CCSprite *worldProgressTimerSprite = [CCSprite spriteWithFile:@"Indicator_Small.png"];
        worldProgressTimer = [CCProgressTimer progressWithSprite:worldProgressTimerSprite];
        worldProgressTimer.barChangeRate = ccp(1, 0);
        worldProgressTimer.midpoint = ccp(0,76);
       [worldProgressTimer setPosition : ccp(170,168) ];
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            worldProgressTimer.position = ccp(140*DevicewidthRatio,158*DeviceheightRatio);
        }

        worldProgressTimer.type = kCCProgressTimerTypeBar;
        worldProgressTimer.percentage = 100;
       
        [detail addChild:worldProgressTimer];
        CCSprite *logicProgressTimerSprite = [CCSprite spriteWithFile:@"Indicator_Small.png"];
        logicProgressTimer = [CCProgressTimer progressWithSprite:logicProgressTimerSprite];
         logicProgressTimer.barChangeRate = ccp(1, 0);
        [logicProgressTimer setPosition : ccp(170,120) ];
        logicProgressTimer.midpoint = ccp(0,76);
        logicProgressTimer.type = kCCProgressTimerTypeBar;
        logicProgressTimer.percentage = 100;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            logicProgressTimer.position = ccp(140*DevicewidthRatio,112*DeviceheightRatio);
        }

        [detail addChild:logicProgressTimer];
        CCSprite *humanProgressTimerSprite = [CCSprite spriteWithFile:@"Indicator_Small.png"];
        humanProgressTimer = [CCProgressTimer progressWithSprite:humanProgressTimerSprite];
        humanProgressTimer.barChangeRate = ccp(1, 0);
        [humanProgressTimer setPosition : ccp(170,72) ];
        humanProgressTimer.midpoint = ccp(0,76);
        humanProgressTimer.type = kCCProgressTimerTypeBar;
        humanProgressTimer.percentage = 100;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            humanProgressTimer.position = ccp(140*DevicewidthRatio,67*DeviceheightRatio);
        }

        [detail addChild:humanProgressTimer];
    
        CCSprite *deeperProgressTimerSprite = [CCSprite spriteWithFile:@"Indicator_Small.png"];
        deeperProgressTimer = [CCProgressTimer progressWithSprite:deeperProgressTimerSprite];
        deeperProgressTimer.barChangeRate = ccp(1, 0);
        [deeperProgressTimer setPosition : ccp(170,24) ];
        deeperProgressTimer.midpoint = ccp(0,76);
        deeperProgressTimer.type = kCCProgressTimerTypeBar;
        deeperProgressTimer.percentage = 100;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            deeperProgressTimer.position = ccp(140*DevicewidthRatio,22*DeviceheightRatio);
        }

        [detail addChild:deeperProgressTimer];
        [self addkstat];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        if([[SimpleAudioEngine sharedEngine]willPlayBackgroundMusic]) {
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"HeartBeat.mp3" loop:NO];
    }
    
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

-(void)addkstat{
    //Myquslist *quslist = [[Myquslist alloc]init];
    int s = gamedata.sciencenum;//[quslist getQusCount:1];
    int l = gamedata.logicnum;//[quslist getQusCount:2];
    int h = gamedata.humanitiesnum;//[quslist getQusCount:3];
    int d = gamedata.deepernum;//[quslist getQusCount:4];
    float sciencerateval;
    float logicrateval;
    float hmrateval;
    float deeperrateval;
    
    if([stat getScienceTryRecord]==0){
        sciencerateval=0.00f;
        worldProgressTimer.percentage = 0.0f;
    }
    
    else{
    sciencerateval = ((float)[stat getScienceCorrectRecord]/(float)[stat getScienceTryRecord])*100;
    worldProgressTimer.percentage = sciencerateval;
    }
    NSString *scienceratestr = [NSString stringWithFormat:@"%d%%",(int)sciencerateval];
    CCLabelTTF *sciencerate = [CCLabelTTF labelWithString:scienceratestr fontName:@"Times" fontSize:18];
    sciencerate.position = ccp(260,170);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        sciencerate.fontSize  = 36;
        sciencerate.position = ccp(530,160*DeviceheightRatio);
    }
    [detail addChild:sciencerate];
    
    if([stat getLogicTryRecord]!=0){
        logicrateval = ((float)[stat getLogicCorrectRecord]/(float)[stat getLogicTryRecord])*100;
        logicProgressTimer.percentage = logicrateval;
    }
    else{
        logicrateval=0.00f;
        logicProgressTimer.percentage = 0.0f;
    }
    NSString *logicratestr = [NSString stringWithFormat:@"%d%%",(int)logicrateval];
    CCLabelTTF *logicerate = [CCLabelTTF labelWithString:logicratestr fontName:@"Times" fontSize:18];
    logicerate.position = ccp(260,122);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        logicerate.fontSize  = 36;
        logicerate.position = ccp(530,112*DeviceheightRatio);
    }
    [detail addChild:logicerate];
    
    if([stat getHumanitiesTryRecord]!=0){
        hmrateval = ((float)[stat getHumanitiesCorrectRecord]/(float)[stat getHumanitiesTryRecord])*100;
        humanProgressTimer.percentage = hmrateval;
    }
    else{
        hmrateval=0.00f;
        humanProgressTimer.percentage = 0.0f;
    }
    NSString *hmratestr = [NSString stringWithFormat:@"%d%%",(int)hmrateval];
    CCLabelTTF *hmrate = [CCLabelTTF labelWithString:hmratestr fontName:@"Times" fontSize:18];
    hmrate.position = ccp(260,72);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        hmrate.fontSize  = 36;
        hmrate.position = ccp(530,72*DeviceheightRatio);
    }
    [detail addChild:hmrate];
    
    if([stat getDeeperTryRecord]!=0){
        deeperrateval = ((float)[stat getDeeperCorrectRecord]/(float)[stat getDeeperTryRecord])*100;
        deeperProgressTimer.percentage = deeperrateval;
    }
    else{
        deeperrateval=0.00f;
        deeperProgressTimer.percentage = 0.0f;
    }
    NSString *deeperratestr = [NSString stringWithFormat:@"%d%%",(int)deeperrateval];
    CCLabelTTF *deeperrate = [CCLabelTTF labelWithString:deeperratestr fontName:@"Times" fontSize:18];
    deeperrate.position = ccp(260,22);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        deeperrate.fontSize  = 36;
        deeperrate.position = ccp(530,22*DeviceheightRatio);
    }
    [detail addChild:deeperrate];
    
   
    int totaltrycounter = ([stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord]);
    NSString *totalcounterstr = [NSString stringWithFormat:@"%d",totaltrycounter];
    CCLabelTTF  *totaltrycounterlbl = [CCLabelTTF labelWithString:totalcounterstr fontName:@"Times" fontSize:18];
    totaltrycounterlbl.position = ccp(260,34);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        totaltrycounterlbl.fontSize  = 36;
        totaltrycounterlbl.position = ccp(530,34*DeviceheightRatio);
    }
    [overall addChild:totaltrycounterlbl];
 
    int numofSuns = 0;
    if(totaltrycounter < 10){
        numofSuns = 0;
    }
    else if(totaltrycounter<60){
        numofSuns = 1;
    }
    else if (totaltrycounter<150){
        numofSuns = 2;
    }
    else if (totaltrycounter<300){
        numofSuns = 3;
    }
    else if (totaltrycounter<550){
        numofSuns = 4;
    }
    else{
        numofSuns = 5;
    }
    
    float sunXPos = 90;
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        sunXPos = 73*DevicewidthRatio;
    }
    for(int i=0 ; i<numofSuns ; i++){
        CCSprite *sunSprite = [CCSprite spriteWithFile:@"Sun.png"];
        sunSprite.position = ccp(sunXPos+(i+1)*25,34);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
             sunSprite.position = ccp(sunXPos+(i+1)*50,34*DeviceheightRatio);
        }
        [overall addChild:sunSprite];
    }
    
    int correctcounter = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
    NSString *correctcounterstr = [NSString stringWithFormat:@"%d",correctcounter];
    CCLabelTTF  *trycounterlbl = [CCLabelTTF labelWithString:correctcounterstr fontName:@"Times" fontSize:18];
    
    trycounterlbl.position = ccp(260,30);
   // [overall addChild:trycounterlbl];
    
    int totalqcounter = s+l+h+d;
    
    NSString *totalqcounterstr = [NSString stringWithFormat:@"%d",totalqcounter];
    CCLabelTTF  *totalcounterlbl = [CCLabelTTF labelWithString:totalqcounterstr fontName:@"Times" fontSize:18];
    
    totalcounterlbl.position = ccp(230,250);
   // [self addChild:totalcounterlbl];
    
    int correctsum = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
    int trysum = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
    NSLog(@"sum=%d%d",correctsum,trysum);
    float lastcounter=0.0f;
    if(trysum!=0){
        lastcounter = ((float)correctsum/(float)trysum)*100;
        ratingProgressTimer.percentage = lastcounter;
    }
    else {
        ratingProgressTimer.percentage = 0.0;
    }
    NSString *lastcounterstr = [NSString stringWithFormat:@"%d%%",(int)lastcounter];
    CCLabelTTF  *lastcounterlbl = [CCLabelTTF labelWithString:lastcounterstr fontName:@"Times" fontSize:18];
    
    lastcounterlbl.position = ccp(260,76);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        lastcounterlbl.fontSize  = 36;
        lastcounterlbl.position = ccp(530,74*DeviceheightRatio);
    }
    [overall addChild:lastcounterlbl];
    //  [Myquslist release];
}

-(void)back:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)goToInteligentStat{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[PlayerStat scene]]];
}
@end
