//
//  Utility.h
//  Fullmiere
//
//  Created by Bjit Ltd on 12/28/12.
//  Copyright (c) 2012 Bjit Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#define iPhone5 @"-568h" 
@interface Utility : NSObject{
    NSString *deviceType;
}

@property (nonatomic,strong) NSString *deviceType;


+(Utility*)getInstance;
+(BOOL)updateBattery:(int)event batteryLevelType:(int) batteryLevel;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(BOOL) isEnableNetwork;
+(BOOL)isPad;
+(BOOL) deleteFile:(NSString*) filePath;
@end
