//
//  ClueFlag.h
//  kwest
//
//  Created by Anindya on 6/11/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface ClueFlag : NSObject{
    sqlite3 *data;
}
+(id) ClueFlags;
-(BOOL)checkClueFlag:(int)clueNum;
-(int)getPrice:(int)clueNum;
-(void)updateClueFlag:(int)clueNum;
@end
