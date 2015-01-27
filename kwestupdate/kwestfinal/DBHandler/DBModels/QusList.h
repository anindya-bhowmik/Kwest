//
//  QusList.h
//  com.ahmad
//
//  Created by Tashnuba Jabbar on 13/10/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QusList : NSObject{
   //Qus Data 
    NSInteger q_id;
    NSInteger correct;
    NSInteger type;
    NSInteger difficulty;
    NSString *qus;
    NSString *opt1;
    NSString *opt2;
    NSString *opt3;
    NSString *leader;
    NSString *subtype;
    
    //Player Data
    NSString *playername;
    float knop;
    float gold;
    NSInteger energy;
    NSInteger karma;
    NSInteger level;
    NSString *date;
    int key_of_enrgy;
    int key_of_wisdom;
    int ke_of_strength;
    int premium;
}

@property(nonatomic,assign)NSInteger q_id;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger difficulty;
@property(nonatomic,assign)NSInteger correct;
@property(nonatomic,retain)NSString *subtype;
@property(nonatomic,retain)NSString *qus;
@property(nonatomic,retain)NSString *opt1;
@property(nonatomic,retain)NSString *opt2;
@property(nonatomic,retain)NSString *opt3;
@property(nonatomic,retain)NSString *opt4;
@property(nonatomic,retain)NSString *leader;


@property(nonatomic,retain)NSString *playername;
@property(nonatomic,assign)float knop;
@property(nonatomic,assign)float gold;
@property(nonatomic,assign)NSInteger energy;
@property(nonatomic,assign)NSInteger karma;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,assign)int key_of_energy;
@property(nonatomic,assign)int key_of_wisdom;
@property(nonatomic,assign)int  key_of_strength;
@property(nonatomic,assign)int premium;
@property(nonatomic,retain)NSString *date;
@end
