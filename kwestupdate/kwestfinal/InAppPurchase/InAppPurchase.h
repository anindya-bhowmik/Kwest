//
//  InAppPurchase.h
//  kwest
//
//  Created by Anindya on 10/23/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MBProgressHUD.h"

#define BuyGoldAlert 10000

@class MBProgressHUD;
@interface InAppPurchase : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver,MBProgressHUDDelegate>{
    MBProgressHUD *progressHud;
     UIAlertView *activityAlert;
    BOOL transactionIsComplete;
    
}


-(void)startPurchaseWithIdentifier:(NSString*)itemIdentifier;
-(void)restorePurchaseWithIdentifier:(NSString*)itemIdentifier;
-(void)showStoreInfo;
@end
