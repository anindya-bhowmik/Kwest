    //
//  ClueFlag.m
//  kwest
//
//  Created by Anindya on 6/11/13.
//  Copyright (c) 2013 AITL. All rights reserved.
//

#import "ClueFlag.h"
#import "ClueList.h"
static ClueFlag *ClueFlags = nil;
@implementation ClueFlag
+(id) ClueFlags{
    @synchronized(self){
        if(ClueFlags  ==nil)
            ClueFlags = [[super allocWithZone:NULL]init];
    }
    return ClueFlags;
}
+(id)allocWithZone:(NSZone *)zone{
    return [[self ClueFlags]retain];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}

-(id)init{
    if(self = [super init]){
    
    }
    return self;
}

-(BOOL)checkClueFlag:(int)clueNum{
    int isLocked=-99;
    // Flag *flag;
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT locked from Clues where id =%d",clueNum];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            isLocked = sqlite3_column_int(sqlStatement, 0);
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return isLocked;
    }
}

-(void)updateClueFlag:(int)clueNum{
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"Update Clues set locked = 1 where id =%d",clueNum];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) == SQLITE_OK)
        {
          //  NSLog(@"Problem with prepare statement");
        
        sqlite3_step(sqlStatement);
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
}

-(int)getPrice:(int)clueNum{
    int price;
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT cost from Clues where id =%d",clueNum];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            price = sqlite3_column_int(sqlStatement, 0);
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return price;
    }

    return price;
}


@end
