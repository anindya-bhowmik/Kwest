//
//  FBShareViewController.m
//  kwestFinal
//
//  Created by Anindya on 11/3/13.
//  Copyright (c) 2013 Anindya. All rights reserved.
//

#import "FBShareViewController.h"
#import "GameData.h"
@interface FBShareViewController ()

@end

@implementation FBShareViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithFrame:(CGRect)frame IntialText:(NSString*)initialText ShareImage:(UIImage*)shareImage ShareUrl:(NSURL*)shareUrl{
    if(self = [super init]){
        self.view.frame = frame;
        textToShareInitially = initialText;
        imageToShare = shareImage;
        urlToShare = shareUrl;
        imageArray = [[NSArray alloc]initWithObjects:imageToShare, nil];
        urlArray = [[NSArray alloc]initWithObjects:urlToShare, nil];
    }
    return self;
}

-(void)shareinFB:(BOOL)isUscore{
    [FBDialogs presentOSIntegratedShareDialogModallyFrom:self initialText:textToShareInitially images:imageArray urls:urlArray handler:^(FBOSIntegratedShareDialogResult result ,NSError *error){
        if(error == nil){
        if(result == FBOSIntegratedShareDialogResultCancelled) {
            NSLog(@"Error: %@", error.description);
        } else if(result ==FBOSIntegratedShareDialogResultSucceeded)  {
            NSLog(@"Success!");
            if(isUscore){
                [Flurry logEvent:@"UScore_Share"];
            }
            else{
                if(![[GameData GameDataManager]getFirstTimeShared]){
                    [[GameData GameDataManager]setFirstTimeShared:TRUE];
                    int currentGold = [[GameData GameDataManager]returngold];
                    [[GameData GameDataManager]setgold:currentGold+50];
                }
            }
        }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Facebook Account Available" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Settings", nil];
                [alert show];
            });
        }
    }];

}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
         [NSURL URLWithString:@"prefs://root=General&path=About"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
