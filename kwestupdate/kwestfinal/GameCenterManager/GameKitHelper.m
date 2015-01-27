//
//  GameKitHelper.m
//  MonkeyJump
//
//  Created by Fahim Farook on 18/8/12.
//
//

#import "GameKitHelper.h"
#import "cocos2d.h"
#import "MBProgressHUD.h"
#import "GameData.h"
#import "Score.h"
#import "PlayerStat.h"
#import "PlayerStatistics.h"
#import "PlayerInfo.h"
#define gameCenterDisabled  @"The requested operation has been cancelled or disabled by the user."

#define SubmitScore      1
#define SubmitAchivement 2
#define ShowLeaderBoard  3


@interface GameKitHelper () {
    BOOL _gameCenterFeaturesEnabled;
}
@end

@implementation GameKitHelper

#pragma mark Singleton stuff

+(id) sharedGameKitHelper {
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper =
		[[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

#pragma mark Player Authentication

-(void) authenticateLocalPlayer :(int)workType {
	GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    GKLocalPlayer *blockLocalPlayer = localPlayer;
//	if ([localPlayer respondsToSelector:@selector(setAuthenticateHandler:)])
//    {
    blockLocalPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        progressHud = [[MBProgressHUD alloc]initWithView:[[CCDirector sharedDirector]view]];
//        progressHud.delegate = self;
//        progressHud.labelText = @"Loading";
//        [progressHud show:YES];
//        [[[CCDirector sharedDirector]view]addSubview:progressHud];
          if([[error domain] isEqualToString:GKErrorDomain] && [error code] == GKErrorCancelled){
            cancelCounter ++;
            
        }
        if(cancelCounter == 3){
            [self setLastError:error];
        }
        if ([CCDirector sharedDirector].isPaused)
            [[CCDirector sharedDirector] resume];
        
        if (localPlayer.authenticated) {
            _gameCenterFeaturesEnabled = YES;
            [[NSUserDefaults standardUserDefaults]setObject: @"" forKey:@"GameKitHelper"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"authenticated"];
            [self performGameCenterTask:workType];
        } else if(viewController) {
            NSLog(@"player not authenticated");
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"authenticated"];
            [[CCDirector sharedDirector] pause];
            [self presentViewController:viewController];
        } else {
            _gameCenterFeaturesEnabled = NO;
        }
    };
  //  [blockLocalPlayer release];
   // }
//    else{
//        if(!localPlayer.authenticated){
//        
//        }
//    }
}

-(void)performGameCenterTask:(int)workType{
    switch (workType) {
        case 1:
            [self submitScore:gameScore category:scoreCategory];
            break;
        case 2:
            [self submitAchievement:achivementIdentifier percentComplete:100.0f];
            break;
        case 3:
            [self showLeaderBoard];
        default:
            break;
    }
}

- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete{
//    if (!_gameCenterFeaturesEnabled) {
//        CCLOG(@"Player not authenticated");
//        return;
//    }
    achivementIdentifier = identifier;
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if([localPlayer isAuthenticated]){

        
    GKAchievement *achievement = [[GKAchievement alloc]initWithIdentifier:identifier];
        if([identifier isEqualToString:BrainPower]){
            percentComplete = ( [[GameData GameDataManager] getoveralltry]*4.0);
        }
        else if([identifier isEqualToString:PathofLearning]){
            //percentComplete = achievement.percentComplete+2.0;
            percentComplete=[[PlayerStatistics StatManager] getTotalCorrectRecord]*2.0;
        }
        else if([identifier isEqualToString:TowerBuilder]){
            percentComplete =  ([[GameData GameDataManager] returnlevel]*25.0);
            NSLog(@"Reporting TowerBuilder (submit) with %g ",([[GameData GameDataManager] returnlevel]*25.0));
        }
        else{
            percentComplete = 100.0f;
        }
    achievement.percentComplete = percentComplete;
    [self reportAchievementIdentifier:identifier percentComplete: percentComplete];
       // [achievement reportAchievementWithCompletionHandler:^(NSError *error){
       // [self setLastError:error];
       // BOOL success = (error == nil);
       // if([_delegate respondsToSelector:@selector(onAchievementSubmitted:)]){
       //     [_delegate onAchievementSubmitted:success];
       // }
    //}];
    }
//    else{
//        [self authenticateLocalPlayer:SubmitAchivement];
//    }
}

- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
    if (achievement)
    {
        achievement.percentComplete = percent;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                // if(isDebuggingOnlyThis)
                     NSLog(@"Something was wrong while reporting GC achievement");
             }
         }];
    }
}

-(void) submitScore:(int64_t)score category:(NSString*)category {
    //1: Check if Game Center features are enabled
//    if (!_gameCenterFeaturesEnabled) {
//        CCLOG(@"Player not authenticated");
//        return;
//    }
    gameScore = score;
    scoreCategory = category;
    //2: Create a GKScore object
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if([localPlayer isAuthenticated]){
        GKScore* gkScore = [[GKScore alloc] initWithCategory:category];
    
    //3: Set the score value
        gkScore.value = score;
    
    //4: Send the score to Game Center
        [gkScore reportScoreWithCompletionHandler:^(NSError* error) {
		 
		 [self setLastError:error];
		 
		 BOOL success = (error == nil);
		 
		 if ([_delegate respondsToSelector:@selector(onScoresSubmitted:)]) {
			 
                [_delegate onScoresSubmitted:success];
            }
        }];
    }
//    else{
//        [self authenticateLocalPlayer:SubmitScore];
//    }
}

-(void)showLeaderBoard{
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    if ([localPlayer isAuthenticated]) {
        
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if (leaderboardController != NULL)
        {
            leaderboardController.category = nil;
            leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
            leaderboardController.leaderboardDelegate = self;
            //leaderboardController.navigationItem.title = @"aljsd";
            
            [self presentViewController:leaderboardController ];
            
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"You are not signed in to Game Center. Please Sign in (from Settings, or the Game Center App) to access Challenges, Rankings, and Achievements." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Open Game Center", nil];
        [alert show];
        [alert release];
        //[self authenticateLocalPlayer:ShowLeaderBoard];
    }
    
}
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{

    UIViewController *rootviewController = [self getRootViewController];
    [rootviewController dismissViewControllerAnimated:YES completion:nil];
}

//-(void) findScoresOfFriendsToChallenge {
//    //1
//    GKLeaderboard *leaderboard = [[GKLeaderboard alloc] init];
//    
//    //2
//    leaderboard.category = kHighScoreLeaderboardCategory;
//    
//    //3
//    leaderboard.playerScope = GKLeaderboardPlayerScopeFriendsOnly;
//    
//    //4
//    leaderboard.range = NSMakeRange(1, 100);
//    
//    //5
//    [leaderboard loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
//		 
//		 [self setLastError:error];
//		 
//		 BOOL success = (error == nil);
//		 
//		 if (success) {
//			 if (!_includeLocalPlayerScore) {
//				 NSMutableArray *friendsScores = [NSMutableArray array];
//				 
//				 for (GKScore *score in scores) {
//					 if (![score.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
//						 [friendsScores addObject:score];
//					 }
//				 }
//				 scores = friendsScores;
//			 }
//			 if ([_delegate
//				  respondsToSelector:
//				  @selector
//				  (onScoresOfFriendsToChallengeListReceived:)]) {
//				 
//				 [_delegate
//				  onScoresOfFriendsToChallengeListReceived:scores];
//			 }
//		 }
//	 }];
//}

-(void) getPlayerInfo:(NSArray*)playerList {
    //1
    if (_gameCenterFeaturesEnabled == NO)
        return;
    
    //2
    if ([playerList count] > 0) {
        [GKPlayer
		 loadPlayersForIdentifiers:
		 playerList
		 withCompletionHandler:
		 ^(NSArray* players, NSError* error) {
             
			 [self setLastError:error];
             
			 if ([_delegate
				  respondsToSelector:
				  @selector(onPlayerInfoReceived:)]) {
				 
				 [_delegate onPlayerInfoReceived:players];
			 }
         }];
	}
}

//-(void) sendScoreChallengeToPlayers:(NSArray*)players withScore:(int64_t)score message:(NSString*)message {
//    //1
//    GKScore *gkScore = [[GKScore alloc] initWithCategory:kHighScoreLeaderboardCategory];
//    gkScore.value = score;
//    
//    //2
//    [gkScore issueChallengeToPlayers:players message:message];
//}
//
//-(void) showFriendsPickerViewControllerForScore:(int64_t)score {
//    FriendsPickerViewController
//	*friendsPickerViewController =
//	[[FriendsPickerViewController alloc]
//	 initWithScore:score];
//    
//    friendsPickerViewController.
//	cancelButtonPressedBlock = ^() {
//        [self dismissModalViewController];
//    };
//    
//    friendsPickerViewController.
//	challengeButtonPressedBlock = ^() {
//        [self dismissModalViewController];
//    };
//    
//    UINavigationController *navigationController =
//	[[UINavigationController alloc]
//	 initWithRootViewController:
//	 friendsPickerViewController];
//    
//    [self presentViewController:navigationController];
//}

#pragma mark Property setters
-(void) setLastError:(NSError*)error {
    _lastError = [error copy];
	if (_lastError) {
//        [[NSUserDefaults standardUserDefaults]setObject:[[_lastError userInfo] description] forKey:@"GameKitHelper"];
//		if(_lastError.code == 2){
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"This feature is disabled.Plz sign in" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//            [alertView show];
//            [alertView release];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Game Center"
                                  message:@"If Game Center is disabled try logging in through the Game Center app"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:@"Open Game Center", nil];
        [alertView show];
        [alertView release];
        }

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
    }
}
#pragma mark UIViewController stuff

-(UIViewController*) getRootViewController {
	return [UIApplication sharedApplication].keyWindow.rootViewController;
}

-(void) presentViewController:(UIViewController*)vc {
	UIViewController* rootVC = [self getRootViewController];
    [progressHud removeFromSuperview];
	[rootVC presentViewController:vc animated:YES completion:nil];
}

-(void) dismissModalViewController {
    UIViewController* rootVC = [self getRootViewController];
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

@end
