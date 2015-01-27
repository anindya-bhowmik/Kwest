//
//  PlayerStatistics.h
//  kwest
//
//  Created by Tashnuba Jabbar on 09/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStatistics : NSObject{
    NSUserDefaults *Sciencetry;
    NSUserDefaults *Sciencecorrect;
    NSUserDefaults *Sciencepercent;
    
    NSUserDefaults *Logictry;
    NSUserDefaults *Logiccorrect;
    NSUserDefaults *Logicpercent;
    
    NSUserDefaults *Humanitiestry;
    NSUserDefaults *Humanitiescorrect;
    NSUserDefaults *Humanitiespercent;
    
    NSUserDefaults *Deepertry;
    NSUserDefaults *Deepercorrect;
    NSUserDefaults *Deeperpercent;
    
    NSUserDefaults *Totaltry;
    NSUserDefaults *Totalcorrect;
    NSUserDefaults *Totalrate;
}
+(id) StatManager;



-(void)setScienceTryRecord:(NSInteger)num;
-(void)setSciencecorrectRecord:(NSInteger)num;
-(void)setSciencePercentRecord:(float)num;
-(NSInteger)getScienceTryRecord;
-(NSInteger)getScienceCorrectRecord;
-(float)getSciencePercentRecord;

-(void)setLogicTryRecord:(NSInteger)num;
-(void)setLogiccorrectRecord:(NSInteger)num;
-(void)setLogicPercentRecord:(float)num;
-(NSInteger)getLogicTryRecord;
-(NSInteger)getLogicCorrectRecord;
-(float)getLogicPercentRecord;

-(void)setHumanitiesTryRecord:(NSInteger)num;
-(void)setHumanitiescorrectRecord:(NSInteger)num;
-(void)setHumanitiesPercentRecord:(float)num;
-(NSInteger)getHumanitiesTryRecord;
-(NSInteger)getHumanitiesCorrectRecord;
-(float)getHumanitiesPercentRecord;

-(void)setDeeperTryRecord:(NSInteger)num;
-(void)setDeepercorrectRecord:(NSInteger)num;
-(void)setDeeperPercentRecord:(float)num;
-(NSInteger)getDeeperTryRecord;
-(NSInteger)getDeeperCorrectRecord;
-(float)getDeeperPercentRecord;

-(void)setTotalTryRecord:(NSInteger)num;
-(void)setTotalcorrectRecord:(NSInteger)num;
-(void)setTotalRate:(float)num;
-(NSInteger)getTotalTryRecord;
-(NSInteger)getTotalCorrectRecord;
-(float)getTotalRates;
@end
