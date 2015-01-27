//
//  GameKitHelper.h
//  MonkeyJump
//
//  Created by Fahim Farook on 18/8/12.
//
//

//   Include the GameKit framework
#import <GameKit/GameKit.h>
#define BrainPower      @"Brain_Power"
#define PathofLearning  @"Learning_Path"
#define TowerBuilder    @"TowerBuilder"
#define MysterySolver   @"MysterySolver"
#define BalancedPower   @"BalancedPower"
#define Saga            @"Sage"
//   Protocol to notify external
//   objects when Game Center events occur or
//   when Game Center async tasks are completed
@protocol GameKitHelperProtocol<NSObject>
@optional
-(void) onAchievementSubmitted:(bool)success;
-(void) onScoresSubmitted:(bool)success;
-(void) onScoresOfFriendsToChallengeListReceived:(NSArray*)scores;
-(void) onPlayerInfoReceived:(NSArray*)players;
@end

@class MBProgressHUD;
@interface GameKitHelper : NSObject<GKLeaderboardViewControllerDelegate>{
    int64_t gameScore;
    NSString *scoreCategory;
    NSString *achivementIdentifier;
    MBProgressHUD *progressHud;
    int cancelCounter;
}

@property (nonatomic, assign) id<GameKitHelperProtocol> delegate;

// This property holds the last known error
// that occured while using the Game Center API's
@property (nonatomic, readonly) NSError* lastError;

@property (nonatomic, readwrite) BOOL includeLocalPlayerScore;

+ (id) sharedGameKitHelper;

// Player authentication, info
-(void) authenticateLocalPlayer :(int)workType;
// Scores
-(void) submitScore:(int64_t)score category:(NSString*)category;
-(void) findScoresOfFriendsToChallenge;
-(void) getPlayerInfo:(NSArray*)playerList;
-(void)showLeaderBoard;
- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete;
//-(void) sendScoreChallengeToPlayers:(NSArray*)players withScore:(int64_t)score message:(NSString*)message;
//-(void)showFriendsPickerViewControllerForScore:(int64_t)score;
@end
