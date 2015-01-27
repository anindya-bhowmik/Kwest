//
//  PlayerStat.m
//  kwest
//
//  Created by Tashnuba Jabbar on 07/11/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "PlayerStat.h"
#import "KnowledgePathstat.h"
#import <RevMobAds/RevMobAds.h>
#import "Utility.h"
UITextField *sciencetry;
UITextField *logictry;
UITextField *humantry;
UITextField *deepertry;
UITextField *sciencecorrect;
UITextField *logiccorrect;
UITextField *humancorrect;
UITextField *deepercorrect;
UITextField *memavgtf;
UITextField *sprintavgtf;
UITextField *endavgtf;
UIView *view;

@implementation PlayerStat
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    PlayerStat *layer = [PlayerStat node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(id)init{
    if(self =[super init]){
        if(![[GameData GameDataManager] returnpremium] && [[GameData GameDataManager] returnknop]>arc4random()%60){
            [[RevMobAds session] showFullscreen];
        }
       // view = [[CCDirector sharedDirector]openGLView];
        Score *sc = [[Score alloc]init];
        [sc lstatOverall];
        backgroundImage = [CCSprite spriteWithFile:@"questBg.png"];
        backgroundImage.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
        [self addChild:backgroundImage];
        headerImage = [CCSprite spriteWithFile:@"Intel_Title.png"];
        headerImage.position = ccp(160*DevicewidthRatio,440*DeviceheightRatio);
        [backgroundImage addChild:headerImage];
        
        table = [CCSprite spriteWithFile:@"Table.png"];
        table.position = ccp(157*DevicewidthRatio,240*DeviceheightRatio);
        [backgroundImage addChild:table];
        CCMenuItemImage *backItem = [CCMenuItemImage itemWithNormalImage:@"Home_Green.png" selectedImage:@"Home_Green.png" target:self selector:@selector(back:)];
//        CCMenuItem *backitem = [CCMenuItemFont itemFromString:@"back" target:self selector:@selector(back:)];
        CCMenu *back = [CCMenu menuWithItems:backItem, nil];
        back.position = ccp(35*DevicewidthRatio,35*DeviceheightRatio);
        [backgroundImage addChild:back];
        
        CCMenuItemImage *knowledgeItem = [CCMenuItemImage itemWithNormalImage:@"Know_Button.png" selectedImage:@"Know_Button.png" target:self selector:@selector(goToKnowledgeStat)];
        CCMenu *knowledgeMenu = [CCMenu menuWithItems:knowledgeItem, nil];
        knowledgeMenu.position = ccp(250*DevicewidthRatio,35*DeviceheightRatio);
        [backgroundImage addChild:knowledgeMenu];
        
        
//        CCMenuItem *setkitem = [CCMenuItemFont itemFromString:@"Set k table " target:self selector:@selector(setk:)];
//        CCMenu *setk = [CCMenu menuWithItems:setkitem, nil];
//        setk.position = ccp(250,460);
//        [self addChild:setk];
//        
//        CCMenuItem *setlitem = [CCMenuItemFont itemFromString:@"Set l table " target:self selector:@selector(setl:)];
//        CCMenu *setl = [CCMenu menuWithItems:setlitem, nil];
//        setl.position = ccp(250,200);
//        [self addChild:setl];

        gamedata = [GameData GameDataManager];
        stat = [PlayerStatistics StatManager];
        [self addLstat];
       // [self addktable];
      //  [self addkstat];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    //[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"HeartBeat.mp3"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        if([[SimpleAudioEngine sharedEngine]willPlayBackgroundMusic]) {
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"HeartBeat.mp3" loop:NO];
    }
    
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

-(void)goToKnowledgeStat{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:[KnowledgePathstat scene]]];
}
//-(void)addktable{
//
//    CCLabelTTF *kstat = [CCLabelTTF labelWithString:@"k-Statistics" fontName:@"Times" fontSize:18];
//    kstat.position = ccp(100,430);
//    kstat.color = ccBLUE;
//    [self addChild:kstat];
//    
//    CCLabelTTF *topic = [CCLabelTTF labelWithString:@"Topic" fontName:@"Times" fontSize:18];
//    topic.position = ccp(30,400);
//    [self addChild:topic];
//    CCLabelTTF *science = [CCLabelTTF labelWithString:@"Science" fontName:@"Times" fontSize:18];
//    science.position = ccp(30,370);
//    [self addChild:science];
//    CCLabelTTF *logic = [CCLabelTTF labelWithString:@"Logic" fontName:@"Times" fontSize:18];
//    logic.position = ccp(30,340);
//    [self addChild:logic];
//    CCLabelTTF *humanities = [CCLabelTTF labelWithString:@"Humanities" fontName:@"Times" fontSize:18];
//    humanities.position = ccp(30,310);
//    [self addChild:humanities];
//    CCLabelTTF *deeper = [CCLabelTTF labelWithString:@"Deeper" fontName:@"Times" fontSize:18];
//    deeper.position = ccp(30,280);
//    [self addChild:deeper];
//    CCLabelTTF *total = [CCLabelTTF labelWithString:@"Total" fontName:@"Times" fontSize:18];
//    total.position = ccp(30,250);
//    [self addChild:total];
//    
//    CCLabelTTF *try = [CCLabelTTF labelWithString:@"Tries" fontName:@"Times" fontSize:18];
//    try.position = ccp(90,400);
//    [self addChild:try];
//    
//    NSString *sciencetrystr = [NSString stringWithFormat:@"%d",[stat getScienceTryRecord]];
//    CCLabelTTF *sciencetrylbl = [CCLabelTTF labelWithString:sciencetrystr fontName:@"Times" fontSize:18];
//    sciencetrylbl.position = ccp(90,370);
//    [self addChild:sciencetrylbl];
//    
//    NSString *logictrystr = [NSString stringWithFormat:@"%d",[stat getLogicTryRecord]];
//    CCLabelTTF *logictrylbl = [CCLabelTTF labelWithString:logictrystr fontName:@"Times" fontSize:18];
//    logictrylbl.position = ccp(90,340);
//    [self addChild:logictrylbl];
//    
//    NSString *humanitiestrystr = [NSString stringWithFormat:@"%d",[stat getHumanitiesTryRecord]];
//    CCLabelTTF *humanitiestrylbl = [CCLabelTTF labelWithString:humanitiestrystr fontName:@"Times" fontSize:18];
//    humanitiestrylbl.position = ccp(90,310);
//    [self addChild:humanitiestrylbl];
//    
//    NSString *deepertrystr = [NSString stringWithFormat:@"%d",[stat getDeeperTryRecord]];
//    CCLabelTTF *deepertrylbl = [CCLabelTTF labelWithString:deepertrystr fontName:@"Times" fontSize:18];
//    deepertrylbl.position = ccp(90,280);
//    [self addChild:deepertrylbl];
//    
//    NSString *overalltrystr = [NSString stringWithFormat:@"%d",[stat getTotalTryRecord]];
//    CCLabelTTF *overalltrylbl = [CCLabelTTF labelWithString:overalltrystr fontName:@"Times" fontSize:18];
//    overalltrylbl.position = ccp(90,250);
//    [self addChild:overalltrylbl];
//    
//    CCLabelTTF *correct = [CCLabelTTF labelWithString:@"Correct" fontName:@"Times" fontSize:18];
//    correct.position = ccp(150,400);
//    [self addChild:correct];
//    
//    NSString *sciencecorrectstr = [NSString stringWithFormat:@"%d",[stat getScienceCorrectRecord]];
//    CCLabelTTF *sciencecorrectlbl = [CCLabelTTF labelWithString:sciencecorrectstr fontName:@"Times" fontSize:18];
//    sciencecorrectlbl.position = ccp(150,370);
//    [self addChild:sciencecorrectlbl];
//    
//    NSString *logiccorrectstr = [NSString stringWithFormat:@"%d",[stat getLogicCorrectRecord]];
//    CCLabelTTF *logiccorrectlbl = [CCLabelTTF labelWithString:logiccorrectstr fontName:@"Times" fontSize:18];
//    logiccorrectlbl.position = ccp(150,340);
//    [self addChild:logiccorrectlbl];
//    
//    NSString *humanitiescorrectstr = [NSString stringWithFormat:@"%d",[stat getHumanitiesCorrectRecord]];
//    CCLabelTTF *humanitiescorrectlbl = [CCLabelTTF labelWithString:humanitiescorrectstr fontName:@"Times" fontSize:18];
//    humanitiescorrectlbl.position = ccp(150,310);
//    [self addChild:humanitiescorrectlbl];
//    
//    NSString *deepercorrectstr = [NSString stringWithFormat:@"%d",[stat getDeeperCorrectRecord]];
//    CCLabelTTF *deepercorrectlbl = [CCLabelTTF labelWithString:deepercorrectstr fontName:@"Times" fontSize:18];
//    deepercorrectlbl.position = ccp(150,280);
//    [self addChild:deepercorrectlbl];
//    
//    NSString *totalcorrectstr = [NSString stringWithFormat:@"%d",[stat getTotalCorrectRecord]];
//    CCLabelTTF *totalcorrectlbl = [CCLabelTTF labelWithString:totalcorrectstr fontName:@"Times" fontSize:18];
//    totalcorrectlbl.position = ccp(150,250);
//    [self addChild:totalcorrectlbl];
//    
//    CCLabelTTF *num = [CCLabelTTF labelWithString:@"Total" fontName:@"Times" fontSize:18];
//    num.position = ccp(210,400);
//    [self addChild:num];
//    
//    NSString *sciencenum = [NSString stringWithFormat:@"%d",gamedata.sciencenum];
//    CCLabelTTF *sciencenumlbl = [CCLabelTTF labelWithString:sciencenum fontName:@"Times" fontSize:18];
//    sciencenumlbl.position = ccp(210,370);
//    [self addChild:sciencenumlbl];
//    
//    NSString *logicnum = [NSString stringWithFormat:@"%d",gamedata.logicnum];
//    CCLabelTTF *logicnumlbl = [CCLabelTTF labelWithString:logicnum fontName:@"Times" fontSize:18];
//    logicnumlbl.position = ccp(210,340);
//    [self addChild:logicnumlbl];
//    
//    NSString *humanitiesnum = [NSString stringWithFormat:@"%d",gamedata.humanitiesnum];
//    CCLabelTTF *humanitiesnumlbl = [CCLabelTTF labelWithString:humanitiesnum fontName:@"Times" fontSize:18];
//    humanitiesnumlbl.position = ccp(210,310);
//    [self addChild:humanitiesnumlbl];
//    
//    NSString *deepernum = [NSString stringWithFormat:@"%d",gamedata.deepernum];
//    CCLabelTTF *deepernumlbl = [CCLabelTTF labelWithString:deepernum fontName:@"Times" fontSize:18];
//    deepernumlbl.position = ccp(210,280);
//    [self addChild:deepernumlbl];
//    
//    
//    NSString *totalnum = [NSString stringWithFormat:@"%d",gamedata.sciencenum+gamedata.logicnum+gamedata.humanitiesnum+gamedata.deepernum];
//    CCLabelTTF *totalnumlbl = [CCLabelTTF labelWithString:totalnum fontName:@"Times" fontSize:18];
//    totalnumlbl.position = ccp(210,250);
//    [self addChild:totalnumlbl];
//    
//    CCLabelTTF *rate = [CCLabelTTF labelWithString:@"Rate(%)" fontName:@"Times" fontSize:18];
//    rate.position = ccp(270,400);
//    [self addChild:rate];
//    
//    NSString *scienceratestr = [NSString stringWithFormat:@"%.2f",[stat getSciencePercentRecord]];
//    CCLabelTTF *scienceratelbl = [CCLabelTTF labelWithString:scienceratestr fontName:@"Times" fontSize:18];
//    scienceratelbl.position = ccp(270,370);
//    [self addChild:scienceratelbl];
//    
//    NSString *logicratestr = [NSString stringWithFormat:@"%.2f",[stat getLogicPercentRecord]];
//    CCLabelTTF *logicratelbl = [CCLabelTTF labelWithString:logicratestr fontName:@"Times" fontSize:18];
//    logicratelbl.position = ccp(270,340);
//    [self addChild:logicratelbl];
//    
//    NSString *humanitiesratestr = [NSString stringWithFormat:@"%.2f",[stat getHumanitiesPercentRecord]];
//    CCLabelTTF *humanitiesratelbl = [CCLabelTTF labelWithString:humanitiesratestr fontName:@"Times" fontSize:18];
//    humanitiesratelbl.position = ccp(270,310);
//    [self addChild:humanitiesratelbl];
//    
//    NSString *deeperratestr = [NSString stringWithFormat:@"%.2f",[stat getDeeperPercentRecord]];
//    CCLabelTTF *deeperratelbl = [CCLabelTTF labelWithString:deeperratestr fontName:@"Times" fontSize:18];
//    deeperratelbl.position = ccp(270,280);
//    [self addChild:deeperratelbl];
//    
//    NSString *totalratestr = [NSString stringWithFormat:@"%.2f",[stat getTotalRates]];
//    CCLabelTTF *totalratelbl = [CCLabelTTF labelWithString:totalratestr fontName:@"Times" fontSize:18];
//    totalratelbl.position = ccp(270,250);
//    [self addChild:totalratelbl];
//}
-(void)setk:(id)sender{
    [stat setScienceTryRecord:[sciencetry.text integerValue]];
    [stat setLogicTryRecord:[logictry.text integerValue]];
    [stat setHumanitiesTryRecord:[humantry.text integerValue]];
    [stat setDeeperTryRecord:[deepertry.text integerValue]];
    [stat setSciencecorrectRecord:[sciencecorrect.text integerValue]];
    [stat setLogiccorrectRecord:[logiccorrect.text integerValue]];
    [stat setHumanitiescorrectRecord:[humancorrect.text integerValue]];
    [stat setDeepercorrectRecord:[deepercorrect.text integerValue]];
  //  [self karmaCalculation];
    [self removeUI];
    [[CCDirector sharedDirector]replaceScene:[PlayerStat scene]];
}
-(void)setl:(id)sender{
    [gamedata setEnduranceavg:[endavgtf.text floatValue]];
    [gamedata setSprintavg:[sprintavgtf.text floatValue]];
    [gamedata setMemoryavg:[memavgtf.text floatValue]];
   // [self karmaCalculation];
    [self removeUI];
    [[CCDirector sharedDirector]replaceScene:[PlayerStat scene]];
}


//-(void)addkstat{
//    //Myquslist *quslist = [[Myquslist alloc]init];
//    int s = gamedata.sciencenum;//[quslist getQusCount:1];
//    int l = gamedata.logicnum;//[quslist getQusCount:2];
//    int h = gamedata.humanitiesnum;//[quslist getQusCount:3];
//    int d = gamedata.deepernum;//[quslist getQusCount:4];
//    float sciencerateval;
//    float logicrateval;
//    float hmrateval;
//    float deeperrateval;
//    CCLabelTTF *kstat = [CCLabelTTF labelWithString:@"k-Statistics" fontName:@"Times" fontSize:18];
//    kstat.position = ccp(100,430);
//    kstat.color = ccBLUE;
//    [self addChild:kstat];
//    
//    CCLabelTTF *topic = [CCLabelTTF labelWithString:@"Topic" fontName:@"Times" fontSize:18];
//    topic.position = ccp(30,400);
//    [self addChild:topic];
//    CCLabelTTF *science = [CCLabelTTF labelWithString:@"Science" fontName:@"Times" fontSize:18];
//    science.position = ccp(30,370);
//    [self addChild:science];
//    CCLabelTTF *logic = [CCLabelTTF labelWithString:@"Logic" fontName:@"Times" fontSize:18];
//    logic.position = ccp(30,340);
//    [self addChild:logic];
//    CCLabelTTF *humanities = [CCLabelTTF labelWithString:@"Humanities" fontName:@"Times" fontSize:18];
//    humanities.position = ccp(30,310);
//    [self addChild:humanities];
//    CCLabelTTF *deeper = [CCLabelTTF labelWithString:@"Deeper" fontName:@"Times" fontSize:18];
//    deeper.position = ccp(30,280);
//    [self addChild:deeper];
//    
//    CCLabelTTF *try = [CCLabelTTF labelWithString:@"Tries" fontName:@"Times" fontSize:18];
//    try.position = ccp(90,400);
//    [self addChild:try];
//    NSString *sciencetrystr = [NSString stringWithFormat:@"%d",[stat getScienceTryRecord]];
//    sciencetry = [[UITextField alloc]initWithFrame:CGRectMake(70, 100, 30, 20)];
//    sciencetry.backgroundColor = [UIColor whiteColor];
//    sciencetry.text = sciencetrystr;
//    sciencetry.returnKeyType = UIReturnKeyDone;
//    [sciencetry addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [view addSubview:sciencetry];
//    CCLabelTTF *sciencenum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[stat getScienceTryRecord]] fontName:@"Times" fontSize:18];
//    sciencenum.position = ccp(90,370);
//    [self addChild:sciencenum];
//    
//    
//    NSString *logictrystr = [NSString stringWithFormat:@"%d",[stat getLogicTryRecord]];
//    logictry = [[UITextField alloc]initWithFrame:CGRectMake(70, 130, 30, 20)];
//    logictry.text = logictrystr;
//    logictry.backgroundColor = [UIColor whiteColor];
//    logictry.text = logictrystr;
//    logictry.returnKeyType = UIReturnKeyDone;
//    [logictry addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [view addSubview:logictry];
//    CCLabelTTF *logicnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[stat getLogicTryRecord]] fontName:@"Times" fontSize:18];
//    logicnum.position = ccp(90,340);
//    [self addChild:logicnum];
//    
//    NSString *hmtrystr = [NSString stringWithFormat:@"%d",[stat getHumanitiesTryRecord]];
//    humantry = [[UITextField alloc]initWithFrame:CGRectMake(70, 160, 30, 20)];
//    humantry.text = hmtrystr;
//    humantry.backgroundColor = [UIColor whiteColor];
//    humantry.returnKeyType = UIReturnKeyDone;
//    [humantry addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [view addSubview:humantry];
//    CCLabelTTF *hmnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[stat getHumanitiesTryRecord]] fontName:@"Times" fontSize:18];
//    hmnum.position = ccp(90,310);
//    [self addChild:hmnum];
//    
//    NSString *deepertrystr = [NSString stringWithFormat:@"%d",[stat getDeeperTryRecord]];
//    deepertry = [[UITextField alloc]initWithFrame:CGRectMake(70, 190, 30, 20)];
//    deepertry.text = deepertrystr;
//    deepertry.backgroundColor = [UIColor whiteColor];
//    deepertry.returnKeyType = UIReturnKeyDone;
//    [deepertry addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [view addSubview:deepertry];
//    CCLabelTTF *dpnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[stat getDeeperTryRecord]] fontName:@"Times" fontSize:18];
//    dpnum.position = ccp(90,280);
//    [self addChild:dpnum];
//    
//    
//    CCLabelTTF *best = [CCLabelTTF labelWithString:@"Correct" fontName:@"Times" fontSize:18];
//    best.position = ccp(150,400);
//    [self addChild:best];
//    NSString *sciencecorrecstr = [NSString stringWithFormat:@"%d",[stat getScienceCorrectRecord]];
//    NSString *logiccorrectstr = [NSString stringWithFormat:@"%d",[stat getLogicCorrectRecord]];
//    NSString *hmcorrectstr = [NSString stringWithFormat:@"%d",[stat getHumanitiesCorrectRecord]];
//    NSString *deepercorrectstr = [NSString stringWithFormat:@"%d",[stat getDeeperCorrectRecord]];
//    
//    sciencecorrect = [[UITextField alloc]initWithFrame:CGRectMake(140, 100, 30, 20)];
//    sciencecorrect.text = sciencecorrecstr;
//    sciencecorrect.backgroundColor = [UIColor whiteColor];
//    sciencecorrect.returnKeyType = UIReturnKeyDone;
//    [sciencecorrect addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//
//    [view addSubview:sciencecorrect];
//    CCLabelTTF *sciencecorrect = [CCLabelTTF labelWithString:sciencecorrecstr fontName:@"Times" fontSize:18];
//    sciencecorrect.position = ccp(150,370);
//    [self addChild:sciencecorrect];
//    
//    logiccorrect = [[UITextField alloc]initWithFrame:CGRectMake(140, 130, 30, 20)];
//    logiccorrect.text = logiccorrectstr;
//    logiccorrect.backgroundColor = [UIColor whiteColor];
//    logiccorrect.returnKeyType = UIReturnKeyDone;
//    [logiccorrect addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//
//    [view addSubview:logiccorrect];
//    CCLabelTTF *logiccorrect = [CCLabelTTF labelWithString:logiccorrectstr fontName:@"Times" fontSize:18];
//    logiccorrect.position = ccp(150,340);
//    [self addChild:logiccorrect];
//    
//    humancorrect = [[UITextField alloc]initWithFrame:CGRectMake(140, 160, 30, 20)];
//    humancorrect.text = hmcorrectstr;
//    humancorrect.backgroundColor = [UIColor whiteColor];
//    humancorrect.returnKeyType = UIReturnKeyDone;
//    [humancorrect addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//
//    [view addSubview:humancorrect];
//    CCLabelTTF *hmcorrect = [CCLabelTTF labelWithString:hmcorrectstr fontName:@"Times" fontSize:18];
//    hmcorrect.position = ccp(150,310);
//    [self addChild:hmcorrect];
//    
//    deepercorrect = [[UITextField alloc]initWithFrame:CGRectMake(140, 190, 30, 20)];
//    deepercorrect.text = deepercorrectstr;
//    deepercorrect.backgroundColor = [UIColor whiteColor];
//    deepercorrect.returnKeyType = UIReturnKeyDone;
//    [deepercorrect addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
//
//    [view addSubview:deepercorrect];
//    CCLabelTTF *deepercorrect = [CCLabelTTF labelWithString:deepercorrectstr fontName:@"Times" fontSize:18];
//    deepercorrect.position = ccp(150,280);
//    [self addChild:deepercorrect];
//    
//    CCLabelTTF *average = [CCLabelTTF labelWithString:@"Total" fontName:@"Times" fontSize:18];
//    average.position = ccp(230,400);
//    [self addChild:average];
//    NSString *sciencnumstr = [NSString stringWithFormat:@"%d",s];
//    NSString *logicnumstr = [NSString stringWithFormat:@"%d",l];
//    NSString *hmnumstr = [NSString stringWithFormat:@"%d",h];
//    NSString *deepernumstr = [NSString stringWithFormat:@"%d",d];
//    CCLabelTTF *sciencenumlbl = [CCLabelTTF labelWithString:sciencnumstr fontName:@"Times" fontSize:18];
//    sciencenumlbl.position = ccp(230,370);
//    [self addChild:sciencenumlbl];
//    CCLabelTTF *logicnumlbl = [CCLabelTTF labelWithString:logicnumstr fontName:@"Times" fontSize:18];
//    logicnumlbl.position = ccp(230,340);
//    [self addChild:logicnumlbl];
//    CCLabelTTF *hmnumlbl = [CCLabelTTF labelWithString:hmnumstr fontName:@"Times" fontSize:18];
//    hmnumlbl.position = ccp(230,310);
//    [self addChild:hmnumlbl];
//    CCLabelTTF *depernumlbl = [CCLabelTTF labelWithString:deepernumstr fontName:@"Times" fontSize:18];
//    depernumlbl.position = ccp(230,280);
//    [self addChild:depernumlbl];
//    
//    CCLabelTTF *last = [CCLabelTTF labelWithString:@"Rate" fontName:@"Times" fontSize:18];
//    last.position = ccp(300,400);
//    [self addChild:last];
//   
//   
//    
//   
//    if([stat getScienceTryRecord]==0)
//        sciencerateval=0.00f;
//       
//    else 
//         sciencerateval = ((float)[stat getScienceCorrectRecord]/(float)[stat getScienceTryRecord])*100;
//     NSString *scienceratestr = [NSString stringWithFormat:@"%.2f",sciencerateval];
//    CCLabelTTF *sciencerate = [CCLabelTTF labelWithString:scienceratestr fontName:@"Times" fontSize:18];
//    sciencerate.position = ccp(300,370);
//    [self addChild:sciencerate];
//    
//    if([stat getLogicTryRecord]!=0)
//        logicrateval = ((float)[stat getLogicCorrectRecord]/(float)[stat getLogicTryRecord])*100;
//    else 
//        logicrateval=0.00f;
//     NSString *logicratestr = [NSString stringWithFormat:@"%.2f",logicrateval];
//    CCLabelTTF *logicerate = [CCLabelTTF labelWithString:logicratestr fontName:@"Times" fontSize:18];
//    logicerate.position = ccp(300,340);
//    [self addChild:logicerate];
//    
//    if([stat getHumanitiesTryRecord]!=0)
//        hmrateval = ((float)[stat getHumanitiesCorrectRecord]/(float)[stat getHumanitiesTryRecord])*100;
//    else 
//        hmrateval=0.00f;
//    NSString *hmratestr = [NSString stringWithFormat:@"%.2f",hmrateval];
//    CCLabelTTF *hmrate = [CCLabelTTF labelWithString:hmratestr fontName:@"Times" fontSize:18];
//    hmrate.position = ccp(300,310);
//    [self addChild:hmrate];
//    
//    if([stat getDeeperTryRecord]!=0)
//        deeperrateval = ((float)[stat getDeeperCorrectRecord]/(float)[stat getDeeperTryRecord])*100;
//    else 
//        deeperrateval=0.00f;
//     NSString *deeperratestr = [NSString stringWithFormat:@"%.2f",deeperrateval];
//    CCLabelTTF *deeperrate = [CCLabelTTF labelWithString:deeperratestr fontName:@"Times" fontSize:18];
//    deeperrate.position = ccp(300,280);
//    [self addChild:deeperrate];
//    
//    CCLabelTTF *overall = [CCLabelTTF labelWithString:@"Total" fontName:@"Times" fontSize:18];
//    overall.position=ccp(30,250);
//    [self addChild:overall];
//    int totaltrycounter = ([stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord]);
//    NSString *totalcounterstr = [NSString stringWithFormat:@"%d",totaltrycounter];
//    CCLabelTTF  *totaltrycounterlbl = [CCLabelTTF labelWithString:totalcounterstr fontName:@"Times" fontSize:18];
//    
//    totaltrycounterlbl.position = ccp(90,250);
//    [self addChild:totaltrycounterlbl];
//    
//    int correctcounter = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
//    NSString *correctcounterstr = [NSString stringWithFormat:@"%d",correctcounter];
//    CCLabelTTF  *trycounterlbl = [CCLabelTTF labelWithString:correctcounterstr fontName:@"Times" fontSize:18];
//    
//    trycounterlbl.position = ccp(150,250);
//    [self addChild:trycounterlbl];
//    
//    int totalqcounter = s+l+h+d;
//    
//    NSString *totalqcounterstr = [NSString stringWithFormat:@"%d",totalqcounter];
//    CCLabelTTF  *totalcounterlbl = [CCLabelTTF labelWithString:totalqcounterstr fontName:@"Times" fontSize:18];
//    
//    totalcounterlbl.position = ccp(230,250);
//    [self addChild:totalcounterlbl];
//    
//    int correctsum = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
//    int trysum = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
//    NSLog(@"sum=%d%d",correctsum,trysum);
//    float lastcounter=0.0f;
//    if(trysum!=0)
//         lastcounter = ((float)correctsum/(float)trysum)*100;
//    NSString *lastcounterstr = [NSString stringWithFormat:@"%.2f",lastcounter];
//    CCLabelTTF  *lastcounterlbl = [CCLabelTTF labelWithString:lastcounterstr fontName:@"Times" fontSize:18];
//    
//    lastcounterlbl.position = ccp(300,250);
//    [self addChild:lastcounterlbl];
//  //  [Myquslist release];
//}
-(void)back:(id)sender{
    [self removeUI];
        [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)removeUI{
    [sciencecorrect removeFromSuperview];
    [logiccorrect removeFromSuperview];
    [humancorrect removeFromSuperview];
    [deepercorrect removeFromSuperview];
    [sciencetry removeFromSuperview];
    [logictry removeFromSuperview];
    [humantry removeFromSuperview];
    [deepertry removeFromSuperview];
    [endavgtf removeFromSuperview];
    [sprintavgtf removeFromSuperview];
    [memavgtf removeFromSuperview];
    [sciencecorrect release];
    [sciencetry release];
    [logictry release];
    [logiccorrect release];
    [humantry release];
    [humancorrect release];
    [deepertry release];
    [deepercorrect release];

}
-(void)addLstat{
 
    
//    CCLabelTTF *lstat = [CCLabelTTF labelWithString:@"L-Statistics" fontName:@"Times" fontSize:18];
//    lstat.position = ccp(100,200);
//    lstat.color = ccBLUE;
//    [self addChild:lstat];
    
//    CCLabelTTF *type = [CCLabelTTF labelWithString:@"type" fontName:@"Times" fontSize:18];
//    type.position = ccp(30,170);
//    [self addChild:type];
//    CCLabelTTF *endurance = [CCLabelTTF labelWithString:@"Endurance" fontName:@"Times" fontSize:18];
//    endurance.position = ccp(30,140);
//    [self addChild:endurance];
//    CCLabelTTF *sprint = [CCLabelTTF labelWithString:@"Sprint" fontName:@"Times" fontSize:18];
//    sprint.position = ccp(30,110);
//    [self addChild:sprint];
//    CCLabelTTF *memory = [CCLabelTTF labelWithString:@"Memory" fontName:@"Times" fontSize:18];
//    memory.position = ccp(30,80);
//    [self addChild:memory];
    
//    CCLabelTTF *try = [CCLabelTTF labelWithString:@"Tries" fontName:@"Times" fontSize:18];
//    try.position = ccp(90,170);
//    [self addChild:try];
    /////Memory
    CCLabelTTF *memnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[gamedata getmemorytry]] fontName:@"Times-Bold" fontSize:22];
    memnum.position = ccp(105,236);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        memnum.fontSize = 44;
        memnum.position = ccp(90*DevicewidthRatio,226*DeviceheightRatio);
    }
    [table addChild:memnum];
    
    
    /// Focus
    CCLabelTTF *endnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[gamedata getendurancetry]] fontName:@"Times-Bold" fontSize:22];
    
    endnum.position = ccp(105,110);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        endnum.fontSize = 44;
        endnum.position = ccp(90*DevicewidthRatio,100*DeviceheightRatio);
    }
    [table addChild:endnum];
    
    
    ///Speed
    CCLabelTTF *spnum = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[gamedata getsprinttry]] fontName:@"Times-Bold" fontSize:22];
    spnum.position = ccp(105,175);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        spnum.fontSize = 44;
        spnum.position = ccp(90*DevicewidthRatio,165*DeviceheightRatio);
    }

    [table addChild:spnum];
  
    
    
//    CCLabelTTF *best = [CCLabelTTF labelWithString:@"Best" fontName:@"Times" fontSize:18];
//    best.position = ccp(150,170);
//    [self addChild:best];
    NSString *endbeststr = [NSString stringWithFormat:@"%d",[gamedata getendurancebest]];
    NSString *spbeststr = [NSString stringWithFormat:@"%.1f",[gamedata getSprintBest]];
    NSString *membeststr = [NSString stringWithFormat:@"%d",[gamedata getMemorybest]];
    
    CCLabelTTF *endbest = [CCLabelTTF labelWithString:endbeststr fontName:@"Times-Bold" fontSize:22];
    endbest.position = ccp(230,110);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        endbest.fontSize = 44;
        endbest.position = ccp(190*DevicewidthRatio,100*DeviceheightRatio);
    }

    [table addChild:endbest];
    CCLabelTTF *spbest = [CCLabelTTF labelWithString:spbeststr fontName:@"Times-Bold" fontSize:22];
    spbest.position = ccp(230,175);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        spbest.fontSize = 44;
        spbest.position = ccp(190*DevicewidthRatio,165*DeviceheightRatio);
    }
    [table addChild:spbest];
    CCLabelTTF *membest = [CCLabelTTF labelWithString:membeststr fontName:@"Times-Bold" fontSize:22];
    membest.position = ccp(230,236);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        membest.fontSize = 44;
        membest.position = ccp(190*DevicewidthRatio,226*DeviceheightRatio);
    }
    [table addChild:membest];
    
//    CCLabelTTF *average = [CCLabelTTF labelWithString:@"Average" fontName:@"Times" fontSize:18];
//    average.position = ccp(230,170);
//    [self addChild:average];
    NSString *endavgstr = [NSString stringWithFormat:@"%.1f",[gamedata getEnduranceavg]];
    NSString *spavgstr = [NSString stringWithFormat:@"%.1f",[gamedata getSprinteavg]];
    NSString *memavgstr = [NSString stringWithFormat:@"%.1f",[gamedata getMemoryavg]];
    
   /* endavgtf = [[UITextField alloc]initWithFrame:CGRectMake(210, 330, 50, 20)];
    endavgtf.backgroundColor = [UIColor whiteColor];
    endavgtf.returnKeyType = UIReturnKeyDone;
    [endavgtf addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
    endavgtf.text = endavgstr;
    [view addSubview:endavgtf];
    */
    CCLabelTTF *endavg = [CCLabelTTF labelWithString:endavgstr fontName:@"Times-Bold" fontSize:22];
    endavg.position = ccp(290,110);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        endavg.fontSize = 44;
        endavg.position = ccp(240*DevicewidthRatio,100*DeviceheightRatio);
    }

    [table addChild:endavg];
    CCLabelTTF *spavg = [CCLabelTTF labelWithString:spavgstr fontName:@"Times-Bold" fontSize:22];
    spavg.position = ccp(290,175);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        spavg.fontSize = 44;
        spavg.position = ccp(240*DevicewidthRatio,165*DeviceheightRatio);
    }

    [table addChild:spavg];
    
  /*  sprintavgtf = [[UITextField alloc]initWithFrame:CGRectMake(210, 360, 50, 20)];
    sprintavgtf.backgroundColor = [UIColor whiteColor];
    sprintavgtf.returnKeyType = UIReturnKeyDone;
    [sprintavgtf addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
    sprintavgtf.text = spavgstr;
    [view addSubview:sprintavgtf];
    */
    CCLabelTTF *memavg = [CCLabelTTF labelWithString:memavgstr fontName:@"Times-Bold" fontSize:22];
    memavg.position = ccp(290,236);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        memavg.fontSize = 44;
        memavg.position = ccp(240*DevicewidthRatio,226*DeviceheightRatio);
    }

    [table addChild:memavg];
    
  /*  memavgtf = [[UITextField alloc]initWithFrame:CGRectMake(210, 390, 50, 20)];
    memavgtf.backgroundColor = [UIColor whiteColor];
    memavgtf.returnKeyType = UIReturnKeyDone;
    [memavgtf addTarget:self action:@selector(textFieldDone1:) forControlEvents:UIControlEventEditingDidEndOnExit];
    memavgtf.text = memavgstr;
    [view addSubview:memavgtf];
    */
//    CCLabelTTF *last = [CCLabelTTF labelWithString:@"Last" fontName:@"Times" fontSize:18];
//    last.position = ccp(300,170);
//    [self addChild:last];
    NSString *endlaststr = [NSString stringWithFormat:@"%d",[gamedata getEnduranceLast]];
    NSString *splaststr = [NSString stringWithFormat:@"%.1f",[gamedata getSprintlast]];
    NSString *memlaststr = [NSString stringWithFormat:@"%d",[gamedata getMemoryLast]];
    CCLabelTTF *endlast = [CCLabelTTF labelWithString:endlaststr fontName:@"Times-Bold" fontSize:22];
    endlast.position = ccp(165,110);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        endlast.fontSize = 44;
        endlast.position = ccp(140*DevicewidthRatio,100*DeviceheightRatio);
    }
    [table addChild:endlast];
    CCLabelTTF *splast = [CCLabelTTF labelWithString:splaststr fontName:@"Times-Bold" fontSize:22];
    splast.position = ccp(165,175);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        splast.fontSize = 44;
        splast.position = ccp(140*DevicewidthRatio,165*DeviceheightRatio);
    }
    [table addChild:splast];
    CCLabelTTF *memlast = [CCLabelTTF labelWithString:memlaststr fontName:@"Times-Bold" fontSize:22];
    memlast.position = ccp(165,236);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        memlast.fontSize = 44;
        memlast.position = ccp(140*DevicewidthRatio,225*DeviceheightRatio);
    }
    [table addChild:memlast];
    
//    CCLabelTTF *overall = [CCLabelTTF labelWithString:@"Overall" fontName:@"Times" fontSize:18];
//    overall.position=ccp(30,50);
//    [self addChild:overall];
    
    int bestcounter = [gamedata getoverallbest];

    NSString *bestcounterstr = [NSString stringWithFormat:@"%d%%",bestcounter];
    CCLabelTTF  *bestcounterlbl = [CCLabelTTF labelWithString:bestcounterstr fontName:@"Times-Bold" fontSize:22];
    
    bestcounterlbl.position = ccp(235,50);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        bestcounterlbl.fontSize = 44;
        bestcounterlbl.position = ccp(195*DevicewidthRatio,50*DeviceheightRatio);
    }
    [table addChild:bestcounterlbl];
 //   int trycounter = [gamedata getsprinttry]+[gamedata getendurancetry]+[gamedata getmemorytry];
    NSString *trycounterstr = [NSString stringWithFormat:@"%d",[gamedata getoveralltry]];
    CCLabelTTF  *trycounterlbl = [CCLabelTTF labelWithString:trycounterstr fontName:@"Times-Bold" fontSize:22];
    trycounterlbl.position = ccp(110,50);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        trycounterlbl.fontSize = 44;
        trycounterlbl.position = ccp(90*DevicewidthRatio,50*DeviceheightRatio);
    }
    [table addChild:trycounterlbl];

    NSString *avgcounterstr = [NSString stringWithFormat:@"%d%%",(int)[gamedata getoverallavg]];
    CCLabelTTF  *avgcounterlbl = [CCLabelTTF labelWithString:avgcounterstr fontName:@"Times-Bold" fontSize:22];
    avgcounterlbl.position = ccp(295,50);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        avgcounterlbl.fontSize = 44;
        avgcounterlbl.position = ccp(245*DevicewidthRatio,50*DeviceheightRatio);
    }
    [table addChild:avgcounterlbl];
    
  //  float lastcounter = (([gamedata getEnduranceLast]/20.0f)+(1-([gamedata getSprintlast]-20)/40)+([gamedata getMemoryLast]/8.0f))/3.0f;
    NSString *lastcounterstr = [NSString stringWithFormat:@"%d%%",(int)[gamedata getoveralllast]];
    CCLabelTTF  *lastcounterlbl = [CCLabelTTF labelWithString:lastcounterstr fontName:@"Times-Bold" fontSize:22];
     lastcounterlbl.position = ccp(170,50);
    if([[[Utility  getInstance]deviceType]isEqualToString:@"_iPad"]){
        lastcounterlbl.fontSize = 44;
        lastcounterlbl.position = ccp(140*DevicewidthRatio,50*DeviceheightRatio);
    }
   
    [table addChild:lastcounterlbl];
}
- (IBAction)textFieldDone1:(id)sender {
  //  UITextField *tf1 = (UITextField *)sender;
   // if([tf1.text length]>0){
        [sender resignFirstResponder];
  //  }
}
-(void)dealloc{
   
    [super dealloc];
    
}


@end
