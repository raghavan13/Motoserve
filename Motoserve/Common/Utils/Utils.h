//
//  Utils.h
//  CIty Spot
//
//  Created by Karthik Baskaran on 19/12/15.
//  Copyright © 2015 K2B Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constants.h"
//#import "PrinterSDK.h"
#import "CPMetaFile.h"

@interface Utils : NSObject<UIApplicationDelegate>

typedef enum {
    
    iPhone4,
    iPhone5,
    iPhone6,
    iPhone6Plus,
    iPad
}currentDevice ;

+ (UIFont *)getResizeableFont:(UIFont *)currentFont;

+ (BOOL)isCheckNotNULL:(id)parameter;

+ (void) saveStringData:(NSString *)stringData key:(NSString *)key;
+ (NSString *)retrieveSavedStringData:(NSString *)key;
+ (void)removeSavedStringData:(NSString *)key;


+ (void)archieveRootObject:(NSDictionary *)userData forkey:(NSString *)key;
+ (NSDictionary *)NSKeyedUnarchiver:(NSString *)key;



#pragma mark Frame Methods

+ (CGRect )getSizeofFont:(NSString *)forValue theFrame:(CGRect )frame withSpace:(float)space;


+ (CGRect )normalResize:(CGRect )frame expectedFrame:(float )expectFrame withSpace:(float)extraSpace;


+ (CGRect )AlignResize:(CGRect )frame expectedFrame:(CGRect )expectFrame withSpace:(float)extraSpace;

+ (CGRect )getEqualHeight:(CGRect )frame expectedFrame:(CGRect )expectFrame withExtraSpace:(float)space;


+ (CGRect )getSizeofWidth:(CGRect )forValue theFrame:(CGRect )frame WithSpace:(float )Space;

+(NSAttributedString *)getSpacingforString:(NSString *)theString withSpace:(float)space;

#pragma mark Animation Methods

+(void)ShowBounceAnimationBtn:(UIView *)theView;

+(void)RemoveBounceAnimationBtn:(UIView *)theView superView:(UIView *)superView;

+(void)ShakeandBlink:(id)sender;

+(NSString*)GlobalDateConvert:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;


+(NSString*)UpcomingDateConvert:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;

+(NSDate*)CalenderDateConverter:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;

+ (CGRect )OrderAlign:(CGRect )frame expectedFrame:(float )expectFrame withSpace:(float)extraSpace;

+ (CGRect )getSizeofAttributeFont:(NSAttributedString *)forValue theFrame:(CGRect )frame;

+(NSArray *)sortArrayValue:(NSString *)forKey withSort:(BOOL)sorting ArrayData:(NSArray*)myData;

+(NSString *)CapitalizeString:(NSString *)str;

+(NSString *)EncodeArray:(NSArray *)myArray;

+(NSAttributedString *)CartAttribute:(NSString *)StringData;

+ (CGRect )getCenterofScreen:(CGRect )frame expectedFrame:(CGRect )expectFrame withSpace:(float)extraSpace;

+ (float )getHeightForText:(NSString *)forValue withFont:(UIFont *)font withSpace:(float)space;


+(NSArray *)removeNullfromArray:(NSArray *)myArray;

+ (float )getwidthofText:(NSString *)forValue withFont:(UIFont *)font withSpace:(float)space;
+(NSMutableAttributedString *)MakeFontAttributeString:(NSString *)data font:(UIFont *)font withAppend:(NSString *)append;

//+ (void) SaveCurrentPrinter:(Printer *)Printer key:(NSString *)key;

//+ (Printer *) retrieveCurrentPrinter:(NSString *)key;

+(NSString *)ConvertHtml:(NSString *)string;

+ (BOOL)isIpad;

+(UIView *)CreateHeaderBarWithSearch:(UIView *)InView HeaderTitle:(NSString *)HeaderTitle  IsText:(BOOL)IsTitle Menu:(BOOL)IsMenu IsCart:(BOOL)IsCart LeftClass:(id)LeftClass LeftSelector:(SEL)LeftSelector  RightClass:(id)RightClass RightSelector:(SEL)RightSelector WithCartCount:(NSString *)CartCount  SearchClass:(id)SearchClass SearchSelector:(SEL)SearchSelector ShowSearch:(BOOL)ShowSearch HeaderTap:(id)HeaderTap TapAction:(SEL)TapAction;

+ (void) showErrorAlert:(NSString *)strMessage delegate:(id)_delegate;

+ (BOOL)validateEmailWithString:(NSString*)email;

@end
