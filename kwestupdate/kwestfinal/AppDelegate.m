//
//  AppDelegate.m
//  kwestFinal
//
//  Created by Anindya on 10/25/13.
//  Copyright Anindya 2013. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "Menu.h"
#import "GameKitHelper.h"
#import <RevMobAds/RevMobAds.h>
#import <Chartboost/Chartboost.h>
@implementation MyNavigationController

// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskPortrait;
	
	// iPad only
	return UIInterfaceOrientationMaskPortrait;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	
	// iPad only
	// iPhone only
	 return UIInterfaceOrientationIsPortrait(interfaceOrientation);
;
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		//[director runWithScene: [IntroLayer scene]];
      //  [[GCHelper sharedInstance] authenticateLocalUser];
        [director runWithScene:[ CCTransitionZoomFlipX transitionWithDuration:1.0 scene:[Menu scene]]];
	}
}
@end


@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [RevMobAds startSessionWithAppID:@"52388ed55c66470367000003"];
    //[RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"FFG4RM5DSRM69W2CM7Z5"];
    [Chartboost startWithAppId:@"54d0817f0d602505919d40aa"
                  appSignature:@"561700fb558697eddfdc34e97b84cfc548c8f0a5"
                      delegate:self];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	// CCGLView creation
	// viewWithFrame: size of the OpenGL view. For full screen use [_window bounds]
	//  - Possible values: any CGRect
	// pixelFormat: Format of the render buffer. Use RGBA8 for better color precision (eg: gradients). But it takes more memory and it is slower
	//	- Possible values: kEAGLColorFormatRGBA8, kEAGLColorFormatRGB565
	// depthFormat: Use stencil if you plan to use CCClippingNode. Use Depth if you plan to use 3D effects, like CCCamera or CCNode#vertexZ
	//  - Possible values: 0, GL_DEPTH_COMPONENT24_OES, GL_DEPTH24_STENCIL8_OES
	// sharegroup: OpenGL sharegroup. Useful if you want to share the same OpenGL context between different threads
	//  - Possible values: nil, or any valid EAGLSharegroup group
	// multiSampling: Whether or not to enable multisampling
	//  - Possible values: YES, NO
	// numberOfSamples: Only valid if multisampling is enabled
	//  - Possible values: 0 to glGetIntegerv(GL_MAX_SAMPLES_APPLE)
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565
								   depthFormat:0
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
	
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:NO];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if( ! [director_ enableRetinaDisplay:YES] )
            CCLOG(@"Retina Display Not supported");
    }
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change this setting at any time.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:YES];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
 
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
    [sharedFileUtils setiPhoneFiveRetinaDisplaySuffix:@"-iphone5hd"];
	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    Myquslist *ss = [[Myquslist alloc]init];
    [ss copyToFileManager];
    [ss release];
	// Create a Navigation Controller with the Director
    
    //[[GCHelper sharedInstance] authenticateLocalUser];
	navController_ = [[MyNavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;

	// for rotation and other messages
	[director_ setDelegate:navController_];
		// set the Navigation Controller as the root view controller
	[window_ setRootViewController:navController_];
    UIViewController *temp = [[UIViewController alloc]init];
    [[[CCDirector sharedDirector]view ]addSubview:temp.view];
//	GameCenterManager *gameCenterManager = [[GameCenterManager alloc]init];
//    [gameCenterManager authenticateLocalUser:temp];
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer:44];
	// make main window visible
	[window_ makeKeyAndVisible];
    
    
	return YES;
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
//    Chartboost *cb = [Chartboost sharedChartboost];
//    
//    cb.appId = @"5314552cf8975c4d3043299f";
//    cb.appSignature = @"35cf6cb0e44f852b82ae8f8229688e084e840100";
    
    // Required for use of delegate methods. See "Advanced Topics" section below.
   // cb.delegate = self;
    
    // Begin a user session. Must not be dependent on user actions or any prior network requests.
    // Must be called every time your app becomes active.
    //[cb startSession];
    
    // Show an interstitial
  //  [cb showInterstitial];
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];	
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (BOOL)shouldRequestInterstitialsInFirstSession {
    return NO;
}
- (void)didFailToLoadInterstitial:(NSString *)location  withError:(CBLoadError)error{
    [[RevMobAds session] showFullscreen];
    NSLog(@"ChartBoost erro _%d",error);
}

- (void)didFailToLoadRewardedVideo:(CBLocation)location
                         withError:(CBLoadError)error{
    
}
- (void)didDisplayRewardedVideo:(CBLocation)location{
    
}
- (void)didDismissRewardedVideo:(CBLocation)location{

}
- (void)didCloseRewardedVideo:(CBLocation)location{

}

- (void)didCompleteRewardedVideo:(CBLocation)location
                      withReward:(int)reward{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"vid_popup_displayed_today"];
    GameData *gamedata = [GameData GameDataManager];
    [gamedata setEnergy:[gamedata returnenergy]+50];
    [gamedata setgold:[gamedata returngold]+100];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Award" message:@"You are awarded with 50 Energy and 100 gold for watching the ad" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
        [alert release];
    });
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"videoWatched" object:nil];
}
+ (void)initialize {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // initialize the dictionary with default values
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:NO], @"notFirst",
                                [NSNumber numberWithBool:YES], @"allowPop",
                                 [NSNumber numberWithBool:YES], @"revAskAllow",
                                 [NSNumber numberWithBool:YES], @"mailFeedAsk",
                                 [NSNumber numberWithBool:YES], @"Allow1K",
                                 [NSNumber numberWithBool:YES], @"Allow2K",
                                 [NSNumber numberWithBool:YES], @"Allow4K",
                                 [NSNumber numberWithBool:YES], @"Allow5K",
                                 [NSNumber numberWithBool:YES], @"Allow10K",
                                 [NSNumber numberWithBool:YES], @"Allow50K",
                                 [NSNumber numberWithBool:YES], @"Allow100K",
                                 [NSNumber numberWithBool:YES], @"Allow200K",
                                 [NSNumber numberWithBool:YES], @"Allow1F",
                                 nil];
   //NSDictionary *dict = [NSDictionary dictiona]
   //NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
   //                              [NSNumber numberWithInt: 2], K_CACHE_SIZE_INDEX,
   //                              K_STRING_DEFAULT_USERNAME, K_USERNAME_KEY,
   //                              [NSNumber numberWithBool: TRUE], K_USE_CLICKSOUNDS_KEY,
    //                             [NSNumber numberWithBool: TRUE], K_FIRST_LAUNCH_KEY,
    //                             nil];
    //if([defaults boolForKey:@"cancelTutP"] == nil)
    //{
   // [defaults setBool:FALSE forKey:@"notFirst"];
    //[defaults setInteger:0 forKey:@"OptionsCounter"];
   // [defaults setBool:TRUE forKey:@"allowPop"];
   // [defaults setBool:TRUE forKey:@"revAskAllow"];

    //}
    // and set them appropriately
    [defaults registerDefaults:appDefaults];
    
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"revAskAllow"]) {
    //    NSLog(@"IT IS SET TO TRUE");
    //}
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	
	[super dealloc];
}
@end
