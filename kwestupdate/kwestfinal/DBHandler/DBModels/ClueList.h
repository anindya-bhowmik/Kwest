//
//  ClueList.h
//  kwest
//
//  Created by Tashnuba Jabbar on 28/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClueList : NSObject{
    NSInteger clue_id;
    NSString *clue_name;
    NSInteger questno;
    bool locked;
    float cost;
}
@property (nonatomic,readwrite)NSInteger clue_id;
@property (nonatomic,readwrite)NSInteger questno;
@property (nonatomic,retain)NSString *clue_name;
@property (nonatomic,readwrite)float cost;
@property (nonatomic,readwrite)bool locked;
@end
