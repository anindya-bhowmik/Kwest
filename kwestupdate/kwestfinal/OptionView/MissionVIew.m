//
//  MissionVIew.m
//  kwest
//
//  Created by Anindya on 7/30/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "MissionVIew.h"
//#import "CCUIViewWrapper.h"
#import "Myquslist.h"
#import "PlayerStatistics.h"
#import "GameData.h"
#import "Utility.h"
#import "OptionView.h"
#import "Score.h"
#define Completed 0
#define NotCompleted 1

@implementation MissionVIew


+(CCScene *)scene{
    CCScene *scene = [CCScene node];
    MissionVIew *layer = [MissionVIew node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"Basic"];
        stat = [PlayerStatistics StatManager];
        gameData = [GameData GameDataManager];
        completeImage = [UIImage imageNamed:@"missioncomplete"];
        completeImageArray = [[NSMutableArray alloc]init];
        databaseManager = [[Myquslist alloc]init];
        backgroundImage = [CCSprite spriteWithFile:@"questBg.png"];
        backgroundImage.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
        [self addChild:backgroundImage];
        scoreCalculation = [[Score alloc]init];
        headerImage = [CCSprite spriteWithFile:@"MissionsTitle.png"];
        headerImage.position = ccp(160*DevicewidthRatio,420*DeviceheightRatio);
        [self addChild:headerImage];
        
        //        CCMenuItemImage *backItem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(backToMenu)];
        //        CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
        //        backMenu.position = ccp(50*DevicewidthRatio,50*DeviceheightRatio);
        //      //  [backgroundImage addChild:backMenu];
        [self performSelector:@selector(createSubView) withObject:nil afterDelay:0.9];
        //[self createSubView];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        effectID =  [[SimpleAudioEngine sharedEngine]playEffect:@"Basic.mp3"];
}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:effectID];
}

-(void)createSubView{
    
    
    UIImage *backButtonImage = [UIImage imageNamed:@"BackButton"];
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DeviceHeight/4.8, DeviceWidth, DeviceHeight)];
    scrollview.backgroundColor = [UIColor clearColor];
    //   [self addChild:scrollview];
    [[[CCDirector sharedDirector]view ]addSubview:scrollview];
    
    float missionYpos = 40*DeviceheightRatio;
    
    for(int i = 0 ;i<6 ;i++){
        BOOL isCompleted = [databaseManager getMissionFlag:i+1];
        UIImage *missionButtonImage = [UIImage imageNamed:[NSString stringWithFormat:@"mission%d",i+1]];
        
        UIImage *missionOkButtonImage = [UIImage imageNamed:@"mission_ok"];
        
        UIImageView *missionButton = [[UIImageView alloc]initWithFrame:CGRectMake(10*DevicewidthRatio, missionYpos, missionButtonImage.size.width, missionButtonImage.size.height)];
        //        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        //            missionButton.frame = CGRectMake(10*DevicewidthRatio, missionYpos, missionButtonImage.size.width, missionButtonImage.size.height);
        //        }
        missionButton.image = missionButtonImage;
        [scrollview  addSubview:missionButton];
        UIButton *missionOkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        missionOkButton.frame = CGRectMake(missionButton.frame.size.width+10*DevicewidthRatio, missionYpos, missionOkButtonImage.size.width, missionOkButtonImage.size.height);
        //        if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        //             missionOkButton.frame = CGRectMake(missionButton.frame.size.width+15*DevicewidthRatio+25, missionYpos, missionOkButtonImage.size.width, missionOkButtonImage.size.height);
        //        }
        missionOkButton.tag = i+1;
        [missionOkButton setBackgroundImage:missionOkButtonImage forState:UIControlStateNormal];
        [missionOkButton addTarget:self action:@selector(checkMissionStatus:) forControlEvents:UIControlEventTouchDown];
        UIImageView *missionCompleteImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*DevicewidthRatio, missionYpos+2, completeImage.size.width, completeImage.size.height)];
        if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
            missionCompleteImageView.frame = CGRectMake(10*DevicewidthRatio, missionYpos, completeImage.size.width, completeImage.size.height);
        }
        missionCompleteImageView.image = completeImage;
        
        [scrollview addSubview:missionCompleteImageView];
        [completeImageArray addObject:missionCompleteImageView];
        missionCompleteImageView.hidden  = YES;
        if(isCompleted){
            
            missionCompleteImageView.hidden = NO;
            
            [missionOkButton setEnabled:NO];
        }
        
        [scrollview addSubview:missionOkButton];
        scrollview.scrollEnabled = YES;
        
        missionYpos = missionYpos+missionButtonImage.size.height;
    }
    scrollview.contentSize = CGSizeMake(DeviceWidth, 75*6+40*6);
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        scrollview.contentSize = CGSizeMake(DeviceWidth, (75*6+40*6)*2);
    }
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(DeviceWidth/32, DeviceHeight/1.3, backButtonImage.size.width, backButtonImage.size.height);
    if([[Utility getInstance].deviceType isEqualToString:iPhone5]){
        backButton.frame = CGRectMake(DeviceWidth/32, DeviceHeight/1.2, backButtonImage.size.width, backButtonImage.size.height);
        
    }
    if([[Utility getInstance].deviceType isEqualToString:@"_iPad"]){
        backButton.frame = CGRectMake(DeviceWidth/32, DeviceHeight/1.2, backButtonImage.size.width, backButtonImage.size.height);
        
    }
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchDown];
    [[[CCDirector sharedDirector]view ]addSubview:backButton];
    [self fadeInAnimation];
    
    //    scrollview.alpha = 0.0;
    //    [UIView beginAnimations:@"Fade-in" context:NULL];
    //    [UIView setAnimationDuration:0.9];
    //    scrollview.alpha = 1.0;
    //    [UIView commitAnimations];
}

-(void)fadeInAnimation{
    scrollview.alpha = 0.0;
    backButton.alpha = 0.0;
    [UIView beginAnimations:@"Fade-in" context:NULL];
    [UIView setAnimationDuration:1.0];
    scrollview.alpha = 1.0;
    backButton.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)fadeOutAnimation{
    scrollview.alpha = 1.0;
    backButton.alpha = 1.0;
    [UIView beginAnimations:@"Fade-out" context:NULL];
    [UIView setAnimationDuration:0.9];
    scrollview.alpha = 0.0;
    backButton.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)checkMissionStatus:(id)sender{
    UIButton *senderButton = (UIButton*)sender;
    
    missionClicked = senderButton.tag;
    
    
    NSString *missionClickedFeedback;
    NSString *missionClickedButtonTitle ;
    int alertTag;
    switch (missionClicked) {
        case 1:
            if([self checkMissionOneStatus]){
                [senderButton setEnabled:NO];
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [gameData setknop:[gameData returnknop]+5];
                [scoreCalculation setLevel:[gameData returnknop]];
                // [gameData setLevel:[gameData returnknop]];
                [gameData setgold:[gameData returngold]+5];
                missionClickedFeedback = @"So you know the Knowledge Path.. You will receive 5 Gold and 5 KNOPs.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        case 2:
            if([self checkMissionTwoStatus]){
                [senderButton setEnabled:NO];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                [gameData setEnergy:[gameData returnenergy]+5];
                [gameData setknop:[gameData returnknop]+5];
                [scoreCalculation setLevel:[gameData returnknop]];
                [gameData setgold:[gameData returngold]+5];
                missionClickedFeedback = @"Good.. Now you know the Memory Challenge, and you will receive 5 Gold, 5 Energy, and 5 KNOPs.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        case 3:
            if([self checkMissionThreeStatus]){
                [senderButton setEnabled:NO];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                [gameData setEnergy:[gameData returnenergy]+10];
                [gameData setgold:[gameData returngold]+5];
                missionClickedFeedback = @"Good.. Now you know the Speed Challenge, and you will receive 5 Gold and 10 Energy.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        case 4:
            if([self checkMissionFourStatus]){
                [senderButton setEnabled:NO];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                [gameData setknop:[gameData returnknop]+5];
                [scoreCalculation setLevel:[gameData returnknop]];
                [gameData setgold:[gameData returngold]+10];
                missionClickedFeedback = @"Good.. Now you know the Focus Challenge, and you will receive 10 Gold and 5 KNOPs.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        case 5:
            if([self checkMissionFiveStatus]){
                [senderButton setEnabled:NO];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                [gameData setknop:[gameData returnknop]+10];
                [scoreCalculation setLevel:[gameData returnknop]];
                [gameData setEnergy:[gameData returnenergy]+15];
                missionClickedFeedback = @"Great… You have reached the Era of Exploration, and you will receive 10 KNOPs and 15 Energy.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        case 6:
            if([self checkMissionSixStatus]){
                [senderButton setEnabled:NO];
                UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
                imgView.hidden = NO;
                [databaseManager upDatemissionFlagTable:senderButton.tag];
                [gameData setgold:[gameData returngold]+5];
                [gameData setEnergy:[gameData returnenergy]+10];
                missionClickedFeedback = @"You have solved a Quest. You will receive 10 Energy and 5 Gold.";
                missionClickedButtonTitle = @"Done";
                alertTag = Completed;
            }
            else{
                missionClickedFeedback = @"Come back when you complete this mission to get your reward.";
                missionClickedButtonTitle = @"Not Completed";
                alertTag = NotCompleted;
            }
            break;
        default:
            break;
    }
    UIAlertView *showFeedBackAlert = [[UIAlertView alloc]initWithTitle:missionClickedButtonTitle message:missionClickedFeedback delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    showFeedBackAlert.tag = alertTag;
    [showFeedBackAlert show];
    [showFeedBackAlert release];
}

-(BOOL)checkMissionOneStatus{
    int totalCorrectcounter = ([stat getScienceCorrectRecord]+[stat getLogicCorrectRecord]+[stat getHumanitiesCorrectRecord]+[stat getDeeperCorrectRecord]);
    if(totalCorrectcounter>=3)
        return TRUE;
    else
        return FALSE;
}

-(BOOL)checkMissionTwoStatus{
    int memoryBest = [gameData getMemorybest];
    if(memoryBest>=7){
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(BOOL)checkMissionThreeStatus{
    float sprintBest = [gameData getSprintBest];
    if(sprintBest<=42){
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(BOOL)checkMissionFourStatus{
    int enduranceBest = [gameData getendurancebest];
    if(enduranceBest>=12){
        return TRUE;
    }
    else{
        return FALSE;
    }
}
-(BOOL)checkMissionFiveStatus{
    int level = [gameData returnlevel];
    if(level>=2){
        return TRUE;
    }
    else{
        return FALSE;
    }
}


-(BOOL)checkMissionSixStatus{
    int solved = [databaseManager getQuestSolvedNumber];
    if(solved>=1){
        return TRUE;
    }
    else{
        return FALSE;
    }
}


-(void)alertView :(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag ==Completed){
        if(buttonIndex == 0){
            //            UIImageView *imgView = [completeImageArray objectAtIndex:missionClicked-1];
            //            imgView.hidden = NO;
            //[scrollview setNeedsDisplay];
        }
    }
}

-(void)clearView{
    [self fadeOutAnimation];
    [backButton removeFromSuperview];
    [scrollview removeFromSuperview];
}

-(void)backToMenu{
    [self clearView];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[OptionView scene]]];
}

@end
