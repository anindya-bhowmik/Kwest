//
//  AppDelegate.h
//  kwestFinal
//
//  Created by Anindya on 10/25/13.
//  Copyright Anindya 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import <Chartboost/Chartboost.h>
// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate,ChartboostDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
