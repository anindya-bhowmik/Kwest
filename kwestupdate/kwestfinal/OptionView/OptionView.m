//
//  OptionView.m
//  kwest
//
//  Created by Anindya on 6/13/13.
//  Copyright 2013 AITL. All rights reserved.
//

#import "OptionView.h"
#import "Menu.h"
#import "MissionVIew.h"
#import "Myquslist.h"
#import "BasePopUpView.h"
#import "HelpView.h"
#import "GameData.h"
#import "Utility.h"
#import "FBShareViewController.h"
#import "GameKitHelper.h"
#import <Chartboost/Chartboost.h>
#import "InAppPurchase.h"
#define premiumAlert 1
#define resetAlert   2
#define moreAlert 3

CCMenu *missionItemMenu;
CCMenu *resetMenu;
CCMenu *premiumMenu;
CCMenu *helpMenu;
CCMenu *shareMenu;
NSString *app_link;

//#import "ResolutionConstant.h"
@implementation OptionView
+(CCScene*)scene{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	OptionView *layer = [OptionView node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    if(self = [super init]){
        [Flurry logEvent:@"Options"];
        backgroundImage = [CCSprite spriteWithFile:@"questBg.png"];
        backgroundImage.position = ccp(160*DevicewidthRatio,240*DeviceheightRatio);
        [self addChild:backgroundImage];
        CCMenuItemImage *backItem = [CCMenuItemImage itemWithNormalImage:@"BackButton.png" selectedImage:@"BackButtonpressed.png" target:self selector:@selector(backToMenu)];
        CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
        backMenu.position = ccp(50*DevicewidthRatio,30*DeviceheightRatio);
        [backgroundImage addChild:backMenu];
        [self addSubViews];
        
        // Code Added for the more Apps
        //[[Chartboost sharedChartboost] showMoreApps];
        //[[Chartboost sharedChartboost] cacheMoreApps];
        
        //if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        //    [[SimpleAudioEngine sharedEngine]playEffect:@"Click1.mp3"];
        
        
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        effectID = [[SimpleAudioEngine sharedEngine]playEffect:@"Options.mp3"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"OptionsCounter"]+1 forKey:@"OptionsCounter"];
    
    
    /*if ([[NSUserDefaults standardUserDefaults]boolForKey:@"moreAllowed"])
        NSLog(@"Its True");
    else
        NSLog(@"Its False");*/
    if (TRUE)
    {
        
        if ([[GameData GameDataManager] returnknop]>=225 && [[NSUserDefaults standardUserDefaults] boolForKey:@"mailFeedAsk"])
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Feedback?" message:@"Your thoughts & opinion matter greatly. Would you like send us feedback and suggestions for KWEST and future projects?" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Yes, Sure",@"No, and Don't Ask Again",nil];
            
            moreAlertView.tag=10;
            [moreAlertView show];
            [moreAlertView release];
            
        }

    else if(![[GameData GameDataManager] returnpremium]){

        
        int more_probability=arc4random()%100;
        
        if (more_probability<16 && [[GameData GameDataManager] returnknop]>15)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"The Better Brain Library" message:@"Would you like to Download the 'Better Brain Library': a Knowledge Module with a number of useful productivity tools and book summaries on intelligence, mental skills, and thinking?" delegate:self cancelButtonTitle:@"No, Already too Smart" otherButtonTitles:@"Sure, Let me Try", nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/10bbLib";
            [moreAlertView show];
            [moreAlertView release];
        }
        else if (more_probability<32 && [[GameData GameDataManager] returnknop]>10)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Pixelated" message:@"Would you like to Download 'Pixelated'? Pixelated is a simple but challenging strategy game, that defies you to conquer the board as fast as possible with the least moves." delegate:self cancelButtonTitle:@"No, Can't Do It" otherButtonTitles:@"OK - Seems Easy", nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/PxlT1";
            [moreAlertView show];
            [moreAlertView release];
            
        }
        else if (more_probability<48 && [[GameData GameDataManager] returnknop]>15)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Profile Me" message:@"Would you like to Download 'Profile Me'? It is a personality test that can determine your important personality traits based on a series of Multiple Choice questions." delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Yes, Sure", nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/1PrFlMe";
            [moreAlertView show];
            [moreAlertView release];
            
        }

        
    }
    else if([[GameData GameDataManager] returnpremium] && [[NSUserDefaults standardUserDefaults]boolForKey:@"moreAllowed"])
    {
        int more_probability=arc4random()%100;
        
        if (more_probability<11)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"The Better Brain Library" message:@"Would you like to Download the 'Better Brain Library': a Knowledge Module with a number of useful productivity tools and book summaries on intelligence, mental skills, and thinking?" delegate:self cancelButtonTitle:@"No, Already too Smart" otherButtonTitles:@"Sure, Let me Try", @"No, and Don't Ask Again", nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/10bbLib";
            [moreAlertView show];
            [moreAlertView release];
        }
        else if (more_probability<22)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Pixelated" message:@"Would you like to Download 'Pixelated'? Pixelated is a simple but challenging strategy game, that defies you to conquer the board as fast as possible with the least moves." delegate:self cancelButtonTitle:@"No, Can't Do It" otherButtonTitles:@"OK - Seems Easy",@"No, and Don't Ask Again", nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/PxlT1";
            [moreAlertView show];
            [moreAlertView release];
        }
        else if (more_probability<33)
        {
            UIAlertView *moreAlertView = [[UIAlertView alloc]initWithTitle:@"Profile Me" message:@"Would you like to Download 'Profile Me'? It is a personality test that can determine your important personality traits based on a series of Multiple Choice questions." delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Yes, Sure",@"No, and Don't Ask Again",nil];
            
            moreAlertView.tag=moreAlert;
            app_link=@"http://bit.ly/1PrFlMe";
            [moreAlertView show];
            [moreAlertView release];
            
        }

    }

    }

}

-(void)onExit{
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopEffect:effectID];
}

+(void)enableTouch{
    missionItemMenu.enabled = YES;
    resetMenu.enabled = YES;
    premiumMenu.enabled = YES;
    helpMenu.enabled = YES;
    shareMenu.enabled = YES;
}


-(void)disableTouch{
    missionItemMenu.enabled = NO;
    resetMenu.enabled = NO;
    premiumMenu.enabled = NO;
    helpMenu.enabled = NO;
    shareMenu.enabled = NO;
}


-(void)addSubViews{
    CCMenuItemImage *missionItem = [CCMenuItemImage itemWithNormalImage:@"missionsButton.png" selectedImage:@"missionsButtonpressed.png" target:self selector:@selector(goToMissions)];
    missionItemMenu = [CCMenu menuWithItems:missionItem, nil];
    missionItemMenu.position = ccp(160*DevicewidthRatio,265*DeviceheightRatio);
    [backgroundImage addChild:missionItemMenu];
    
    CCMenuItemImage *resteItem = [CCMenuItemImage itemWithNormalImage:@"Reset.png" selectedImage:@"Resetpressed.png" target:self selector:@selector(goToReset)];
    resetMenu = [CCMenu menuWithItems:resteItem, nil];
    resetMenu.position = ccp(90*DevicewidthRatio,100*DeviceheightRatio);
    [backgroundImage addChild:resetMenu];
    
    CCMenuItemImage *premiumItem = [CCMenuItemImage itemWithNormalImage:@"Premium.png" selectedImage:@"Premiumpressed.png" target:self selector:@selector(goToPremium)];
    premiumMenu = [CCMenu menuWithItems:premiumItem, nil];
    premiumMenu.position = ccp(230*DevicewidthRatio,100*DeviceheightRatio);
    [backgroundImage addChild:premiumMenu];
    
    CCMenuItemImage *helpItem = [CCMenuItemImage itemWithNormalImage:@"Help.png" selectedImage:@"Helppressed.png" target:self selector:@selector(goToHelp)];
    helpMenu = [CCMenu menuWithItems:helpItem, nil];
    helpMenu.position = ccp(80*DevicewidthRatio,190*DeviceheightRatio);
    [backgroundImage addChild:helpMenu];
    
    CCMenuItemImage *shareItem = [CCMenuItemImage itemWithNormalImage:@"Share.png" selectedImage:@"Sharepressed.png" target:self selector:@selector(goToShare)];
    shareMenu = [CCMenu menuWithItems:shareItem, nil];
    shareMenu.position = ccp(240*DevicewidthRatio,190*DeviceheightRatio);
    [backgroundImage addChild:shareMenu];
    
    musicSwitchBg = [CCSprite spriteWithFile:@"Sounds_Switch.png"];
    musicSwitchBg.position = ccp(160*DevicewidthRatio,340*DeviceheightRatio);
    [backgroundImage addChild:musicSwitchBg];
    
    helpSwitchBG = [CCSprite spriteWithFile:@"Help_Switch.png"];
    helpSwitchBG.position = ccp(160*DevicewidthRatio,430*DeviceheightRatio);
    [backgroundImage addChild:helpSwitchBG];
    
    CCMenuItemImage *leaderboardMenuItem = [CCMenuItemImage itemWithNormalImage:@"leaderboard.png" selectedImage:@"leaderboard.png" target:self selector:@selector(showLeaderBoard)];
    leaderboardMenu = [CCMenu menuWithItems:leaderboardMenuItem, nil];
    leaderboardMenu.position = ccp(270*DevicewidthRatio,30*DeviceheightRatio);
    [backgroundImage addChild:leaderboardMenu];
    soundSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DeviceWidth/2.5, DeviceHeight/3.61, 0, 0)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        soundSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DeviceWidth/2.2, DeviceHeight/3.5, 0, 50)];
    }
    soundSwitch.alpha = 0;
    [soundSwitch addTarget:self action:@selector(soundSwitchwitchToggled:) forControlEvents:UIControlEventTouchUpInside];
    soundSwitch.on = [[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"];
   // [[CCDirector sharedDirector]setView:soundSwitch];
    [[[CCDirector sharedDirector]view]addSubview:soundSwitch];
    helpSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DeviceWidth/2.5, DeviceHeight/9.6, 0, 0)];
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        helpSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(DeviceWidth/2.2, DeviceHeight/9.6, 0, 50)];
    }
    helpSwitch.alpha = 0;
    
    helpSwitch.on = [[NSUserDefaults standardUserDefaults]boolForKey:@"Help"];
    [helpSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector]view]addSubview:helpSwitch];
    
    CCMenuItemImage *buyGoldItem = [CCMenuItemImage itemWithNormalImage:@"buygoldbtn.png" selectedImage:@"buygoldbtn.png" target:self selector:@selector(buyGold)];
    buyGoldMenu = [CCMenu menuWithItems:buyGoldItem, nil];
    buyGoldMenu.position = ccp(160*DevicewidthRatio,30*DeviceheightRatio);
    [backgroundImage addChild:buyGoldMenu];

    [UIView animateWithDuration:2.0 delay:0.4 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         soundSwitch.alpha = 1;
                         helpSwitch.alpha = 1;
                     }
                     completion:^(BOOL finished){}];
}

-(void)buyGold{
    InAppPurchase *inApp = [[InAppPurchase alloc]init];
    [inApp showStoreInfo];

}


-(void)showLeaderBoard{
    [Flurry logEvent:@"Gamecenter Click"];
    [self performSelectorOnMainThread:@selector(gameCenterTask) withObject:nil waitUntilDone:YES];
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"authenticated"]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Not Authenticated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
//    }
}

-(void)gameCenterTask{
    
 [[GameKitHelper sharedGameKitHelper]showLeaderBoard];
}
-(void)switchToggled:(UISwitch*)switchState{
    UISwitch *senderSwitch = switchState;
   
        NSUserDefaults *notifySound = [NSUserDefaults standardUserDefaults];
        [notifySound setBool:senderSwitch.on forKey:@"Help"];
   

    
}

-(void)soundSwitchwitchToggled:(UISwitch*)switchState{
    UISwitch *senderSwitch = switchState;
    
    NSUserDefaults *notifySound = [NSUserDefaults standardUserDefaults];
    [notifySound setBool:senderSwitch.on forKey:@"Sound"];
    
    
    
}


-(void)goToMissions{
    [Flurry logEvent:@"Basic"]; 
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    [soundSwitch removeFromSuperview];
    [helpSwitch removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.9 scene:[MissionVIew scene]]];
    //[self checkGameCenter];

}
-(void)goToReset{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    if([[GameData GameDataManager]returnpremium]==1){
        UIAlertView *resetAlertView = [[UIAlertView alloc]initWithTitle:@"Are you sure you want to Reset? If you do, you will keep your Keys and Energy, but all your attributes, progress, and statistics will be reset to 0." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset", nil];
        resetAlertView.tag= resetAlert;
        [resetAlertView show];
        [resetAlertView release];
       }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"You can reset the game only after you upgrade to Premium." message:@"\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}
-(void)goToPremium{
    [Flurry logEvent:@"PremiumClick"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
    if([[GameData GameDataManager]returnpremium] == 0){
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Premium" message:@"Do you want to upgrade to the premium version?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" ,@"Why?",@"Restore",nil];
    alertView.tag= premiumAlert;
    [alertView show];
    [alertView release];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"You have already unlocked the Premium version." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
        [alertView release];
    }
   
}
-(void)goToHelp{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"])
        [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
    
   
    HelpView *helpView = [[HelpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    [helpView createTutorialBaseView];
    [[[CCDirector sharedDirector]view ]addSubview:helpView];
     [self disableTouch];
  //  [self createTutorialBaseView];
}

-(void)goToShare{
    [Flurry logEvent:@"Share App"];
      [[SimpleAudioEngine sharedEngine]playEffect:@"Click2.mp3"];
  //  FBViewController *jads = [[FBViewController alloc]init];
//    jads.delegate  = self;
    
    
    
//    SLComposeViewController *fb=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//    
//    // make the default string
//    NSString *FBString= [NSString
//                         stringWithFormat:@"r via #GibberishGenerator"];
//    [fb setInitialText:FBString];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:fb animated:YES completion:nil];
    
    
    __block __weak SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//    [slComposeViewController setInitialText:[NSString stringWithFormat:@"Total Score of %d via KWEST",(int)[sc calculateUScore]]];
    [slComposeViewController addImage:[UIImage imageNamed:@"Default~ipad"]];

    
    NSString *text = [NSString stringWithFormat:@"Playing KWEST : Era - %i. ",[[GameData GameDataManager] returnlevel]];
    [slComposeViewController setInitialText:text];
    [slComposeViewController addURL:[NSURL URLWithString:@"http://bit.ly/33kWst"]];
    

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:slComposeViewController animated:YES completion:nil];

    [slComposeViewController setCompletionHandler:^
     (SLComposeViewControllerResult result){
         
         if (result == SLComposeViewControllerResultDone) {
             if(![[GameData GameDataManager]getFirstTimeShared]){
                 [[GameData GameDataManager]setFirstTimeShared:TRUE];
                 int currentGold = [[GameData GameDataManager]returngold];
                 [[GameData GameDataManager]setgold:currentGold+75];
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook - Successs" message:@"Thank you for Sharing. 75 Pieces of Gold Earned!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alert show];
                 [alert release];
             }
             
         }
         else{
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook - Fail" message:@"Sorry, Couldn't Post to Facebook." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
             [alert release];
         }
         
         [slComposeViewController dismissViewControllerAnimated:YES completion:nil];
     }];
    
    
     //[[[CCDirector sharedDirector]view ]addSubview:fb.view];
//    FBShareViewController* tweetComposer = [[FBShareViewController alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) IntialText:nil ShareImage:[UIImage imageNamed:@"Default~ipad"] ShareUrl:[NSURL URLWithString:@"http://bit.ly/33kWst"]];
//    [[[CCDirector sharedDirector]view ]addSubview:tweetComposer.view];
//    [tweetComposer shareinFB:FALSE];
//    NSURL *url = [NSURL URLWithString:@"http://youtube.com"];
    
//    [FBDialogs presentOSIntegratedShareDialogModallyFrom:tweetComposer initialText:nil images:nil urls:nil handler:^(FBOSIntegratedShareDialogResult result ,NSError *error){
//    
//        if(result == FBOSIntegratedShareDialogResultCancelled) {
//            NSLog(@"Error: %@", error.description);
//        } else if(result ==FBOSIntegratedShareDialogResultSucceeded)  {
//            NSLog(@"Success!");
//        }
//    }];
//    [FBDialogs presentShareDialogWithLink:url handler:(^FBOSIntegratedShareDialogResult,NSError *error){
//    
//    }];
//
//    BOOL displayedNativeDialog = [FBNativeDialogs
//                                  presentShareDialogModallyFrom:tweetComposer
//                                  initialText:@""
//                                  image:[UIImage imageNamed:@"testimage.png"]
//                                  url:[NSURL URLWithString:@"http://www.example.com"]
//                                  handler:^(FBNativeDialogResult result, NSError *error) {
//                                      
//                                      NSString *alertText = @"";
//                                      if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
//                                          alertText = @"iOS Share Sheet not supported.";
//                                      } else if (error) {
//                                          alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
//                                      } else if (result == FBNativeDialogResultSucceeded) {
//                                          alertText = @"Posted successfully.";
//                                      }
//                                      
//                                      if (![alertText isEqualToString:@""]) {
//                                          // Show the result in an alert
//                                          [[[UIAlertView alloc] initWithTitle:@"Result"
//                                                                      message:alertText
//                                                                     delegate:self
//                                                            cancelButtonTitle:@"OK!"
//                                                            otherButtonTitles:nil]
//                                           show];
//                                      }
//                                  }];
//    if (!displayedNativeDialog) {
//        /* 
//         Fallback to web-based Feed dialog:
//         https://developers.facebook.com/docs/howtos/feed-dialog-using-ios-sdk/
//         */
//    }
}

- (void)facebookViewControllerCancelWasPressed:(id)sender{
    NSLog(@"Cancel Pressed");
}


 
- (void)facebookViewControllerDoneWasPressed:(id)sender{
    [Flurry logEvent:@"Share App"];
    NSLog(@"Done Pressed");
}

-(void)backToMenu{
    
    [soundSwitch removeFromSuperview];
    [helpSwitch removeFromSuperview];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:1.0 scene:[Menu scene]]];
}

-(void)alertView :(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   {
    if(alertView.tag == premiumAlert){
        if(buttonIndex == 1){
            [Flurry logEvent:@"PremiumConfirm"];
            [self premiumpurchase];
        }
        else if (buttonIndex == 2){
            [Flurry logEvent:@"Why_Premium"];
            [self showReasonsForPremium];
        }
        else if (buttonIndex ==3){
            NSLog(@"clicked and calling reestorePurchase");
            inApp = [[InAppPurchase alloc]init];
            [inApp restorePurchaseWithIdentifier:@"kwest_premium"];
        }
    }
    if(alertView.tag == resetAlert){
        if(buttonIndex == 1){
            Myquslist *myQusList = [[Myquslist alloc]init];
            [myQusList resetClue];
            [myQusList resetFlag];
            [myQusList resetMissionFlag];
            [myQusList resetPlayerData];
            [myQusList resetLStat];
            [myQusList resetKStat];
            [myQusList resetQuest];
            [myQusList release];
        }
        
    }
    if (alertView.tag==moreAlert)
    {
        if(buttonIndex==1){
            [Flurry logEvent:@"Download BBL/PXL/PRFL Clicked"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:app_link]];
            //NSLog(app_link);
        }
        else if (buttonIndex==2)
        {
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"moreAllowed"];
            
        }
        
        
    }
    if (alertView.tag ==10) {
        if (buttonIndex==1)
        {
            //[Flurry logEvent:@"Download BBL/PXL/PRFL"];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:app_link]];
            NSString *recipients = @"mailto:kwest@think-grow.biz?&subject=KWEST Feedback";
            NSString *body = @"&body=";
            
            NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
            email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
            //NSLog(recipients);
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:recipients]];
            
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"mailFeedAsk"];
            //NSLog(app_link);
        }
        else if (buttonIndex==2)
        {
             [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"mailFeedAsk"];
        }
    }
}

-(void )premiumpurchase{
    inApp = [[InAppPurchase alloc]init];
    [inApp startPurchaseWithIdentifier:@"kwest_premium"];
}

-(void)showReasonsForPremium{
    [self disableTouch];
    UIImage *tutorialCloseButtonImage = [UIImage imageNamed:@"X"];
    UIImage *tutorialBackgroundImage = [UIImage imageNamed:@"PremiumVsBasic"];
    tutorialView = [[BasePopUpView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    tutorialView.alpha = 0;
    [[[CCDirector sharedDirector]view ]addSubview:tutorialView];
    
    
    tutorialBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth/2-tutorialBackgroundImage.size.width/2, DeviceHeight/4, tutorialBackgroundImage.size.width, tutorialBackgroundImage.size.height)];
    tutorialBackgroundImageView.image = tutorialBackgroundImage;
    [tutorialBackgroundImageView setUserInteractionEnabled:YES];
    [tutorialView addSubview:tutorialBackgroundImageView];
    
    
    
    tutorialCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2, DeviceHeight/5, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    if([[[Utility getInstance]deviceType]isEqualToString:@"_iPad"]){
        tutorialCloseButton.frame = CGRectMake(tutorialBackgroundImageView.frame.size.width-tutorialCloseButtonImage.size.width/2+85, DeviceHeight/4.8, tutorialCloseButtonImage.size.width, tutorialCloseButtonImage.size.height);
    }

    [tutorialCloseButton setBackgroundImage:tutorialCloseButtonImage forState:UIControlStateNormal];
    [tutorialCloseButton addTarget:self action:@selector(showMainView) forControlEvents:UIControlEventTouchDown];
    [tutorialView addSubview:tutorialCloseButton];
    [UIView animateWithDuration:1.0 delay:0.5 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 1;
                     }
                     completion:^(BOOL finished){}];

}

-(void)showMainView{
    [UIView animateWithDuration:1.0 delay:0.6 options:nil
                     animations:^{
                         //tutorialView.center = midCenter;
                         tutorialView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [tutorialView removeFromSuperview];
                         [self.class enableTouch];
                     }];
}

-(void)checkGameCenter{
//if ([GameCenterManager isGameCenterAvailable]) {
//    
//    gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
//    //[gameCenterManager setDelegate:self];
//    [gameCenterManager authenticateLocalUser];
//}
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{
    [temp.view removeFromSuperview];
    [temp dismissViewControllerAnimated:YES completion:nil];
	[viewController release];
}

/////////////////// help methods /////////////////////



@end
