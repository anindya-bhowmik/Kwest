//
//  InAppPurchase.m
//  kwest
//
//  Created by Anindya on 10/23/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "InAppPurchase.h"
#import "GameData.h"
#import "cocos2d.h"
#define purchaseAlert 10001
NSString * identifier ;
@implementation InAppPurchase

-(id)init{
    if(self = [super init]){
        
    }
    return self;
}

-(void)startPurchaseWithIdentifier:(NSString*)itemIdentifier{
    progressHud = [[MBProgressHUD alloc]initWithView:[[CCDirector sharedDirector]view]];
    progressHud.delegate = self;
	progressHud.labelText = @"Loading";
    [progressHud show:YES];
    identifier = itemIdentifier;
//
//	progressHud.square = YES;
//    dispatch_async(dispatch_get_main_queue(), ^{
//    activityAlert = [[UIAlertView alloc]initWithTitle:@"Connecting" message:@"\n" delegate:nil cancelButtonTitle:NULL otherButtonTitles: nil];
//   UIActivityIndicatorView *authenActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130.0f, 50.0f, 20.0f, 20.0f)];
//        [activityAlert addSubview:authenActivityIndicator];
//    [authenActivityIndicator startAnimating];
//    [activityAlert show];
//        });
	
//	[progressHud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    [[[CCDirector sharedDirector]view]addSubview:progressHud];
  
    //[MBProgressHUD showHUDAddedTo:[[CCDirector sharedDirector]openGLView] animated:YES];
    transactionIsComplete = FALSE;
    SKProductsRequest *request= [[SKProductsRequest alloc]
                                 initWithProductIdentifiers: [NSSet setWithObject: itemIdentifier]];
    request.delegate = self;
    [request start];
}

-(void)restorePurchaseWithIdentifier:(NSString*)itemIdentifier{
    //progressHud = [[MBProgressHUD alloc]initWithView:[[CCDirector sharedDirector]view]];
    //progressHud.delegate = self;
	//progressHud.labelText = @"Loading";
    //[progressHud show:YES];
    identifier = itemIdentifier;
    //
    //	progressHud.square = YES;
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //    activityAlert = [[UIAlertView alloc]initWithTitle:@"Connecting" message:@"\n" delegate:nil cancelButtonTitle:NULL otherButtonTitles: nil];
    //   UIActivityIndicatorView *authenActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130.0f, 50.0f, 20.0f, 20.0f)];
    //        [activityAlert addSubview:authenActivityIndicator];
    //    [authenActivityIndicator startAnimating];
    //    [activityAlert show];
    //        });
	
    //	[progressHud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    //[[[CCDirector sharedDirector]view]addSubview:progressHud];
    
    //[MBProgressHUD showHUDAddedTo:[[CCDirector sharedDirector]openGLView] animated:YES];
    transactionIsComplete = FALSE;
    //SKProductsRequest *request= [[SKProductsRequest alloc]
    //                             initWithProductIdentifiers: [NSSet setWithObject: itemIdentifier]];
    //request.delegate = self;
    //[request start];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


//- (void)myTask {
//	// Do something usefull in here instead of sleeping ...
//	sleep(3);
//}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    NSArray *myProduct = response.products;
    NSLog(@"%@",[[myProduct objectAtIndex:0] productIdentifier]);
    
    //Since only one product, we do not need to choose from the array. Proceed directly to payment.
    
    SKPayment *newPayment = [SKPayment paymentWithProduct:[myProduct objectAtIndex:0]];
    [[SKPaymentQueue defaultQueue] addPayment:newPayment];
    
    [request autorelease];
    //[activityAlert setHidden:YES];
    //[MBProgressHUD hideHUDForView:[[CCDirector sharedDirector]openGLView] animated:YES];
}
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.userInfo);
    request = nil;
   // _productsRequest = nil; // <<<--- This will release the request object
    [progressHud removeFromSuperview];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
   // [activityAlert release];
    for (SKPaymentTransaction *transaction in transactions)
    {
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                [progressHud show:YES]; // this creates an alertView and shows
                break;
            case SKPaymentTransactionStatePurchased:
                [progressHud removeFromSuperview];
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [progressHud removeFromSuperview];
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{

    NSString *successString ;
   // [activityAlert setHidden:YES];
    NSLog(@"Transaction Completed");
    if(!transactionIsComplete){
        transactionIsComplete = TRUE;
        if([identifier isEqualToString:@" 1700_Gold_Kwest"]){
            successString =  @"You have suceessfully purchased 1700 pieces of Gold.";
            [[GameData GameDataManager]setgold:[[GameData GameDataManager]returngold]+1700 ];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"InAppPurchase" object:nil];
        }
        else if([identifier isEqualToString:@"4000_gold_kwest"]){
            successString =  @"You have suceessfully purchased 4000 pieces of Gold.";
            [[GameData GameDataManager]setgold:[[GameData GameDataManager]returngold]+4000 ];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"InAppPurchase" object:nil];
        }
        else if([identifier isEqualToString:@"6500_gold_kwest"]){
            successString =  @"You have suceessfully purchased 6500 pieces of Gold.";
            [[GameData GameDataManager]setgold:[[GameData GameDataManager]returngold]+6500 ];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"InAppPurchase" object:nil];
        }
        else{
            successString =  @"You have suceessfully upgraded to Premium.";
            [[GameData GameDataManager]setEnergy:75];
            [[GameData GameDataManager]setpremium:YES];
        }
        
        UIAlertView *succesAlert = [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:successString delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [succesAlert show];
        [succesAlert release];
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
       // [[NSNotificationCenter defaultCenter]postNotificationName:@"InAppPurchase" object:nil];
    }
    // You can create a method to record the transaction.
    // [self recordTransaction: transaction];
    
    // You should make the update to your app based on what was purchased and inform user.
    // [self provideContent: transaction.payment.productIdentifier];
    
    // Finally, remove the transaction from the payment queue.
    
}
- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Restored");
    // You can create a method to record the transaction.
    // [self recordTransaction: transaction];
    
    // You should make the update to your app based on what was purchased and inform user.
    // [self provideContent: transaction.payment.productIdentifier];
    if (!transactionIsComplete)
    {
        transactionIsComplete=TRUE;
        
    [[GameData GameDataManager]setEnergy:75];
    [[GameData GameDataManager]setpremium:YES];

UIAlertView *succesAlert = [[UIAlertView alloc]initWithTitle:@"Successful" message:@"Restore Successful." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
[succesAlert show];
[succesAlert release];


    // Finally, remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    //    [progressHud removeFromSuperview];
    }
}


/*- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    purchasedItemIDs = [[NSMutableArray alloc] init];
    
    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productID = transaction.payment.productIdentifier;
        [purchasedItemIDs addObject:productID];
    }
    
}*/

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    NSLog(@"transactionerrorcode = %d",transaction.error.code);
    //  [activityIndicator stopAnimating];
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"transaction error = %@",transaction.error.userInfo);
        // Display an error here.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Unsuccessful"
                                                        message:@"Your purchase failed. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    // Finally, remove the transaction from the payment queue.
  
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == BuyGoldAlert){
        if (buttonIndex == 1) {
            [self showStoreInfo];
        }
    }
    else if(alertView.tag == purchaseAlert){
        if(buttonIndex!=0){
            NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
            identifier =[self productIdentifier:buttonTitle];
            [self startPurchaseWithIdentifier:identifier];
        }
    }
}

-(NSString*)productIdentifier:(NSString*)btnTitle{
    //NSString *identifier = @"";
    if([btnTitle isEqualToString:@"1700 Pieces"]){
        return @" 1700_Gold_Kwest";
    }
    else if([btnTitle isEqualToString:@"4000 Pieces"]){
        return @"4000_gold_kwest";
    }
    else if([btnTitle isEqualToString:@"6500 Pieces"]){
        return @"6500_gold_kwest";
    }
    return nil;
}

-(void)showStoreInfo{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Buy Gold" message:@"Gold can be very useful in unlocking Keys and Buying many items in the game. How much Gold do you need:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"6500 Pieces",@"4000 Pieces",@"1700 Pieces", nil];
    alert.tag = purchaseAlert;
    [alert show];
}
@end
