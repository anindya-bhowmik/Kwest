//
//  QuestScene.m
//  kwest
//
//  Created by Anindya on 5/7/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "QuestScene.h"
#import "NewTower.h"
#import "QusList.h"
#import "Quest.h"
#import "ClueScene.h"
//#import "ResolutionConstant.h"
#import "Myquslist.h"
#import "BasePopUpView.h"
#import <RevMobAds/RevMobAds.h>
#import "Utility.h"
#import "Score.h"
#import <Chartboost/Chartboost.h>
#import "Score.h"
#define MysterySolver   @"MysterySolver"
#define fakeAlert 0
#define resultAlert 20

@implementation QuestScene
+(CCScene *)scene{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	QuestScene *layer = [QuestScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self = [super init]){
      
        [Flurry logEvent:@"Quests"];
        questArray = [[NSMutableArray alloc]init];
        Myquslist *qw = [[Myquslist alloc]init];
        questArray = [qw getQuestList];
        [qw release];
        [self createQuestBtnView];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Help"]){
            [self createTutorialBaseView];
        }
        if(![[GameData GameDataManager] returnpremium]){
         if ([[GameData GameDataManager] returnknop]>40)
             [Chartboost showInterstitial:CBLocationQuests];

        }
       // [self createQuestBtnView];
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
  
}

-(void)onExit{
    [super onExit];
 //   [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

-(void)createTutorialBaseView{
    [self disabkeTouch];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"BlueBG"];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *sprintTextImage = [UIImage imageNamed:@"Queststxt"];
    UIImage *questButtonImage = [UIImage imageNamed:@"Tower"];
    
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
   // tutorialView.backgroundColor = [UIColor blackColor];
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
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(DeviceWidth/5.82, DeviceHeight/12, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-60);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
       scrollView.frame = CGRectMake(DeviceWidth/5, DeviceHeight/12, sprintTextImage.size.width, tutorialBackgroundImageView.frame.size.height-120);
    }
    
    [tutorialView addSubview:scrollView];
    
    UIImageView *sprintTextImageView = [[UIImageView alloc]initWithImage:sprintTextImage];
    //    sprintTextImageView.frame = CGRectMake(0, 0, sprintTextImage.size.height, sprintTextImage.size.height);
    //sprintTextImageView.image= sprintTextImage;
    //    scrollView.contentSize = CGSizeMake(sprintTextImage.size.width, sprintTextImage.size.height+sprintTextImage.size.height/2);
    //    scrollView.scrollEnabled = YES;
    [scrollView addSubview:sprintTextImageView];
    //  [self showBeyondTutorial];
    
    UIButton *questTutorialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    questTutorialButton.frame = CGRectMake(tutorialBackgroundImage.size.width/2 - questButtonImage.size.width/2, scrollView.frame.size.height, questButtonImage.size.width, questButtonImage.size.height);
    [questTutorialButton setBackgroundImage:questButtonImage forState:UIControlStateNormal];
    [questTutorialButton addTarget:self action:@selector(gotToQuestFromTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorialBackgroundImageView addSubview:questTutorialButton];
   // [questTutorialButton release];
}
-(void)clearTutorialView{
    for(UIView *subViews in [tutorialBackgroundImageView subviews]){
        [subViews removeFromSuperview];
    }
}
-(void)gotToQuestFromTutorial{
    [tutorialView removeFromSuperview];
    [self backToTower];
}

-(void)showMainView{
    [tutorialView removeFromSuperview];
    [self enableTouch];
}

-(void)createQuestBtnView{

    NSString *quest1Image;
    NSString *quest2Image;
    NSString *quest3Image;
    NSString *quest4Image;
    NSString *quest5Image;
    NSString *quest6Image;
    NSString *quest7Image;
    NSLog(@"%d",[questArray count]);
    questBg = [CCSprite spriteWithFile:@"questBg.png"];
    questBg.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [self addChild:questBg];
    CCMenuItemImage *backBtn = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButton.png" target:self selector:@selector(backToTower)];
    backBtnMenu = [CCMenu menuWithItems:backBtn, nil];
    backBtnMenu.position = ccp(35*DevicewidthRatio,50*DeviceheightRatio);
    [questBg addChild:backBtnMenu];
    
    CCMenuItemImage *clueBtn = [CCMenuItemImage itemWithNormalImage:@"cluesButton.png" selectedImage:@"cluesButtonpressed.png" target:self selector:@selector(goToClues)];
    clueBtnMenu = [CCMenu menuWithItems:clueBtn, nil];
    clueBtnMenu.position = ccp(270*DevicewidthRatio,50*DeviceheightRatio);
    [self addChild:clueBtnMenu];
    //CGPoint *menu1pos;
 //   for(int i = 0 ;i<[questArray count];i++){
        Quest *quest1 = (Quest*)[questArray objectAtIndex:0];
        if(quest1.solved==0){
            quest1Image = [NSString stringWithFormat:@"questButton.png"];
         //   menu1pos = (160, 100);
            //menu1pos.y = 100;
            ///  quest1ItemMenu.position = ccp(160,100);
        }
        else{
            quest1Image = [NSString stringWithFormat:@"Simple-1.png"];
             // quest1ItemMenu.position = ccp(160,100);
        }
    Quest *quest2 = (Quest*)[questArray objectAtIndex:1];
    if(quest2.solved==0){
        quest2Image = [NSString stringWithFormat:@"questButton.png"];
          // quest2ItemMenu.position = ccp(120,155);
    }
    else{
        quest2Image = [NSString stringWithFormat:@"Petals-2.png"];
          // quest2ItemMenu.position = ccp(80,155);
    }
   Quest *quest3 = (Quest*)[questArray objectAtIndex:2];
   if(quest3.solved==0){
       quest3Image = [NSString stringWithFormat:@"questButton.png"];
     //  quest3ItemMenu.position = ccp(200,155);
    }
   else{
       quest3Image = [NSString stringWithFormat:@"Petals-3.png"];
      // quest3ItemMenu.position = ccp(220,155);
   }
    Quest *quest4 = (Quest*)[questArray objectAtIndex:3];
    if(quest4.solved==0){
        quest4Image = [NSString stringWithFormat:@"questButton.png"];
    }
    else{
        quest4Image = [NSString stringWithFormat:@"Petals-6.png"];
    }
    
    Quest *quest5 = (Quest*)[questArray objectAtIndex:4];
    if(quest5.solved==0){
        quest5Image = [NSString stringWithFormat:@"questButton.png"];
    }
    else{
     quest5Image = [NSString stringWithFormat:@"Petals-5.png"];
    }
    
    
    Quest *quest6 = (Quest*)[questArray objectAtIndex:5];
    if(quest6.solved==0){
        quest6Image = [NSString stringWithFormat:@"questButton.png"];
    }
    else
        quest6Image = [NSString stringWithFormat:@"Sphere-4.png"];
    
    Quest *quest7 = (Quest*)[questArray objectAtIndex:6];
    if(quest7.solved==0){
        quest7Image = [NSString stringWithFormat:@"questButton.png"];
    }
    else
        quest7Image = [NSString stringWithFormat:@"Last-7.png"];
    
    
    CCMenuItem *quest1Item = [CCMenuItemImage itemWithNormalImage:quest1Image selectedImage:quest1Image target:self selector:@selector(goToQuest:)];
    quest1Item.tag = 1;
    quest1ItemMenu = [CCMenu menuWithItems:quest1Item, nil];
    quest1ItemMenu.position = ccp(160*DevicewidthRatio,100*DeviceheightRatio);
    [questBg addChild:quest1ItemMenu];
    
    CCMenuItem *quest2Item = [CCMenuItemImage itemWithNormalImage:quest2Image selectedImage:quest2Image target:self selector:@selector(goToQuest:)];
    quest2Item.tag = 2;
    quest2ItemMenu = [CCMenu menuWithItems:quest2Item, nil];
    if(quest2.solved ==0)
        quest2ItemMenu.position = ccp(100*DevicewidthRatio,190*DeviceheightRatio);
    else
        quest2ItemMenu.position = ccp(70*DevicewidthRatio,155*DeviceheightRatio);
    [questBg addChild:quest2ItemMenu];
    
    CCMenuItem *quest3Item = [CCMenuItemImage itemWithNormalImage:quest3Image selectedImage:quest3Image target:self selector:@selector(goToQuest:)];
    quest3Item.tag = 3;
    quest3ItemMenu = [CCMenu menuWithItems:quest3Item, nil];
    if(quest3.solved==0)
        quest3ItemMenu.position = ccp(220*DevicewidthRatio,190*DeviceheightRatio);
    else
        quest3ItemMenu.position = ccp(250*DevicewidthRatio,155*DeviceheightRatio);
    [questBg addChild:quest3ItemMenu];
    
    CCMenuItem *quest6Item = [CCMenuItemImage itemWithNormalImage:quest6Image selectedImage:quest6Image target:self selector:@selector(goToQuest:)];
    quest6Item.tag = 6;
    quest6ItemMenu = [CCMenu menuWithItems:quest6Item, nil];
    if(quest6.solved==0)
        quest6ItemMenu.position = ccp(160*DevicewidthRatio,260*DeviceheightRatio);
    else
        quest6ItemMenu.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
    [questBg addChild:quest6ItemMenu];
//
//    
    CCMenuItem *quest4Item = [CCMenuItemImage itemWithNormalImage:quest4Image selectedImage:quest4Image target:self selector:@selector(goToQuest:)];
    quest4Item.tag = 4;
    quest4ItemMenu = [CCMenu menuWithItems:quest4Item, nil];
    if(quest4.solved == 0)
        quest4ItemMenu.position = ccp(100*DevicewidthRatio,340*DeviceheightRatio);
    else
        quest4ItemMenu.position = ccp(70*DevicewidthRatio,300*DeviceheightRatio);
    [questBg addChild:quest4ItemMenu];

    CCMenuItem *quest5Item = [CCMenuItemImage itemWithNormalImage:quest5Image selectedImage:quest5Image target:self selector:@selector(goToQuest:)];
    quest5Item.tag = 5;
    quest5ItemMenu = [CCMenu menuWithItems:quest5Item, nil];
    if(quest5.solved==0)
        quest5ItemMenu.position = ccp(220*DevicewidthRatio,340*DeviceheightRatio);
    else
        quest5ItemMenu.position = ccp(250*DevicewidthRatio,300*DeviceheightRatio);
    [questBg addChild:quest5ItemMenu];
//
    CCMenuItem *quest7Item = [CCMenuItemImage itemWithNormalImage:quest7Image selectedImage:quest7Image target:self selector:@selector(goToQuest:)];
    quest7Item.tag = 7;
    quest7ItemMenu = [CCMenu menuWithItems:quest7Item, nil];
    if(quest7.solved==0)
        quest7ItemMenu.position = ccp(160*DevicewidthRatio,420*DeviceheightRatio);
    else
        quest7ItemMenu.position = ccp(160*DevicewidthRatio,380*DeviceheightRatio);
    [questBg addChild:quest7ItemMenu];


}

-(void)updateUI{
  //  [self performSelectorOnMainThread:@selector(cleanup) withObject:nil waitUntilDone:YES];
// [self removeAllChildrenWithCleanup:YES];
    [questArray removeAllObjects];
    Myquslist *qw = [[Myquslist alloc]init];
    questArray = [qw getQuestList];
    [qw release];
   
    [self createQuestBtnView];
}

-(void)cleanup{
    [self removeAllChildrenWithCleanup:YES];
}


-(void)goToQuest:(id)sender{
    [Flurry logEvent:@"TriedQuest"];
    CCMenuItemImage *btn = (CCMenuItemImage*)sender;
    NSLog(@"btnTag=%d",btn.tag);
    switch (btn.tag) {
        case 1:
            if([[GameData GameDataManager]returnlevel]<1){
                NSString *string = @"You can’t access this Quest till you reach the Era of Curiosity";
                [self notEligibleAlert:string];
            }
            else{
            Quest *quest1 = (Quest*)[questArray objectAtIndex:0];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"You've solved this. Always Look for Clues, and Explore the Details";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    [self showFakeAlert];
                }
            }
            break;
        case 2:
            if([[GameData GameDataManager]returnlevel]<2){
                NSString *string = @"You can’t see what is hidden here until you reach the Era of Exploration.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:1];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"Salvation doesn't come from the sight of me. It demands strenuous effort and practice. So work hard and seek your own salvation constantly. \n - (Buddha) \n You’ve solved this – the answer was 'Discipline'.";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *solvedAlertString = @"We are looking for a quality essential for learning and improvement. It is the first ‘bridge between goals and accomplishments’. ...What is it ?\n In the room of clues, you'll find a disc with 003002001 written on it.";
                    [self showQuestAlert:solvedAlertString QuestNum:btn.tag];
                }
            }

            break;
        case 3:
            if([[GameData GameDataManager]returnlevel]<4){
                NSString *string = @"You can’t access this Quest now. Work harder and reach the 4th Era.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:2];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"Imagination is more important than Knowledge.";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *solvedAlertString = @"What is the solution of the Ancient Mystery?";
                    [self showQuestAlert:solvedAlertString QuestNum:btn.tag];
                }

            }

            break;
        case 4:
            if([[GameData GameDataManager]returnlevel]<6){
                NSString *string = @"This is hidden till you’ve learned and grown more.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:3];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"The real voyage of discovery consists not in seeking new landscapes but in having new eyes.\n— Marcel Proust \n\nYou've solved this - the answer was 'Vision'";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *solvedAlertString = @"You can’t just look… You need more.  To solve this challenge, you must visit the oracle. Tell her this number : \"1341\".. Then follow her instructions, and you will find the hidden word : ";
                    [self showQuestAlert:solvedAlertString QuestNum:btn.tag];
                }
            }

            break;
        case 5:
            if([[GameData GameDataManager]returnlevel]<7){
                NSString *string = @"You will not unhide this Challenge in this Era.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:4];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"Solved ! The wise never escape their responsibilities. Involvement";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *questQusString =@"Knowing , Being , Doing … It is never enough to just ‘Know’ and ‘Be’. The truly wise know that the world is a world of effort and ……  What is the missing word?\nNote: Check the engraving on the Corner Stone.";
                    [self showQuestAlert:questQusString QuestNum:btn.tag];
                }
            }

            break;
        case 6:
            if([[GameData GameDataManager]returnlevel]<8){
                NSString *string = @"Still early to try this Challenge.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:5];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"The most beautiful thing we can experience is the mysterious. It is the source of all true art and all science. He to whom this emotion is a stranger, who can no longer pause to wonder and stand rapt in awe, is as good as dead: his eyes are closed. \n ― Albert Einstein";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *questQusString = @"There is probably always something that you're missing, so have an open mind and accept ______.\nTo Solve this challenge you will need to look at the principles of Leonardo Da Vinci (See Clues). If you take one of these principles to the Oracle, she will tell you what the hidden quality is.";
                    [self showQuestAlert:questQusString QuestNum:btn.tag];
                }

            }

            break;
        case 7:
            if([[GameData GameDataManager]returnlevel]<9){
                NSString *string = @"Work harder to unlock this.";
                [self notEligibleAlert:string];
            }
            else{
                Quest *quest1 = (Quest*)[questArray objectAtIndex:6];
                if(quest1.solved ==1){
                    NSString *solvedAlertString = @"Beauty is Truth";
                    [self showSolvedAlert:solvedAlertString];
                }
                else{
                    NSString *questQusString = @"Life as a mission is nice, but you should never miss looking at the sides of the road - there is usually so much _____ there.\nNote: See the letter of the Golden Ratio it will help you find the missing word.";
                    [self showQuestAlert:questQusString QuestNum:btn.tag];
                }

            }

            break;
        default:
            break;
    }


}

-(void)showFakeAlert{
    UIAlertView *fakeAlertView = [[UIAlertView alloc]initWithTitle:@"This is your first Quest. It is simple, and will help you see how things work. Follow the clues to find the answer." message:@"\n" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles: nil];
    fakeAlertView.tag = fakeAlert;
    [fakeAlertView show];
}

-(void)showQuestAlert:(NSString *)qus QuestNum:(int)num{
    if(num!=3){
        UIAlertView *questAlert = [[UIAlertView alloc]initWithTitle:nil message:qus delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        questAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        questAlert.frame = CGRectMake(questAlert.frame.origin.x, questAlert.frame.origin.y -50,questAlert.frame.size.width, 300);
        questAlert.tag = num;
//        UITextField *answerTextField = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 100.0, 260.0, 25.0)];
//        answerTextField.backgroundColor = [UIColor whiteColor];
//        answerTextField.borderStyle = UITextBorderStyleRoundedRect;
//        [questAlert addSubview:answerTextField];
        [questAlert show];
        [questAlert release];
    }
    else if(num==3){
        
//        UIAlertView *questAlert = [[UIAlertView alloc]initWithTitle:qus message:@"\n" delegate:self cancelButtonTitle:@"Don't Know" otherButtonTitles:@"OK",@"Download App", nil];
       // questAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UIAlertView *questAlert = [UIAlertView new];
        
        [questAlert setTitle:qus];
        [questAlert setMessage:@"\n"];
        [questAlert addButtonWithTitle:@"Download App"];
        [questAlert addButtonWithTitle:@"OK"];
        [questAlert addButtonWithTitle:@"Don't know"];
        [questAlert setDelegate:self];
        questAlert.tag = num;
        questAlert.message = @"\n";
        // Have Alert View create its view heirarchy, set its frame and begin bounce animation
        
        // Adjust the frame
        float deviceOS = [[[UIDevice currentDevice] systemVersion]floatValue];
        if(deviceOS>=7){
            questAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
             [questAlert show];
        }
        else{
            [questAlert show];
           // questAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            CGRect frame = questAlert.frame;
            frame.origin.y -= 100.0f;
           questAlert.frame = frame;
            ansField = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 70, 260.0, 25.0)];
            ansField.backgroundColor = [UIColor whiteColor];
            ansField.borderStyle = UITextBorderStyleRoundedRect;
        [questAlert addSubview:ansField];
             
        }
       

        [questAlert release];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag != fakeAlert && alertView.tag != resultAlert){
        if([title isEqualToString:@"OK"])
            {
                NSString *answerString;
            if(alertView.tag!=3){
                    UITextField *answerTextField = [alertView textFieldAtIndex:0];
                    answerString = answerTextField.text;
                }
                else{
                    float deviceOS = [[[UIDevice currentDevice] systemVersion]floatValue];
                    if(deviceOS>=7){
                        UITextField *answerTextField = [alertView textFieldAtIndex:0];
                        answerString = answerTextField.text;
                    }
                    else{
                        answerString = ansField.text;
                    }
                }
                answerString = [answerString lowercaseString];
                [self checkResult:answerString :alertView.tag];
                
            }
        else if([title isEqualToString:@"Download App"]){
            [Flurry logEvent:@"AM_Click"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bit.ly/7AmstrY"]];
        }
    }
    if(alertView.tag == fakeAlert) {
        NSString *questString = @"We are looking for a great man. You’ll encounter him many times, but for now, you must find out his name. He is a role model and a true master. The Mathematician’s Letter in the room of clues might help you in your search. What is his first name?";
        [self showQuestAlert :questString QuestNum:1];
    }
    if(alertView.tag == resultAlert){
        [self updateUI];
    }
}

-(void)notEligibleAlert:(NSString *)alertString{
    UIAlertView *notEligible = [[UIAlertView alloc]initWithTitle:alertString message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [notEligible show];
}

-(void)showSolvedAlert:(NSString *)alertString{
    UIAlertView *solvedAlert = [[UIAlertView alloc]initWithTitle:alertString message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [solvedAlert show];
}


-(void)goToClues{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[ClueScene scene]]];
}

-(void)checkResult:(NSString *)answerString :(int)questtag{
    NSString *resultString = @"";
    int questSolved = 0;
    GameData *gameData = [GameData GameDataManager];
    questSolved = [gameData getQuestCompleted];
     Myquslist *qus = [[Myquslist alloc]init];
    switch (questtag) {
        case 1:
            if([answerString isEqualToString:@"leonardo"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+15];
                [[GameData GameDataManager]setknop:k+10];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"Correct! It is the Master Leonardo Da Vinci. You have solved this successfully and will receive 15 Gold and 10 KNOPs. Keep on looking for clues, and remember to Explore the details";
            }
            else{
                resultString = @"No. That is incorrect.";
            }
            break;
        case 2:
            if([answerString isEqualToString:@"discipline"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+20];
                [[GameData GameDataManager]setknop:k+20];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"That’s right. Discipline is the Key. \nYou will gain 20 Gold and 20 KNOPs for finding the answer.";
            }
            else{
                resultString = @"No. Try Again.";
            }

            break;
        case 3:
            if([answerString isEqualToString:@"imagination"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+25];
                [[GameData GameDataManager]setknop:k+25];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"Imagination! It is truly more important than Knowledge. You will receive 25 Gold and 25 KNOPs for solving this Mystery. Keep on looking for clues, and remember to Explore the details.";
            }
            else{
                resultString = @"No. That’s not it.";
            }

            break;
        case 4:
            if([answerString isEqualToString:@"vision"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+35];
                [[GameData GameDataManager]setknop:k+30];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                
                isRight = YES;
                resultString = @"Good. Vision. You will gain 30 KNOPs and 35 Gold.\n\n Knowledge is love and light and vision. \n - Helen Keller";
            }
            else{
                resultString = @"You're not seeing the answer.";
            }

            break;
        case 5:
            if([answerString isEqualToString:@"involvement"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+45];
                [[GameData GameDataManager]setknop:k+35];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"Involvement is the missing word. You have gained 35 KNOPs and 45 Gold";
            }
            else{
                resultString = @"No – Put more Effort.";
            }

            break;
        case 6:
            if([answerString isEqualToString:@"uncertainty"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+60];
                [[GameData GameDataManager]setknop:k+40];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"True – or is it?! \n We can't be 100% sure, but you will get 40 KNOPs and 60 Gold for accepting uncertainty.";
            }
            else{
                resultString = @"That doesn’t seem to be correct.";
            }

            break;
        case 7:
            if([answerString isEqualToString:@"beauty"]){
                [Flurry logEvent:@"SolvedQuest"];
                [gameData setQuestCompleted:questSolved+1];
                float k = [[GameData GameDataManager]returnknop];
                float g = [[GameData GameDataManager]returngold];
                [[GameData GameDataManager]setgold:g+75];
                [[GameData GameDataManager]setknop:k+50];
                [[[Score alloc]init] setLevel:[gameData returnknop]];
                [qus updateQuestSolved:1 :questtag];
                isRight = YES;
                resultString = @"You have solved the final Quest – A truly BEAUTIFUL job.";
            }
            else{
                resultString = @"That’s not the answer.";
            }

            break;
        default:
            break;
    }
    if([gameData getQuestCompleted]>=3){
        Score *score = [[Score alloc]init];
        Myquslist *dbHandler = [[Myquslist alloc]init];
        [dbHandler updateAchivementAchiveStatus:MysterySolver];
        [score sendAchievements:MysterySolver];
    }
    [qus release];
    [self showResultAlert:resultString];
}

-(void)backToTower{
   // [[CCDirector sharedDirector]popScene];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[NewTower scene]]];
}

-(void)showResultAlert:(NSString *)questString{
    UIAlertView *finalAlertView = [[UIAlertView alloc]initWithTitle:questString message:@"\n" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    finalAlertView.tag = resultAlert;
    [finalAlertView show];
}

-(void)enableTouch{
    quest1ItemMenu.enabled = YES;
    quest2ItemMenu.enabled = YES;
    quest3ItemMenu.enabled = YES;
    quest4ItemMenu.enabled = YES;
    quest5ItemMenu.enabled = YES;
    quest6ItemMenu.enabled = YES;
    quest7ItemMenu.enabled = YES;
    clueBtnMenu.enabled = YES;
    backBtnMenu.enabled = YES;
}

-(void)disabkeTouch{
    quest1ItemMenu.enabled = NO;
    quest2ItemMenu.enabled = NO;
    quest3ItemMenu.enabled = NO;
    quest4ItemMenu.enabled = NO;
    quest5ItemMenu.enabled = NO;
    quest6ItemMenu.enabled = NO;
    quest7ItemMenu.enabled = NO;
    clueBtnMenu.enabled = NO;
    backBtnMenu.enabled = NO;
}

@end
