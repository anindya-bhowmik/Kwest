//
//  Utility.m
//  Fullmiere
//
//  Created by Bjit Ltd on 12/28/12.
//  Copyright (c) 2012 Bjit Ltd. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"
//#import "ResolutionConstant.h"



@implementation Utility

@synthesize deviceType;

static Utility *instance =nil;
+(Utility *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [Utility new];
            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                instance.deviceType = @"_iPad";
            }
            else if (screenBounds.size.height == 568) {
                
                instance.deviceType = iPhone5;
                
            }
            else if (screenBounds.size.height == 480) {
                instance.deviceType = iPhone4s;
            }
            else{
                instance.deviceType = @"";
            }
        }
    }
    return instance;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


/**
 * バッテリーアイコンを更新します。
 * @param event バッテリーステータス。SensorEvent.BATTELY_LEVEL_EMPTYなど
 * @param batteryLevel
 * @return 更新有無
 */


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(BOOL)isPad{
 return DeviceHeight >=1024? YES:NO;
}

/**
 * ネットワークが使用できるか調べる
 * @return 使用可否
 */



/**
 * 外部ストレージからデータベースを復元する
 * @param cnt コンテキスト
 * @param fileName 読み込むファイルの名前
 * @return 成否
 */
+(BOOL) importDatabaseFromExternalStorage:(NSString*) filename {
    //TODO:Shahriar
    //Need to implement
    //
    //    // ファイル名は最初の20文字
    //    filename = filename.substring(0, 20);
    //
    //    // 保存先のディレクトリを確保
    //    File filePathToSaved = new File(cnt.getApplicationInfo().dataDir + "/databases");
    //    if (!filePathToSaved.exists()) {
    //        filePathToSaved.mkdirs();
    //    }
    //
    //    // DBファイルの在処
    //    String fileSd = new StringBuilder()
    //    .append(Environment.getExternalStorageDirectory().getPath())
    //    .append("/")
    //    .append(DIRECTORY_NAME)
    //    .append("/")
    //    .append(filename)
    //    .toString();
    //
    //    // アプリ保存領域に書き込み
    //    String fileDb = cnt.getDatabasePath(DBNAME).getPath();
    //
    //    FileInputStream fileInputStream = null;
    //    FileOutputStream fileOutputStream = null;
    //    try {
    //        // SDからDB読み込み
    //        fileInputStream = new FileInputStream(fileSd);
    //        int length = fileInputStream.available();
    //        byte[] readBytes = new byte[length];
    //        fileOutputStream = new FileOutputStream(fileDb);
    //
    //        if (fileInputStream.read(readBytes) == length) {
    //            // 復号化
    //            byte[] decryptedDB = decryptBinary(readBytes);
    //            // 端末内アプリ領域に書き込み
    //            fileOutputStream.write(decryptedDB);
    //        }
    //    } catch (FileNotFoundException e) {
    //        e.printStackTrace();
    //    } catch (IOException e) {
    //        e.printStackTrace();
    //    } finally {
    //        if (fileInputStream != null) {
    //            try {
    //                fileInputStream.close();
    //            } catch (IOException e) {
    //                e.printStackTrace();
    //            }
    //        }
    //        if (fileOutputStream != null) {
    //            try {
    //                fileOutputStream.close();
    //            } catch (IOException e) {
    //                e.printStackTrace();
    //            }
    //        }
    //    }
    return true;
}

/**
 * ファイルを削除する
 * @param filePath 削除するファイルのパス
 * @return true:削除成功もしくはファイルが元々無い。false: 削除失敗
 */
+(BOOL) deleteFile:(NSString*) filePath{
    BOOL isSuccessful = true;
    //TODO:Shahriar
    //    File file = new File(filePath);
    //    if (file.exists()) {
    //        isSuccessful = file.delete();
    //    }
    return isSuccessful;
}

+(BOOL) isEnableNetwork {
    //Reachability *reachabilityChecker = [[Reachability alloc]init];
    Reachability *reachabilityChecker = [Reachability reachabilityForInternetConnection];
    return [reachabilityChecker isReachable];
}


@end
