//
//  FBShareViewController.h
//  kwestFinal
//
//  Created by Anindya on 11/3/13.
//  Copyright (c) 2013 Anindya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface FBShareViewController : UIViewController{
    NSString *textToShareInitially;
    UIImage *imageToShare;
    NSURL *urlToShare;
    NSArray *imageArray;
    NSArray *urlArray;

}
-(id)initWithFrame:(CGRect)frame IntialText:(NSString*)initialText ShareImage:(UIImage*)shareImage ShareUrl:(NSURL*)shareUrl;
-(void)shareinFB:(BOOL)isUscore;
@end
