//
//  PlayerInfo.m
//  kwest
//
//  Created by Tashnuba Jabbar on 19/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "PlayerInfo.h"
#import "Menu.h"
#import "PlayerStat.h"
#import "Score.h"
#import "KnowledgePathstat.h"
UIView *view;
UITextField *tf;
UILabel *lbl;
UITextView *tv;
UITextView *tv1;
GameData *gamedata;
PlayerStatistics *stat;
@implementation PlayerInfo
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PlayerInfo *layer = [PlayerInfo node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self = [super init]){
 
        gamedata = [GameData GameDataManager];
        stat = [PlayerStatistics StatManager];
//       // [self karmaCalculation];
        Score *sc = [[Score alloc]init];
        [sc karmaCalculation];
        [sc release];
        NSString *playerstr = [gamedata playerName];
        float knop = [gamedata returnknop];
        NSString *knoplbl = [NSString stringWithFormat:@"%f",knop];
        float gold = [gamedata returngold];
        NSString *goldlbl = [NSString stringWithFormat:@"%f",gold];
        NSInteger karma = [gamedata returnkarma];
        NSString *karmalbl = [NSString stringWithFormat:@"%d",karma];
        NSInteger level = [gamedata returnlevel];
        NSString *levellbl = [NSString stringWithFormat:@"%d",level];
        NSInteger energy = [gamedata returnenergy];
        NSString *energylbl = [NSString stringWithFormat:@"%d",energy];
        BOOL keyofenergy = [gamedata returnkeyofenergy];
        NSString *koelbl = [NSString stringWithFormat:@"%d",keyofenergy];
        BOOL keyofstrength = [gamedata returnkeyofstrength];
        NSString *koslbl = [NSString stringWithFormat:@"%d",keyofstrength];
        BOOL keyofwisdom = [gamedata returnkeyofwisdom];
        NSString *kowlbl = [NSString stringWithFormat:@"%d",keyofwisdom];
        BOOL premium = [gamedata returnpremium];
        NSString *prmlbl = [NSString stringWithFormat:@"%d",premium];
        
        NSString *refildate = [gamedata getEndergydate];
        //NSString *refildate = @"2014-2-05";
        //[gamedata setEnergydate:refildate];

        float noofquest = [gamedata getQuestCompleted];
        NSString *noofquestlbl = [NSString stringWithFormat:@"%.2f",noofquest];
        prestored = [[NSMutableArray alloc]init];
        edited = [[NSMutableArray alloc]init];
        lblname = [[NSMutableArray alloc]init];
         lbls = [[NSMutableArray alloc]init];
        [prestored addObject:playerstr];
        [prestored addObject:knoplbl];
        [prestored addObject:goldlbl];
        [prestored addObject:energylbl];
        [prestored addObject:karmalbl];
        [prestored addObject:levellbl];
        [prestored addObject:koelbl];
        [prestored addObject:kowlbl];
        [prestored addObject:koslbl];
        [prestored addObject:prmlbl];
        [prestored addObject:refildate];
        [prestored addObject:noofquestlbl];
//
        [lblname addObject:@"playername"];
        [lblname addObject:@"Knop"];
        [lblname addObject:@"Gold"];
        [lblname addObject:@"Energy"];
        [lblname addObject:@"Karma"];
        [lblname addObject:@"Level"];
        [lblname addObject:@"KeyofEnergy"];
        [lblname addObject:@"KeyofWisdom"];
        [lblname addObject:@"KeyofStrength"];
        [lblname addObject:@"Premium"];
        [lblname addObject:@"RefillDate"];
        [lblname addObject:@"No_of_Quest"];
        
        [self addTextFieldData];
        
        CCMenuItem *backitem = [CCMenuItemFont itemWithString:@"back" target:self selector:@selector(back:)];
        CCMenu *back = [CCMenu menuWithItems:backitem, nil];
        back.position = ccp(30,460);
        [self addChild:back];
        CCMenuItem *playerstat = [CCMenuItemFont itemWithString:@"Player Statistics" target:self selector:@selector(goToPlayerStat:)];
        CCMenu *stat = [CCMenu menuWithItems:playerstat, nil];
        stat.position = ccp(280,460);
        [self addChild:stat];
        CCMenuItem *store = [CCMenuItemFont itemWithString:@"UPDATE" target:self selector:@selector(goToStore:)];
        CCMenu *storemenu = [CCMenu menuWithItems:store,nil];
        storemenu.position = ccp(120,460);
        [self addChild:storemenu];
          }
    return self;
}
-(void)karmaCalculation{
    float k_totalrate;
    int level;
    double noofquestcompleted;
    double temp1;
    double temp2;
    int flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8,flag9;
    level = [gamedata returnlevel];
    noofquestcompleted = [gamedata getQuestCompleted];
    temp1 = (double)((level+1)/2.0f);
    temp2 = (double)((level-3)/2.0f);
    float tmp = temp1-noofquestcompleted ;
    NSLog(@"temp1=%f temp2=%f",tmp,temp2);
    
    int correctsum = [stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord];
    int trysum = [stat getScienceTryRecord]+[stat getLogicTryRecord]+[stat getHumanitiesTryRecord]+[stat getDeeperTryRecord];
    
    if(trysum!=0)
        k_totalrate = ((float)correctsum/(float)trysum)*100;
    else 
        k_totalrate=0;
    float l_totalavg = (([gamedata getEnduranceavg]/30.0f+(1-(([gamedata getSprinteavg]-20)/40))+[gamedata getMemoryavg]/8.0f)/3.0f)*100;
    
    if(k_totalrate>=75)
        flag1 = 1;
    else 
        flag1=0;
    
    if(l_totalavg>=75)
        flag2=1;
    else 
        flag2 =0;
    
    if(level>=5)
        flag3=1;
    else
        flag3=0;
    
    if(temp1<=noofquestcompleted)
        flag4=1;
    else
        flag4=0;
    
    if(temp1<noofquestcompleted)
        flag5=1;
    else
        flag5=0;
    if(k_totalrate<50)
        flag6=1;
    else
        flag6 =0; 
    if(l_totalavg<50)
        flag7=1;
    else 
        flag7=0;
    
    if(temp2>=(float)noofquestcompleted)
        flag8=1;
    else 
        flag8 = 0;
    if(temp2>(float)noofquestcompleted)
        flag9=1;
    else
        flag9=0;
    int karma=5+((flag1+flag2+flag3+flag4+flag5)-(flag6+flag7+flag8+flag9));
    NSLog(@"flag1=%d,flag2=%d,flag3=%d,flag4=%d,flag5=%d,flag6=%d,flag7=%d,flag8=%d,flag9=%d quest=%f",flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8,flag9,noofquestcompleted);
    [gamedata setKarma:karma];
}

-(void)addTextFieldData{
    float val=0;
    float val1=0;
    view = [[CCDirector sharedDirector] view];
    tv = [[UITextView alloc]initWithFrame:CGRectMake(150, 50, 200, 20)];
    tv.userInteractionEnabled = NO;
    tv.text = [prestored objectAtIndex:0];
    [view addSubview:tv];
  /*  tv1 = [[UITextView alloc]initWithFrame:CGRectMake(150, 380, 200, 20)];
    tv1.userInteractionEnabled = NO;
    tv1.text = [prestored objectAtIndex:10];
    [view addSubview:tv1];*/
    for(int j=0;j<12;j++){
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 35+val1, 100, 40)];
        lbl.backgroundColor = [UIColor blackColor];
        lbl.text = [lblname objectAtIndex:j];
        lbl.textColor = [UIColor whiteColor];
        [lbls addObject:lbl];
        [view addSubview:lbl];
        val1+=33;
    }
    for(int i=1;i<=11;i++){
        
        tf = [[UITextField alloc]initWithFrame:CGRectMake(150, 90+val, 200, 20)];
        tf.backgroundColor = [UIColor whiteColor];
        tf.text =[prestored objectAtIndex:i];
        tf.clearsOnBeginEditing = true;

        tf.userInteractionEnabled = YES;
        tf.tag = i;
        tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        tf.returnKeyType = UIReturnKeyDone;
        [tf addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];  
        val+=32;
        [edited addObject:tf];
        [view addSubview:tf];
    }

}
- (IBAction)textFieldDone:(id)sender {
    UITextField *tf1 = (UITextField *)sender;
    if([tf1.text length]>0){
        if(tf1.tag==1){
            float f = [tf1.text floatValue];
            [[GameData GameDataManager]setknop:f];
            Score *sc = [[Score alloc]init];
            [sc setLevel:f];
          //  [self karmaCalculation];
        }
        else if(tf1.tag==2){
            float f = [tf1.text floatValue];
            [[GameData GameDataManager]setgold:f];
        }
        else if(tf1.tag==3){
            NSInteger i = [tf1.text integerValue];
            [[GameData GameDataManager]setEnergy:i];
        }
        else if(tf1.tag==4){
            NSInteger i = [tf1.text integerValue];
            [[GameData GameDataManager]setKarma:i];

        }
        else if(tf1.tag==5){
            NSInteger i = [tf1.text integerValue];
            [[GameData GameDataManager]setLevel:i];
         //   [self karmaCalculation];
        }
        else if(tf1.tag==6){
            BOOL b =[tf1.text boolValue];
            [[GameData GameDataManager]setkeyofenergy:b];
        }
        else if(tf1.tag==7){
            BOOL b =[tf1.text boolValue];
            [[GameData GameDataManager]setkeyofwisdom:b];
        }
        else if(tf1.tag==8){
            BOOL b =[tf1.text boolValue];
            [[GameData GameDataManager]setkeyofstrength:b];
        }
        else if(tf1.tag==9){
            BOOL b =[tf1.text boolValue];
            [[GameData GameDataManager]setpremium:b];
        }
        else if(tf1.tag==11){
            float q = [tf1.text floatValue];
            [gamedata setQuestCompleted:q];
        }
        [sender resignFirstResponder];
    }
}

-(void)removeUI{
    for(int j=0;j<11;j++){
        UILabel *lblss = [lbls objectAtIndex:j];
        [lblss removeFromSuperview];
     //   [lblss release];
    }
    for(int i=0;i<11;i++){
        UITextField *tt = [edited objectAtIndex:i];
        [tt removeFromSuperview];
       // [tt release];
    }
    [lbl removeFromSuperview];
    [tv removeFromSuperview];
    [tv1 removeFromSuperview];
    
   
    
}
-(void)goToPlayerStat:(id)sender{
    [self removeUI];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[KnowledgePathstat scene]]];
    
}


-(void)back:(id)sender{
    [self removeUI];
 
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[Menu scene]]];
}

-(void)goToStore:(id)sender{
    [self removeUI];
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[PlayerInfo scene]]];

}

-(void)dealloc{
    /*[tv release];
     [tv1 release];
     [tf release];
     [lbl release];
    [edited release];*/
    [lbls release];
    [prestored release]; 
    [lblname release];
    [super dealloc];
  
}

@end
