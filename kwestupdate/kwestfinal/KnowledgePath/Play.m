//
//  Play.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright 2012 AITL. All rights reserved.
//

#import "MissionVIew.h"
//#import "CCUIViewWrapper.h"
#import "PlayerStatistics.h"

#import "Play.h"
#import "QusList.h"
#import "Myquslist.h"
#import "BasePopUpView.h"
#import "Beyond.h"
#import "OptionView.h"
#import "Utility.h"
#import <RevMobAds/RevMobAds.h>
#import "Chartboost.h"
#import "BrainArenaMenu.h"
#import "GameData.h"
#import "Score.h"
#define noEnergyPremium 2
#define noEnergyBasic   3

GameData *gamedata;
CCLabelTTF *selectionlabel;

CCSprite *bg ;
@implementation Play
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Play *layer = [Play node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"K-Path Tried"];
        gamedata = [GameData GameDataManager];
      //  [self performSelector:@selector(knowledgepath:) withObject:Nil afterDelay:0.2];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"] && gamedata.isTutorialShown == FALSE){
            
                [self createTutorialBaseView];
                [self showKnowledgePathMainText];
        }
        else{
            [self startKnoledgePath];
        }
    }
    return self;
}
-(void)createTutorialBaseView{
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *moreButtonImage = [UIImage imageNamed:@"More"];
    tutorialView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.backgroundColor = [UIColor blackColor];
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+30, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }

    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.23, moreButtonImage.size.width, moreButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        moreButton.frame = CGRectMake(DeviceWidth/1.45, DeviceHeight/1.18, moreButtonImage.size.width, moreButtonImage.size.height);
    }
    [moreButton setBackgroundImage:moreButtonImage forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showKnowledgePathMoreText) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:moreButton];
}

-(void)showMainView{
    [tutorialView removeFromSuperview];
    gamedata.isTutorialShown = TRUE;
    [self startKnoledgePath];
}

-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}
-(void)showKnowledgePathMoreText{
    [self clearTutorialView];
    [moreButton removeFromSuperview];
    UIImage *sprintTextImage = [UIImage imageNamed:@"KnowledgePath-II-txt"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);
    }
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/4);
    [scrollView addSubview:sprintTextImageView];
    [sprintTextImageView release];
    
    [tutorialBackgroundImageView addSubview:scrollView];
    [scrollView release];
   
}

-(void)showKnowledgePathMainText{
    UIImage *sprintTextImage = [UIImage imageNamed:@"KnowledgePath-I-txt"];
    //    UIImage *attributeButtonImage = [UIImage imageNamed:@"Attributes"];
    //    UIImage *statisticsButtonImage = [UIImage imageNamed:@"Statistics"];
    //    UIImage *boostButtonImage = [UIImage imageNamed:@"Boosts"];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        scrollView.frame = CGRectMake(DeviceWidth/16, DeviceHeight/16, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);

    }
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height);
    [scrollView addSubview:sprintTextImageView];
     
    [tutorialBackgroundImageView addSubview:scrollView];
    [sprintTextImageView release];
    [scrollView release];
 }


-(void)startKnoledgePath{
    [self createBackgroundView];
    isDifficulty = false;
    isType = false;
    isEnergygainorloss=false;
    is4complete = false;
    qusIndex = [[NSMutableArray alloc]init];
    
    karma = [gamedata returnkarma];
    level = [gamedata returnlevel];
    for(int i=0 ; i<[gamedata.qus count];i++){
        NSNumber *num = [NSNumber numberWithInt:i];
        [qusIndex addObject:num];
    }
    [self bonusEnergy];
    if(!isEnergygainorloss)
        [self showKnowledgePathSelectionOption];
}

-(void)createBackgroundView{
    knowledgePathBg = [CCSprite spriteWithFile:@"KnowledgePathBackground.png"];
    knowledgePathBg.anchorPoint = ccp(0.5,0.5);
    knowledgePathBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:knowledgePathBg];
}

-(void)showKnowledgePathSelectionOption{
    bool check= [self selection];
    if(check){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"]){
            [[SimpleAudioEngine sharedEngine]playEffect:@"Bonus.mp3"];
        }
        NSString *selectiontext=@"";
        if (isType) {
            float ansypos = 200*DeviceheightRatio;
            if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                ansypos = 210*DeviceheightRatio;
            }
            for (int i=0; i<4; i++) {
                CCMenuItemImage *abtn = [CCMenuItemImage itemWithNormalImage:@"Option.png" selectedImage: @"Option.png"
                                                                      target:self selector:@selector(typeselected:)];
                abtn.tag=i+1;
                // abtn.position = ccp(160,ansypos);
//                
                NSString *optstr;
                switch (i) {
                    case 0:
                        optstr = @"Science";
                        break;
                    case 1:
                        optstr = @"Logic & Maths";
                        break;
                    case 2:
                        optstr = @"Humanities";
                        break;
                    case 3:
                        optstr = @"Deeper";
                        break;
                    default:
                        break;
                }
                typeSelectionMenuLabel [i] = [CCLabelTTF labelWithString:optstr fontName:@"Times-Bold" fontSize:18];
                typeSelectionMenu[i] = [CCMenu menuWithItems:abtn, nil];
                typeSelectionMenu[i].position = ccp(160*DevicewidthRatio,ansypos+8);
                typeSelectionMenuLabel[i].position =  ccp(160*DevicewidthRatio,ansypos+12);
                if([[[Utility getInstance]deviceType]isEqualToString:iPhone5]){
                    ///typeSelectionMenuLabel[i].fontSize = 36;
                    typeSelectionMenuLabel[i].position =  ccp(160*DevicewidthRatio,ansypos+13);
                }
                if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                    typeSelectionMenuLabel[i].fontSize = 36;
                    typeSelectionMenuLabel[i].position =  ccp(160*DevicewidthRatio,ansypos+20);
                }
                typeSelectionMenuLabel[i].color = ccBLACK;
                [self addChild:typeSelectionMenu[i]];
                [self addChild:typeSelectionMenuLabel[i]];
                
                
                ansypos-=50*DeviceheightRatio;
            }
           
            
            selectiontext = @"Karma let's you select the type of your next question : ";
        }
        else if(isDifficulty){
            float ansypos = 200*DeviceheightRatio;
            for (int i=0; i<3; i++) {
                CCMenuItemImage *abtn = [CCMenuItemImage itemWithNormalImage:@"Option.png" selectedImage: @"Option.png"
                                                                      target:self selector:@selector(typeselected:)];
                abtn.tag=i+1;
                // abtn.position = ccp(160,ansypos);
                
                NSString *optstr;
                switch (i) {
                    case 0:
                        optstr = @"Easy";
                        break;
                    case 1:
                        optstr = @"Medium";
                        break;
                    case 2:
                        optstr = @"Hard";
                        break;
                    default:
                        break;
                }
                difficultySelectionMenuLabel [i] = [CCLabelTTF labelWithString:optstr fontName:@"Times-Bold" fontSize:18];
                if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                    difficultySelectionMenuLabel[i].fontSize = 36;
                }
                difficultySelectionMenu[i] = [CCMenu menuWithItems:abtn, nil];
                difficultySelectionMenu[i].position = ccp(160*DevicewidthRatio,ansypos+4);
                difficultySelectionMenuLabel[i].position =  ccp(160*DevicewidthRatio,ansypos+8);
                difficultySelectionMenuLabel[i].color = ccBLACK;
                [self addChild:difficultySelectionMenu[i]];
                [self addChild:difficultySelectionMenuLabel[i]];
                
                
                ansypos-=50*DeviceheightRatio;

            }

            selectiontext = @"High Karma Enables you to select the difficulty of your next question";
        }
        
//        CCLabelTTF *quslbl = [CCLabelTTF labelWithString:qus dimensions:CGSizeMake(300, 200) alignment:UITextAlignmentCenter fontName:@"Times" fontSize:22
//                              ];
//        quslbl.position = ccp(160,300);
//        [self addChild:quslbl];
        selectionlabel = [CCLabelTTF labelWithString:selectiontext fontName:@"Times-Bold" fontSize:22];
        selectionlabel.dimensions = CGSizeMake(280*DevicewidthRatio, 220*DeviceheightRatio);
        selectionlabel.horizontalAlignment = kCCTextAlignmentLeft;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            selectionlabel.fontSize = 44;
           // selectionlabel.dimensions = CGSizeMake(450, 300);

        }
        selectionlabel.position = ccp(170*DevicewidthRatio,300*DeviceheightRatio);
        selectionlabel.color = ccBLACK;
        [self addChild:selectionlabel];
        
        
               

    }
    else
        [self knowledgepathType:0 Difficulty:0  Level:level];
}


-(void)typeselected:(id)sender{
    CCMenuItem *rm = (CCMenuItemImage*)sender;
   // NSLog(@"tag=%d",rm.tag);
    [self removeChild:selectionlabel cleanup:YES];
    if(isDifficulty){
        for(int i=0;i<3;i++){
            [self removeChild:difficultySelectionMenu[i] cleanup:YES];
            [self removeChild:difficultySelectionMenuLabel[i] cleanup:YES];
        }
        

        [self knowledgepathType:0 Difficulty:rm.tag Level:level];
    }
    else if(isType){
        for(int i=0;i<4;i++){
            [self removeChild:typeSelectionMenuLabel[i] cleanup:YES];
            [self removeChild:typeSelectionMenu[i] cleanup:YES];
        }

        [self knowledgepathType:rm.tag Difficulty:0 Level:level];
    }
 
}

-(BOOL)selection{
    BOOL b = false;
    int r = 1+arc4random()%110;
    if(r<karma*5){
        isType = true;
        b = true;
    }
    else {
        int r1 = 1+arc4random()%110;
        if(r1<(karma)*3){
            isDifficulty = true;
            b=true;
        }
    }
    return b;
}

-(void)knowledgepathType:(int)t Difficulty:(int)d Level:(int)l{
    ec = [[EnergyCalculation alloc]init];
    isCorrect   = false;
    energy = [ec calculateKnowledgePathEnergy];
    // [ec release];
    if(energy<0){
        [Flurry logEvent:@"No Energy"];
        if([gamedata returnpremium]){
            if(![gamedata returnkeyofenergy]){
            UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"You don't have enough Energy. If you get the Key of Energy your base daily Energy will become 125, All questions will consume less of your Energy, and you will unlock the magic Well. Do you want to Unlock the Key of Energy?" delegate:self cancelButtonTitle:@"Why?" otherButtonTitles: @"Yes, Sure!",@"No, Thanks",nil];
            noEnergyAlert.tag = noEnergyPremium;
            [noEnergyAlert show];
            [noEnergyAlert release];
            }
            else if ([gamedata returnkeyofenergy]){
                UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"Sorry! You don't have any more Energy. You can wait till tomorrow, or Use the Well of Energy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 noEnergyAlert.tag = noEnergyBasic;
                [noEnergyAlert show];
                [noEnergyAlert release];
            }
 
        }
        else if (![ gamedata returnpremium]){
            UIAlertView *noEnergyAlert = [[UIAlertView alloc]initWithTitle:@"Energy Low" message:@"You don't have enough Energy. In Premium mode you will receive a much higher daily Energy. Do you want to Upgrade to Premium?" delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles: @"Yes, Sure!",@"Why?",nil];
            noEnergyAlert.tag = noEnergyBasic;
            [noEnergyAlert show];
            [noEnergyAlert release];
        }
               
        
    }
    else if(energy>=0){
        NSString *typestr = @"";
        float ansypos = 170*DeviceheightRatio;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            ansypos = 220*DeviceheightRatio;
        }
        [gamedata setEnergy:[ec calculateKnowledgePathEnergy]]; 
        stat = [PlayerStatistics StatManager];
        
        isClicked = false;
        //Choose Difficulty
        int qusindex = [self getQusIndex:d :t :l];
        
        optArray = [[NSMutableArray alloc]init];
      //  NSInteger index = [[GameData GameDataManager]getQusindex:n]; 
        qus = [[GameData GameDataManager]getQus:qusindex];
        opt1 = [[GameData GameDataManager]getOpt1:qusindex];
        opt2 = [[GameData GameDataManager]getOpt2:qusindex];
        opt3 = [[GameData GameDataManager]getOpt3:qusindex];
        opt4 = [[GameData GameDataManager]getOpt4:qusindex];
        int qid = [[GameData GameDataManager]getID:qusindex];
        
        [optArray addObject:opt1];
        [optArray addObject:opt2];
        [optArray addObject:opt3];
        [optArray addObject:opt4];
        correct = [[GameData GameDataManager]getRightTag:qusindex];
        type = [[GameData GameDataManager]getType:qusindex];
        NSString *subtype = [[GameData GameDataManager]getSubtype:qusindex];
        
        int questiondifficulty = [[GameData GameDataManager]getDifficulty:qusindex];
        NSString *difficultystr = @"";
        switch (questiondifficulty) {
            case 1:
                difficultystr = @"Easy";
                break;
            case 2:
                difficultystr = @"Medium";
                break;
            case 3:
                difficultystr =@"Hard";
                break;
            default:
                break;
        }
       // NSString *difficultystr = [NSString stringWithFormat:@"D-%d",questiondifficulty];
        switch (type) {
            case 1:
                typestr = @"The World & Science";
                break;
            case 2:
                typestr = @"Logic & Maths";
                break;
            case 3:
                typestr = @"Human Eyes";
                break;
            case 4:
                typestr = @"Deeper Thoughts";
                break;
            default:
                break;
        }
        NSLog(@"qid=%d",qid);
        NSLog(@"correct=%d",correct);
        if(type==1){
            qustry = [stat getScienceTryRecord];
            quscorrect = [stat getScienceCorrectRecord];
            qustry++;
            [stat setScienceTryRecord:qustry];
        }
        else if(type==2){
            qustry = [stat getLogicTryRecord];
            quscorrect = [stat getLogicCorrectRecord];
            qustry++;
            [stat setLogicTryRecord:qustry];
        }
        else if(type==3){
            qustry = [stat getHumanitiesTryRecord];
            quscorrect = [stat getHumanitiesCorrectRecord];
            qustry++;
            [stat setHumanitiesTryRecord:qustry];
        }
        else if(type==4){
            qustry = [stat getDeeperTryRecord];
            quscorrect = [stat  getHumanitiesCorrectRecord];
            qustry++;
            [stat setDeeperTryRecord:qustry];
        }
     /*   [optArray addObject:opt1];
        [optArray addObject:opt2];
        [optArray addObject:opt3];
        [optArray addObject:opt4];
        */
        rightanswerstr  = [optArray objectAtIndex:correct-1];
       // [optArray release];
        
        NSString *energystr = [NSString stringWithFormat:@"ENERGY:%d",[gamedata returnenergy]];
        CCLabelTTF *energylbl = [CCLabelTTF labelWithString:energystr fontName:@"Times" fontSize:12];
        energylbl.position = ccp(63*DevicewidthRatio,450*DeviceheightRatio);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            energylbl.fontSize = 24;
        }
        [self addChild:energylbl];
        
        NSString *consequtiveansstr = [NSString stringWithFormat:@"%d/4", gamedata.knowledgepath4counter];
        CCLabelTTF *consequtiveanslbl = [CCLabelTTF labelWithString:consequtiveansstr fontName:@"Times" fontSize:16];
        consequtiveanslbl.position = ccp(260*DevicewidthRatio,450*DeviceheightRatio);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            consequtiveanslbl.fontSize = 32;
        }
        [knowledgePathBg addChild:consequtiveanslbl];
        
        CCLabelTTF *difficultylbl = [CCLabelTTF labelWithString:difficultystr fontName:@"Times" fontSize:15];
        difficultylbl.position = ccp(255*DevicewidthRatio,15*DeviceheightRatio);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            difficultylbl.fontSize = 30;
        }
        [knowledgePathBg addChild:difficultylbl];
        subtype = [NSString stringWithFormat:@"%@/%@",typestr,subtype];
        /*CCLabelTTF *typelbl = [CCLabelTTF labelWithString:typestr fontName:@"Times" fontSize:14];
        typelbl.position = ccp(50,60);
        [self addChild:typelbl];
        */
        CCLabelTTF *subtypelbl = [CCLabelTTF labelWithString:subtype fontName:@"Times" fontSize:14];
        subtypelbl.position = ccp(115*DevicewidthRatio,15*DeviceheightRatio);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            subtypelbl.fontSize = 28;
        }
        [knowledgePathBg addChild:subtypelbl];
      //  NSLog(@"correct%d",correct);
        //show question
       // qus = [NSString stringWithFormat:@"%d%@",type,qus];
        CGFloat fontSizes  = 22;
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            fontSizes = 44;
        }
        UIFont * font = [UIFont fontWithName:@"Times" size:fontSizes];
        CGSize realSize; 
        realSize = [qus sizeWithFont:font constrainedToSize:CGSizeMake(300*DevicewidthRatio, 180*DeviceheightRatio) lineBreakMode:NSLineBreakByWordWrapping];
        
        int fontSize ;
        float qusYPos;
        if(realSize.height>=150){
            fontSize = 20;
            qusYPos =320;
        }
        
        else if(realSize.height<150){
            fontSize = 22;
            qusYPos = 350;
        }
        CCLabelTTF *quslbl = [CCLabelTTF labelWithString:qus fontName:@"Times" fontSize:fontSizes dimensions:realSize hAlignment:kCCTextAlignmentCenter  lineBreakMode:kCCLineBreakModeWordWrap];
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            quslbl.fontSize = fontSize*2;
        }
        quslbl.position = ccp(160*DevicewidthRatio,qusYPos*DeviceheightRatio);
        [self addChild:quslbl];
        
        //show options
       for (int i=0; i<4; i++) {
            CCMenuItemImage *abtn = [CCMenuItemImage itemWithNormalImage:@"Option.png" selectedImage: @"Option.png"
                                                            target:self selector:@selector(checkAnswer:)];
            abtn.tag=i+1;
           // abtn.position = ccp(160,ansypos);
            
           NSString *optstr = [optArray objectAtIndex:i];
           CCLabelTTF *albl = [CCLabelTTF labelWithString:optstr fontName:@"Times" fontSize:18 dimensions:CGSizeMake(250, 90) hAlignment:kCCTextAlignmentCenter  lineBreakMode:kCCLineBreakModeWordWrap];
//           CCLabelTTF *albl = [CCLabelTTF labelWithString:optstr dimensions:CGSizeMake(250, 90) alignment:UITextAlignmentCenter fontName:@"Times" fontSize:18];
           ansButton[i] = [CCMenu menuWithItems:abtn, nil];
           albl.color = ccc3(50, 50, 50);
           albl.position = ccp(160*DevicewidthRatio,ansypos+5);
           ansButton[i].position =  ccp(160*DevicewidthRatio,ansypos+35);
           if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
               albl.fontSize = 36;
               albl.dimensions = CGSizeMake(400, 180);
               albl.position = ccp(160*DevicewidthRatio,ansypos-58);
               ansButton[i].position =  ccp(160*DevicewidthRatio,ansypos);
           }
          
            [self addChild:ansButton[i]];
           [self addChild:albl];
           

             ansypos-=50*DeviceheightRatio;
        }
     
       /* CCMenuItemImage *optmenu1= [CCMenuItemFont itemFromString:opt1 target:self selector:@selector(checkAnswer:)];
        optmenu1.tag = 1;
        CCMenuItemImage *optmenu2= [CCMenuItemFont itemFromString:opt2 target:self selector:@selector(checkAnswer:)];
        optmenu2.tag = 2;
        CCMenuItemImage *optmenu3= [CCMenuItemFont itemFromString:opt3 target:self selector:@selector(checkAnswer:)];
        optmenu3.tag = 3;
        CCMenuItemImage *optmenu4= [CCMenuItemFont itemFromString:opt4 target:self selector:@selector(checkAnswer:)];
        optmenu4.tag = 4;
        
        CCMenu *optionmenu = [CCMenu menuWithItems:optmenu1,optmenu2,optmenu3,optmenu4, nil];
        [optionmenu alignItemsVerticallyWithPadding:20];
        optionmenu.position = ccp(160,200);
        [self addChild:optionmenu];
   
        */
        
        counter=25;
        counterlbl =[CCLabelTTF labelWithString:@"25" fontName:@"Times" fontSize:20];
        counterlbl.position = ccp(161.5*DevicewidthRatio,440*DeviceheightRatio);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            counterlbl.fontSize = 40;
        }
        [knowledgePathBg addChild:counterlbl];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
            countDownEffect = [[SimpleAudioEngine sharedEngine]playEffect:@"CountDown.mp3"];
        
        [self schedule:@selector(countdown:) interval:1];
    }

}

-(void)checkAnswer:(id)sender{
     [self stopCountDownSound];
    if(!isClicked){
    CCMenuItem *btn = (CCMenuItemImage*)sender;
        if(btn.tag == correct){
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
                writeAnswerEffect = [[SimpleAudioEngine sharedEngine]playEffect:@"CorrectAns.mp3"];
            
            isCorrect = true;
            gamedata.testcounter++;
            
            //NSLog(@"The Counter is %i , and the Mission Flag is %i",gamedata.testcounter,[[[Myquslist alloc]init] getMissionFlag:1]);
           
            // Explaining about scoring
            
            
        }
        else{
            isCorrect = false;
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
                wrongAnswerEffect = [[SimpleAudioEngine  sharedEngine]playEffect:@"WrongAns.mp3"];
            
        }
        Score *sc = [[Score alloc]init];
        [sc KnowledgepathScore:type :isCorrect];
        isClicked = true;
       
     //   home.visible = true;
       // nextqus.visible = true;
        [self unschedule:@selector(countdown:)];
        [self showScoreLayer];
        
        
    }
}

-(void)bonusEnergy{
    int e;
    NSString *str;
    e= [gamedata returnenergy];
    int r = arc4random()%99+1;
    // Player of Level 0,1,2 gets more energy bonus
    if ( r<(karma-1)*5*(4-[gamedata returnlevel]) && [gamedata returnlevel]<=2 && e<35) {
        isEnergygainorloss=true;
        //   Note : Replace Player_Level by the correct name
        e = e+5;
        str = @"Beginner’s Karma gives you Five extra energy points..";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 0;
        [alert show];
        [alert release];
    }
    
    else if(r<karma*5 && karma>=6){
        isEnergygainorloss=true;
        //   NSLog(@"ads");
        e = e+2;
        str = @"High karma gives you two extra energy points..";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 0;
        [alert show];
        [alert release];
    }
    else if(r<(12*(5-karma)) && karma<5 && [[GameData GameDataManager] returnknop]>10){
        isEnergygainorloss=true;
        //    NSLog(@"ads2");
        e = e-2;
        str = @"Low Karma drains two extra Energy points ..";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
        [alert release];
    }
    [gamedata setEnergy:e];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tagValue = alertView.tag;
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if(tagValue == 0 || tagValue == 1){
        if (buttonIndex == 0){
            [self showKnowledgePathSelectionOption];
        }
    }
    else if (tagValue ==noEnergyPremium){
        if (buttonIndex == 2){
            [self back];
        }
        else if (buttonIndex ==1){
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Beyond scene]]];
        }
        else if (buttonIndex == 0){
            [self createEnergyText];
        }

    }
    
    else if (tagValue ==noEnergyBasic){
        if (buttonIndex == 0){
            [self back];
        }
        else if (buttonIndex ==1){
            [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[OptionView scene]]];
        }
        else if (buttonIndex == 2){
            [self showReasonsForPremium];
        }
        
    }

}

-(void)back{
    gamedata.knowledgepath4counter=0;
    
    [[GameData GameDataManager]clearData];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)showScoreLayer{
    
   

    if(![gamedata returnpremium]){
        [self showAd];
    }
    [self removeAllChildrenWithCleanup:YES];
    bg= [CCSprite spriteWithFile:@"scorebg.png"];
    bg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:bg];
    if (isCorrect){
        int fontSize = 20;
        gamedata.knowledgepath4counter++;
        if(gamedata.knowledgepath4counter==4){
            float k=0;
            float g=0;
            int e=0;
            is4complete = true;
            NSString *giftstr = @"For Successfully answering 4 consecutive Questions, You will receive a Basic Bonus of: 2 KNOPs.";
            k=2;
            
          //  bool getGift = false;
            int p_extra_gift =arc4random()%100+1;
            int p_type =arc4random()%100+1;
            int p_beginner =arc4random()%100+1;
            
            //  Beginners receive higher chance of Energy bonus
            if (p_beginner< karma*6*(4-[gamedata returnlevel]) && [gamedata returnlevel]<=2)
            {
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
                    bonusEffect = [[SimpleAudioEngine sharedEngine]playEffect:@"Bonus.mp3"];
                
                e=7;
                giftstr = [NSString stringWithFormat:@"%@ You will also recieve an extra Beginner’s bonus of %i Energy.",giftstr,e];
                fontSize = 18;
                
                
                
            }
            
            else if(p_extra_gift<17+5*karma){
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
                    bonusEffect = [[SimpleAudioEngine sharedEngine]playEffect:@"Bonus.mp3"];
                
                
                // getGift = true;
                if(p_type<30){
                    // NSLog(@"gift karma");
                    k +=(2+ceilf(karma/10.0f));
                    giftstr = [NSString stringWithFormat:@"%@ You will also receive an extra bonus %g KNOPs.",giftstr,k-2];
                    fontSize = 18;
                }
                else if(p_type<60){
                    g=(2+ceilf(karma/10.0f));
                    NSLog(@"gift gold");
                    giftstr = [NSString stringWithFormat:@"%@ You will  also receive an extra bonus %g Gold.",giftstr,g];
                    fontSize = 18;
                }
                else{
                    e=(2+ceilf(karma/10.0f));
                    giftstr = [NSString stringWithFormat:@"%@ You will also recieve an extra bonus of %d Energy.",giftstr,e];
                    fontSize = 18;
                }
            }
            //else
               // getGift = false;
            [gamedata setknop:[gamedata returnknop]+k];
            [gamedata setgold:[gamedata returngold]+g];
            [gamedata setEnergy:[gamedata returnenergy]+e];
            [[[Score alloc]init] setLevel:[[GameData GameDataManager] returnknop]];
            //giftstr = [NSString stringWithFormat:@"%.2f knop %.2f gold %d energy",k,g,e];
            CCLabelTTF *con4 = [CCLabelTTF labelWithString:giftstr fontName:@"Times" fontSize:fontSize dimensions:CGSizeMake(200, 200) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeWordWrap];
            con4.position = ccp(160,120);
            if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                con4.fontSize = fontSize*2;
                con4.dimensions = CGSizeMake(400, 400);
                con4.position = ccp(140*DevicewidthRatio,100*DeviceheightRatio);
            }
            con4.color = ccBLACK;
            [bg addChild:con4];
            CCMenuItem *ok = [CCMenuItemImage itemWithNormalImage:@"ok_btn.png" selectedImage:@"ok_btn.png" target:self selector:@selector(okBtnPressed:)];
            CCMenu *okmenu = [CCMenu menuWithItems:ok, nil];
            okmenu.position = ccp(140,50);
            if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
                okmenu.position = ccp(120*DevicewidthRatio,40*DeviceheightRatio);
            }
            [bg addChild:okmenu];
  
        }
        else{
            [self showCorrectText];
        }
    }
    else {
        gamedata.knowledgepath4counter=0;
        CCLabelTTF *headerLbl = [CCLabelTTF labelWithString:@"That wasn't correct" fontName:@"Times-Bold" fontSize:24];
        headerLbl.position = ccp(150,200);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            headerLbl.position = ccp(130*DevicewidthRatio,200*DeviceheightRatio);
            headerLbl.fontSize = 48;
        }
        headerLbl.color = ccRED;
        [bg addChild:headerLbl];
        NSString *str = [NSString stringWithFormat:@"%@",rightanswerstr];
        CCLabelTTF *subHeaderLbl = [CCLabelTTF labelWithString:@"The Correct answer is :" fontName:@"Times-Bold" fontSize:20];
        subHeaderLbl.position = ccp(150,170);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            subHeaderLbl.position = ccp(130*DevicewidthRatio,150*DeviceheightRatio);
            subHeaderLbl.fontSize = 48;
        }
        subHeaderLbl.color = ccBLACK;
        [bg addChild:subHeaderLbl];
        CCLabelTTF *con4 = [CCLabelTTF labelWithString:str fontName:@"Times-Bold" fontSize:20];
        con4.position = ccp(150,140);
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            con4.position = ccp(130*DevicewidthRatio,120*DeviceheightRatio);
            con4.fontSize = 48;
        }
        con4.color = ccBLACK;
        [bg addChild:con4];
        CCMenuItem *homeitem = [CCMenuItemImage itemWithNormalImage:@"homebtn.png" selectedImage:@"homebtn.png" target:self selector:@selector(backToHome:)];
        CCMenu *back = [CCMenu menuWithItems:homeitem, nil];
        back.position = ccp(140,70
                            );
        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
            back.position = ccp(120*DevicewidthRatio,60*DeviceheightRatio);
            
        }
        [bg addChild:back];
    }
//    id fadeIn = [CCFadeIn actionWithDuration:0.1];
//    id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
//    id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
//    id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
//    id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
//    [bg runAction:pulse];
    NSLog (@"The Correct Count Is: %i",[[PlayerStatistics StatManager] getTotalCorrectRecord]);
    if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==1 && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow1K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have successfully answered a Knowledge Path Question. You have spent 3 Energy Points, and Gained 3 KNOPs and 2 Gold. \n Hint: Get 4 Correct answers in a row for an Extra Bonus. The Next Button will take you to the next question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow1K"];
        BMAlert.tag = 25;
        [BMAlert show];
        [BMAlert release];
    }
    
    
    
    // Explaining about scoring
   
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==2 && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow2K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have successfully answered your second Knowledge Path Question. Remember that you can see detailed stats about your performance in the Knowledge Statistics Page (Through Profile). Can you build the Second level of the Tower of Wisdom?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow2K"];
        BMAlert.tag = 35;
        [BMAlert show];
        [BMAlert release];
    }
    
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==4 && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow4K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Beginner's Luck" message:@"The Knowledge Path will give you Energy gifts, and especially when you're still new here. Walk the Knowledge Path and keep your Ratings High to maximize your Energy Gifts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 75;
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow4K"];
        [BMAlert show];
        [BMAlert release];
    }
    
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==10 && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow10K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have successfully answered 10 Knowledge Path Questions. Remember: Higher Karma will make everything easier (and rosier). To raise Karma, Solve your Quests, and Keep High Ratings here and in Brain Arena (always check Statistics). " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 35;
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow10K"];
        [BMAlert show];
        [BMAlert release];
    }
    
    
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==50 && ![[GameData GameDataManager] returnpremium] && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow50K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Excellent !" message:@"You have successfully answered 50 Knowledge Path Questions. \nHint: Upgrading to Premium will increase your daily Energy significantly, allow you to buy Keys, and remove the cap on your progress. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 45;
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow50K"];
        [BMAlert show];
        [BMAlert release];
    }
    
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==100 && [[GameData GameDataManager] returnpremium] && (![[GameData GameDataManager] returnkeyofenergy] || ![[GameData GameDataManager] returnkeyofwisdom])&& [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow100K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Excellent !" message:@"You have successfully answered 100 Knowledge Path Questions. How many days will it take you to Build up the whole Tower? (Check your counters by tapping the Tower's Indicator) \nRemember: The Key of Energy increases your daily Energy significantly, reduces the Energy cost of everything, and Unlocks the Well. The Key of Wisdom increases your Knowledge Path gains, reduces its cost, and Unlocks the Tree of Knowledge." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 55;
        [BMAlert show];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow100K"];
        [BMAlert release];
    }
    else if ([[PlayerStatistics StatManager] getTotalCorrectRecord]==200 && [[GameData GameDataManager] returnpremium] &&  (![[GameData GameDataManager] returnkeyofenergy] || ![[GameData GameDataManager] returnkeyofwisdom])&& [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow200K"])
    {
        //NSLog(@"TARAAAdAAAAAA");
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Brilliant !" message:@"You have successfully answered 200 Knowledge Path Questions. \nRemember: The Key of Energy increases your daily Energy significantly, reduces the Energy cost of everything, and Unlocks the Magic Well. The Key of Wisdom increases your KNOP gains, reduces the Energy costs of the Knowledge Path, and Unlocks the Tree of Knowledge." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 65;
        [BMAlert show];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow200K"];
        [BMAlert release];
    }    //Telling the Player to go get his reward
    //NSLog(@"Now Checking ... Basic Mision Ready");
    else if (![[[Myquslist alloc]init] getMissionFlag:1] && [[PlayerStatistics StatManager] getTotalCorrectRecord]==5 && [[NSUserDefaults standardUserDefaults] boolForKey:@"Allow5K"])
    {
        NSLog(@"Now Checking ... Basic Mision Ready");
        
        UIAlertView *BMAlert = [[UIAlertView alloc]initWithTitle:@"Great !" message:@"You have successfully answered 5 Knowledge Path Questions. \n Hint: You have an unclaimed reward in Basic Missions (in Options)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        BMAlert.tag = 15;
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Allow5K"];
        [BMAlert show];
        [BMAlert release];
    }

}

-(void)showCorrectText{
   
    CCLabelTTF *correcttxt = [CCLabelTTF labelWithString:@"That's Correct!" fontName:@"Times-Bold" fontSize:24];
    correcttxt.position = ccp(140,220);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        correcttxt.position = ccp(120*DevicewidthRatio,200*DeviceheightRatio);
        correcttxt.fontSize = 48;
    }
    correcttxt.color = ccBLACK;
    [bg addChild:correcttxt];
    
    
    NSString *consecutivestr = [NSString stringWithFormat:@"%d/4 correct answers",gamedata.knowledgepath4counter];
    CCLabelTTF *consecutiveans = [CCLabelTTF labelWithString:consecutivestr fontName:@"Times-Bold" fontSize:20];
    consecutiveans.position = ccp(140,190);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        consecutiveans.position = ccp(120*DevicewidthRatio,160*DeviceheightRatio);
        consecutiveans.fontSize = 48;
    }
    consecutiveans.color = ccBLACK;
    [bg addChild:consecutiveans];
    
     NSString *knopstr = [NSString stringWithFormat:@"Your KNOPs  : %.2f",[gamedata returnknop]];
    CCLabelTTF *knoplbl = [CCLabelTTF labelWithString:knopstr fontName:@"Times-Bold" fontSize:20];
    knoplbl.position = ccp(140,150);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        knoplbl.position = ccp(120*DevicewidthRatio,125*DeviceheightRatio);
        knoplbl.fontSize = 40;
    }
    knoplbl.color = ccBLACK;
    [bg addChild:knoplbl];
    
    NSString *goldstr = [NSString stringWithFormat:@"Your GOLD  : %.2f",[gamedata returngold]];
    CCLabelTTF *goldlbl = [CCLabelTTF labelWithString:goldstr fontName:@"Times-Bold" fontSize:20];
    goldlbl.position = ccp(140,125);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        goldlbl.position = ccp(120*DevicewidthRatio,105*DeviceheightRatio);
        goldlbl.fontSize = 40;
    }
    goldlbl.color = ccBLACK;
    [bg addChild:goldlbl];
    
    
    CCMenuItem *homeitem = [CCMenuItemImage itemWithNormalImage:@"homebtn.png" selectedImage:@"homebtn.png" target:self selector:@selector(backToHome:)];
    CCMenu *back = [CCMenu menuWithItems:homeitem, nil];
    back.position = ccp(70,70);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        back.position = ccp(70*DevicewidthRatio,60*DeviceheightRatio);
        
    }
    [bg addChild:back];
    CCMenuItem *nextqusitem = [CCMenuItemImage itemWithNormalImage:@"nextbtn.png" selectedImage:@"nextbtn.png"target:self selector:@selector(nextQuestion:)];
    CCMenu *next = [CCMenu menuWithItems:nextqusitem, nil];
    next.position = ccp(210,70);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        next.position = ccp(190*DevicewidthRatio,60*DeviceheightRatio);
        
    }
    [bg addChild:next];
    if(is4complete)
        gamedata.knowledgepath4counter=0;

}

-(void)stopCountDownSound{
    [[SimpleAudioEngine  sharedEngine]stopEffect:countDownEffect];
}

-(void)okBtnPressed:(id)sender{

    [bg removeAllChildrenWithCleanup:YES];
    [self showCorrectText];
}

-(void)countdown:(ccTime*)dt{
    if (counter>0) {
        counter--;
        counterlbl.string = [NSString stringWithFormat:@"%d",counter];
    }
    else{
        [self stopCountDownSound];
        [self unschedule:@selector(countdown:)];
        isClicked = true;
        home.visible = true;
        isCorrect = false;
        
        [self showScoreLayer];
        //nextqus.visible = true;
      
    
    }
}

-(void)showAd{
    if ([[GameData GameDataManager] returnknop]>20 && [[GameData GameDataManager] returnknop]>arc4random()%40)
    {
    int probabilityOfChartBoost = arc4random()%100;
    int probabilityOfRevmob = arc4random()%100;
    if(probabilityOfChartBoost<30){
        [[Chartboost sharedChartboost]showInterstitial];
    }
    else if(probabilityOfRevmob<40){
        [[RevMobAds session] showFullscreen];
    }
    }
}


-(void)nextQuestion:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[Play scene]]];
    
}
-(void)backToHome:(id)sender{
    gamedata.knowledgepath4counter=0;

    [[GameData GameDataManager]clearData];
   [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(NSInteger)getQusIndex:(NSInteger)difficulty :(int)t :(int)l{
  //  NSLog(@"count=%d",gamedata.qus.count);
 //   NSLog(@"difficulty = %d,type = %d , level=%d,",difficulty,t,l);
    NSInteger d=0;
    NSInteger qt=0;
    NSInteger ran=1;

    if(difficulty == 0){
        float p2 = 0.05f+(l-1)*(10-l)/40.2f;//probabilty of getting a medium question
        float p1 = (1-p2)*(11-l)/10;    //probability of getting an easy question
        float p3 = (1-p2)*(l-1)/10;      //probabilty of getting a hard question
        float r = (arc4random() % 10000) * 0.0001;
        if(r<p1)
            difficulty=1;
        else if(r>p1 & r<(1-p3)) 
            difficulty=2;
        else 
            difficulty=3;
    }
    if(t==0){
      /*   for(int i=0 ; i< [qusIndex count] ; i++){
            ran = arc4random()% [qusIndex count];
            index = [[qusIndex objectAtIndex:ran]intValue];
            QusList *qusselect = (QusList*)[gamedata.qus objectAtIndex:index];
            d=qusselect.difficulty;
            qt=qusselect.type;
            NSLog(@"ran=%d index=%d,count=%d",ran,index,[qusIndex count]);
            if(d!= difficulty)
              [qusIndex removeObjectAtIndex:ran];
            else
                break;
        }*/
        while (d!=difficulty) {
            ran = arc4random()%gamedata.qus.count;
           // NSLog(@"difficulty=%d,d=%d",difficulty,d);
            QusList *qusselect = (QusList*)[gamedata.qus objectAtIndex:ran];
            d=qusselect.difficulty;
            qt=qusselect.type;
        }
    }
    else{
       /* for(int i=0 ; i< [qusIndex count] ; i++){
            ran = arc4random()% [qusIndex count];
            index = [[qusIndex objectAtIndex:ran]intValue];
            QusList *qusselect = (QusList*)[gamedata.qus objectAtIndex:index];
            d=qusselect.difficulty;
            qt=qusselect.type;
            NSLog(@"ran=%d index=%d,count=%d",ran,index,[qusIndex count]);
            if( qt!=t || d!= difficulty )
                [qusIndex removeObjectAtIndex:ran];
            else
                break;
        }
*/
        while ( qt!=t || d!= difficulty ) {
           // int n = [gamedata.qus count];
            ran = arc4random()%[gamedata.qus count];
            
            QusList *qusselect = (QusList*)[gamedata.qus objectAtIndex:ran];
            d=qusselect.difficulty;
            qt=qusselect.type;
        }

    }
       return ran;


}

-(void)showReasonsForPremium{
   // [self disableTouch];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"PremiumVsBasic"];
    premimuReasonView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    premimuReasonView.alpha = 0;
    [[[CCDirector sharedDirector]view ]addSubview:premimuReasonView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/4, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [premimuReasonView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2, DeviceHeight/5, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+85, DeviceHeight/4.8, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchDown];
    [premimuReasonView addSubview:tutorialCloseButton];
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         premimuReasonView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
    
}

-(void)backToMainView{
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         premimuReasonView.alpha = 0;
                         energyTextView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     [premimuReasonView removeFromSuperview];
                         [energyTextView removeFromSuperview];
                        [self back];
                     }];
    
}

-(void)createEnergyText{
    //[self clearTutorialView];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *beyondTextImage = [UIImage imageNamed:@"boostSubtutorialtext3"];
    
    energyTextView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    energyTextView.alpha = 0;
    [[[CCDirector sharedDirector]view]addSubview:energyTextView];
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/16, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [energyTextView addSubview:tutorialBackgroundImageView];
    
    
    UIImageView *beyondTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, beyondTextImage.size.width, beyondTextImage.size.height)];
    if ([[Utility getInstance].deviceType isEqualToString:@"_iPad"]) {
        beyondTextImageView.frame = CGRectMake(40, 60, beyondTextImage.size.width, beyondTextImage.size.height);
    }
    beyondTextImageView.image = beyondTextImage;
    [tutorialBackgroundImageView addSubview:beyondTextImageView];
    
  
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
//        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width+tutorialCloseButtonImage.size.width/3+225, DeviceHeight/40, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
//    }
    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchDown];
    [energyTextView addSubview:tutorialCloseButton];
   // [tutorialCloseButton release];
    [UIView animateWithDuration:1.0 delay:1.0 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         energyTextView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
}


-(void)dealloc{
    [ec release];
    [qusIndex release];
    [super dealloc];
}
@end
