//
//  Myquslist.m
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import "Myquslist.h"
#import "QusList.h"
#import "Quest.h"
#import "ClueList.h"
#import "GameData.h"
#import "PlayerStatistics.h"
#import "Achivement.h"
@implementation Myquslist

-(NSMutableArray *)getQusList{
    NSMutableArray *qusArray = [[NSMutableArray alloc]init];
    @try {
        NSFileManager *filemngr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"kwst.sqlite"];
        bool success = [filemngr fileExistsAtPath:dbPath];
        if(!success){
            NSLog(@"can not locate db file %@",dbPath);
        }
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
        
        }
        const char *sql ="SELECT * from QDB";
         NSLog(@"%s",sql);
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(data), sqlite3_errcode(data));
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            QusList *quslist = [[QusList alloc]init];
            quslist.q_id = sqlite3_column_int(sqlStatement, 0);
            quslist.qus = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            quslist.opt1 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            quslist.opt2 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            quslist.opt3 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            quslist.opt4 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            quslist.correct = sqlite3_column_int(sqlStatement,6);
            quslist.type = sqlite3_column_int(sqlStatement, 8);
            quslist.difficulty = sqlite3_column_int(sqlStatement, 7);
            // quslist.leader = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
           quslist.subtype = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
            [qusArray addObject:quslist];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        return qusArray;
    }
}

-(int)getQusCount:(int)type{
    
    int count=0;
   
    //NSMutableArray *qusArray = [[NSMutableArray alloc]init];
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        const char *sql;
        if(type==1)
            sql="SELECT count(*)from QDB where topic=1";
        else if(type==2)
            sql="SELECT count(*)from QDB where topic=2";
        else if(type==3)
            sql="SELECT count(*)from QDB where topic=3";
        else 
            sql="SELECT count(*)from QDB where topic=4";
        NSLog(@"%s",sql);
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            //NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            count = sqlite3_column_int(sqlStatement, 0);
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        NSLog(@"count=%d",count);
        return count;
    }
}


-(NSMutableArray*)getPlayerInfo{
    NSMutableArray *playerinfo = [[NSMutableArray alloc]init];
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        const char *sql ="SELECT *from Player"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            QusList *quslist = [[QusList alloc]init];
             quslist.playername =    [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)]; 
           
            [playerinfo addObject:quslist];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        return playerinfo;
    }

}
-(NSMutableArray *)getQuestList{
    NSMutableArray *qusArray = [[NSMutableArray alloc]init];
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
      /*  NSFileManager *filemngr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"kwst.sqlite"];
        bool success = [filemngr fileExistsAtPath:dbPath];
        if(!success){
            NSLog(@"can not locate db file %@",dbPath);
        }*/
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        const char *sql ="SELECT q_id,solved from Quest"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            Quest *questlist = [[Quest alloc]init];
            questlist.q_id = sqlite3_column_int(sqlStatement, 0);
          //  questlist.q_name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            questlist.solved = sqlite3_column_int(sqlStatement, 1);
//            questlist.hint1 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
//            questlist.hint2 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
//            questlist.levelactive = sqlite3_column_int(sqlStatement, 5);
//            questlist.no_of_hint = sqlite3_column_int(sqlStatement, 6);
//            questlist.ishintused = sqlite3_column_int(sqlStatement, 7);
            [qusArray addObject:questlist];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        return qusArray;
    }
}

-(void)updateQuestSolved:(NSInteger)solvedVal :(NSInteger)q_id{
   
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    /*NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success=[fileManager fileExistsAtPath:databasePath];
    
    if (!success) {
        
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        
        // Copy the database from the package to the users filesystem
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];  
    }
    else{
        NSLog(@"file Exists");
    }*/
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Quest set solved = %d where q_id = %d",solvedVal,q_id ];
        NSLog(@"querystr=%@",querystr);
      //  const char *sql ="Update Quest set solved=? where q_id=?"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
       /* sqlite3_bind_int(sqlStatement, 0, q_id+1);
        sqlite3_bind_int(sqlStatement, 2 , solved);  
        char* errmsg;
        sqlite3_exec(data, "COMMIT", NULL, NULL, &errmsg);
        
        if(SQLITE_DONE != sqlite3_step(sqlStatement))
            NSLog(@"Error while updating. %s", sqlite3_errmsg(data));
        else 
             sqlite3_reset(sqlStatement);
        *///      
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }

}
-(void)updateQuestHint:(BOOL)isUsed :(NSInteger)q_id{
    NSLog(@"q_id%d",q_id);
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
 
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Quest set isHintused = %d where q_id = %d",isUsed,q_id+1 ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
    
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }
    
}


-(NSMutableArray*)getClueList{

    NSMutableArray *qusArray = [[NSMutableArray alloc]init];
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
     
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        const char *sql ="SELECT *from Clues"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            ClueList *questlist = [[ClueList alloc]init];
            questlist.clue_id = sqlite3_column_int(sqlStatement, 0);
            questlist.clue_name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            questlist.questno = sqlite3_column_int(sqlStatement, 2);
            questlist.locked = sqlite3_column_int(sqlStatement, 3);
            questlist.cost = sqlite3_column_double(sqlStatement, 4);
            [qusArray addObject:questlist];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        return qusArray;
    }
}

-(void)updateClues:(int)locked :(NSInteger)clue_id{
  //  NSLog(@"q_id%d",q_id);
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];

    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Clues set locked = %d where id = %d",locked,clue_id+1 ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?"; 
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
    
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }
    
}




-(void)copyToFileManager{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success=[fileManager fileExistsAtPath:databasePath];
    
    if (!success) {
        
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        
        // Copy the database from the package to the users filesystem
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];  
    }
    else{
        NSLog(@"file Exists");
    }

}

-(int)isBought:(int)idPrimary{
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
        NSString *sqlString = [NSString stringWithFormat:@"SELECT isLocked from Flag where id =%d",idPrimary];
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
-(void)upDateFlagTable:(int)idPrimary{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    

    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Flag set isLocked = 1 where id = %d",idPrimary ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
    
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }

}
-(void)updataPlayerData{
      
}
-(int)getKnopThreshold:(int)level{
    int threshold;
   
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT knopthreshold from Level where level =%d",level];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            threshold = sqlite3_column_int(sqlStatement, 0);
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return threshold;
    }
    

}

-(BOOL)getMissionFlag:(int)primaryId{
    BOOL isCompleted=FALSE;
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
        NSString *sqlString = [NSString stringWithFormat:@"SELECT completed from missionflag where id =%d",primaryId];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            isCompleted = sqlite3_column_int(sqlStatement, 0);
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return isCompleted;
    }

}

-(void)upDatemissionFlagTable:(int)idPrimary{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update missionflag set completed = 1 where id = %d",idPrimary ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }
    
}
-(int)getQuestSolvedNumber{
    int solved=0;
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT count(*) from Quest where solved =1"];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            solved = sqlite3_column_int(sqlStatement, 0);
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return solved;
    }
}

-(void)resetMissionFlag{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update missionFlag set completed = 0"];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }


}

-(void)resetFlag{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Flag set isLocked = 0"];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }

}

-(void)resetClue{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Clues set locked = 0 "];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }

}

-(void)resetPlayerData{
    [[GameData GameDataManager]setknop:0.0f];
    [[GameData GameDataManager]setgold:0.0f];
    [[GameData GameDataManager]setLevel:0];
}

-(void)resetKStat{
    [[PlayerStatistics StatManager]setScienceTryRecord:0];
    [[PlayerStatistics StatManager]setSciencecorrectRecord:0];
    [[PlayerStatistics StatManager]setSciencePercentRecord:0.0f];
    [[PlayerStatistics StatManager]setDeeperTryRecord:0];
    [[PlayerStatistics StatManager]setDeeperPercentRecord:0.0f];
    [[PlayerStatistics StatManager]setDeepercorrectRecord:0];
    [[PlayerStatistics StatManager]setHumanitiescorrectRecord:0];
    [[PlayerStatistics StatManager]setHumanitiesTryRecord:0];
    [[PlayerStatistics StatManager]setHumanitiesPercentRecord:0.0];
    [[PlayerStatistics StatManager]setLogicTryRecord:0];
    [[PlayerStatistics StatManager]setLogiccorrectRecord:0];
    [[PlayerStatistics StatManager]setLogicPercentRecord:0.0f];
}

-(void)resetLStat{
    [[GameData GameDataManager]setMemoryavg:0.0f];
    [[GameData GameDataManager]setMemorybest:0];
    [[GameData GameDataManager]setMemoryLast:0];
    [[GameData GameDataManager]setEnduranceavg:0.0f];
    [[GameData GameDataManager]setEndurancebest:0];
    [[GameData GameDataManager]setEnduranceLast:0];
    [[GameData GameDataManager]setSprintavg:0.0f];
    [[GameData GameDataManager]setSprintBest:0.0f];
    [[GameData GameDataManager]setSprintLast:0.0f];
    [[GameData GameDataManager]setsprinttry:0];
    [[GameData GameDataManager]setmemorytry:0];
    [[GameData GameDataManager]setendurancetry:0];
}

-(void)resetQuest{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update Quest set solved = 0 "];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }

}

-(NSMutableArray *)getKnopThresholds{
    NSMutableArray *knopThresholds = [[NSMutableArray alloc]init];
    int threshold;
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT knopthreshold from Level "];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            threshold = sqlite3_column_int(sqlStatement, 0);
            [knopThresholds addObject:[NSNumber numberWithInt:threshold]];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return knopThresholds;
    }

}
-(NSString *)getEraName:(int)level{
    NSString *eraName;
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"SELECT quality from Level where level = %d",level];
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            eraName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
//            threshold = sqlite3_column_int(sqlStatement, 0);
//            [knopThresholds addObject:[NSNumber numberWithInt:threshold]];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        //    sqlite3_close(data);
        return eraName;
    }
}

-(NSMutableArray*)getUnsendAchivements{
    NSMutableArray *unsendAchivementArray = [[NSMutableArray alloc]init];
    @try {
        NSString *databaseName = @"kwst.sqlite";
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        if(!sqlite3_open([databasePath UTF8String],&data)==SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *sqlString = @"SELECT achiviementIdentifier from achivement where isAchived = 0";
        const char *sql =[sqlString UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            // Flag *flag = [[Flag alloc]init];
            Achivement *achivement = [[Achivement alloc]init];
            achivement.idPrimary = sqlite3_column_int(sqlStatement, 0);
            [unsendAchivementArray addObject:achivement];
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
                               @finally{
                                   return unsendAchivementArray;
                               }
                               
}

-(void)updateAchivementAchiveStatus:(NSString*)idPrimary{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(sqlite3_open([databasePath UTF8String],&data)!=SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update achivement set isAchived  = 1 where achivedIdentifier = \'%@'",idPrimary ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        else{
           NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(data), sqlite3_errcode(data));
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception.name);
    }
    @finally {
        sqlite3_close(data);
        
    }

}
-(void)updateAchivementSendStatus:(NSString*)idPrimary{
    NSString *databaseName = @"kwst.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    @try {
        if(sqlite3_open([databasePath UTF8String],&data)!=SQLITE_OK){
            NSLog(@"An error occured");
            
        }
        NSString *querystr = [NSString stringWithFormat:@"Update achivement set isSend  = 1 where achivementIdentifier = %@",idPrimary ];
        NSLog(@"querystr=%@",querystr);
        //  const char *sql ="Update Quest set solved=? where q_id=?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(data , [querystr UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(sqlStatement);
            NSLog(@"query executed");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured:%@",exception);
    }
    @finally {
        sqlite3_close(data);
        
    }
    
}

@end
