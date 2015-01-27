//
//  Quest.h
//  kwest
//
//  Created by Tashnuba Jabbar on 27/11/2012.
//  Copyright (c) 2012 AITL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quest : NSObject{
    NSInteger q_id;
    NSString *q_name;
    NSInteger solved;
    NSString *hint1;
    NSString *hint2;
    NSInteger levelactive;
    NSInteger no_of_hint;
    bool ishintused;
}
@property (nonatomic,readwrite)NSInteger q_id;
@property (nonatomic,readwrite)NSInteger levelactive;
@property (nonatomic,readwrite)NSInteger solved;
@property (nonatomic,retain)NSString *q_name;
@property (nonatomic,retain)NSString *hint1;
@property (nonatomic,retain)NSString *hint2;
@property (nonatomic,readwrite)NSInteger no_of_hint;
@property (nonatomic,readwrite)bool ishintused;
@end
