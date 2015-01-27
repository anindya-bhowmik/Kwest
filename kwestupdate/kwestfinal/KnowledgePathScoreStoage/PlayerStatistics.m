//
//  PlayerStatistics.m
//  kwest
//
//  Created by Tashnuba Jabbar on 09/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import "PlayerStatistics.h"
static PlayerStatistics *StatManager = nil;
@implementation PlayerStatistics

+(id) StatManager{
    @synchronized(self){
        if(StatManager  ==nil)
            StatManager = [[super allocWithZone:NULL]init];
    }
    return StatManager;
}

+(id)allocWithZone:(NSZone *)zone{
    return [[self StatManager]retain];
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
        Sciencetry = [NSUserDefaults standardUserDefaults];
        Sciencecorrect = [NSUserDefaults standardUserDefaults];
        Sciencepercent = [NSUserDefaults standardUserDefaults];
        
        Logictry = [NSUserDefaults standardUserDefaults];
        Logiccorrect = [NSUserDefaults standardUserDefaults];
        Logicpercent = [NSUserDefaults standardUserDefaults];
        
        Humanitiestry = [NSUserDefaults standardUserDefaults];
        Humanitiescorrect = [NSUserDefaults standardUserDefaults];
        Humanitiespercent = [NSUserDefaults standardUserDefaults];
        
        Deepertry = [NSUserDefaults standardUserDefaults];
        Deepercorrect = [NSUserDefaults standardUserDefaults];
        Deeperpercent = [NSUserDefaults standardUserDefaults];
        
        Totaltry = [NSUserDefaults standardUserDefaults];
        Totalcorrect = [NSUserDefaults standardUserDefaults];
        Totalrate = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)setScienceTryRecord:(NSInteger)num{
    [Sciencetry setInteger:num forKey:@"ScienceTry"];

}
-(void)setSciencecorrectRecord:(NSInteger)num{
    [Sciencecorrect setInteger:num forKey:@"ScienceCorrect"];

}
-(void)setSciencePercentRecord:(float)num{
    [Sciencepercent setFloat:num forKey:@"SciencePercent"];

}
-(NSInteger)getScienceTryRecord{
    NSInteger try = [Sciencetry integerForKey:@"ScienceTry"];
    return try;
}
-(NSInteger)getScienceCorrectRecord{
    NSInteger correct = [Sciencecorrect integerForKey:@"ScienceCorrect"];
    return correct;
}
-(float)getSciencePercentRecord{
    float percent = [Sciencepercent floatForKey:@"SciencePercent"];
    return percent;
}

-(void)setLogicTryRecord:(NSInteger)num{
    [Logictry setInteger:num forKey:@"LogicTry"];

}
-(void)setLogiccorrectRecord:(NSInteger)num{
    [Logiccorrect setInteger:num forKey:@"LogicCorrect"];
}
-(void)setLogicPercentRecord:(float)num{
    [Logicpercent setFloat:num forKey:@"LogicPercent"];
}
-(NSInteger)getLogicTryRecord{
    NSInteger try = [Logictry integerForKey:@"LogicTry"];
    return try;
}
-(NSInteger)getLogicCorrectRecord{
    NSInteger correct = [Logiccorrect floatForKey:@"LogicCorrect"];
    return correct;
}
-(float)getLogicPercentRecord{
    float percent = [Logicpercent floatForKey:@"LogicPercent"];
    return percent;
}

-(void)setHumanitiesTryRecord:(NSInteger)num{
    [Humanitiestry setInteger:num forKey:@"HumanitiesTry"];
}
-(void)setHumanitiescorrectRecord:(NSInteger)num{
    [Humanitiescorrect setInteger:num forKey:@"HumanitiesCorrect"];

}
-(void)setHumanitiesPercentRecord:(float)num{
    [Humanitiespercent setFloat:num forKey:@"HumanitiesPercent"];
}
-(NSInteger)getHumanitiesTryRecord{
    NSInteger try = [Humanitiestry integerForKey:@"HumanitiesTry"];
    return try;
}
-(NSInteger)getHumanitiesCorrectRecord{
    NSInteger correct = [Humanitiescorrect integerForKey:@"HumanitiesCorrect"];
    return correct;
}
-(float)getHumanitiesPercentRecord{
    float percent = [Humanitiespercent floatForKey:@"HumanitiesPercent"];
    return percent;
}   

-(void)setDeeperTryRecord:(NSInteger)num{
    [Deepertry setInteger:num forKey:@"DeeperTry"];

}
-(void)setDeepercorrectRecord:(NSInteger)num{
    [Deepercorrect setInteger:num forKey:@"DeeperCorrect"];

}
-(void)setDeeperPercentRecord:(float)num{
    [Deeperpercent setFloat:num forKey:@"DeeperPercent"];
}
-(NSInteger)getDeeperTryRecord{
    NSInteger try = [Deepertry integerForKey:@"DeeperTry"];
    return try;
}
-(NSInteger)getDeeperCorrectRecord{
    NSInteger correct = [Deepercorrect integerForKey:@"DeeperCorrect"];
    return correct;
}
-(float)getDeeperPercentRecord{
    float percent = [Deeperpercent floatForKey:@"DeeperPercent"];
    return percent;
}


-(void)setTotalTryRecord:(NSInteger)num{
    [Totaltry setInteger:num forKey:@"Totaltry"];
}
-(void)setTotalcorrectRecord:(NSInteger)num{
    [Totalcorrect setInteger:num forKey:@"Totalcorrect"];
}
-(void)setTotalRate:(float)num{
    [Totalrate setFloat:num forKey:@"Totalrate"];
}
-(NSInteger)getTotalTryRecord{
    NSInteger tmp = [Totaltry integerForKey:@"Totaltry"];
    NSLog(@"try=%d",tmp);
    return tmp;
}
-(NSInteger)getTotalCorrectRecord{
    NSInteger tmp = [Totalcorrect integerForKey:@"Totalcorrect"];
     NSLog(@"correct=%d",tmp);
    return tmp;
}
-(float)getTotalRates{
    float tmp = [Totalrate floatForKey:@"Totalrate"];
    return tmp;

}
-(void)dealloc{
    [super dealloc];
}
@end
