//
//  Constants.h
//  Barzz
//
//  Created by Karthik Baskaran on 23/12/14.
//  Copyright (c) 2014 K2B Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface Constants : NSObject






#define kAnimateInDuration 0.4
#define kAnimateOutDuration 0.4

#define RGB(_red,_green,_blue)  [UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:1]

#define image(image)   [UIImage imageNamed:image]

#define RalewayRegular(_size)   [UIFont fontWithName:@"Raleway-Regular" size:_size]

#define RalewayBold(_size)   [UIFont fontWithName:@"Raleway-Bold" size:_size]

#define RalewayExtraLight(_size)   [UIFont fontWithName:@"Raleway-ExtraLight" size:_size]

#define RalewaySemiBold(_size)   [UIFont fontWithName:@"Raleway-SemiBold" size:_size]

#define RalewaySemiBoldItalic(_size)   [UIFont fontWithName:@"Raleway-SemiBoldItalic" size:_size]

#define RalewayItalic(_size)   [UIFont fontWithName:@"Raleway-Italic" size:_size]

#define RalewayLight(_size)   [UIFont fontWithName:@"Raleway-Light" size:_size]

#define RalewayExtraBold(_size)   [UIFont fontWithName:@"Raleway-ExtraBold" size:_size]

#define RalewayLightItalic(_size)   [UIFont fontWithName:@"Raleway-LightItalic" size:_size]

#define RalewayExtraLightItalic(_size)   [UIFont fontWithName:@"Raleway-ExtraLightItalic" size:_size]

#define RalewayMedium(_size)   [UIFont fontWithName:@"Raleway-Medium" size:_size]

#define RalewayThinItalic(_size)   [UIFont fontWithName:@"Raleway-ThinItalic" size:_size]

#define RalewayMediumItalic(_size)   [UIFont fontWithName:@"Raleway-MediumItalic" size:_size]

#define RalewayExtraBoldItalic(_size)   [UIFont fontWithName:@"Raleway-ExtraBoldItalic" size:_size]

#define RalewayBlack(_size)   [UIFont fontWithName:@"Raleway-Black" size:_size]

#define RalewayThin(_size)   [UIFont fontWithName:@"Raleway-Thin" size:_size]

#define RalewayBoldItalic(_size)   [UIFont fontWithName:@"Raleway-BoldItalic" size:_size]

#define RalewayBlackItalic(_size)   [UIFont fontWithName:@"Raleway-BlackItalic" size:_size]

#define Singlecolor(_color)  [UIColor _color]

#define IS_IPHONE4                      (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)



#define IS_IPHONE5                      (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)



#define IS_IPHONE6                      (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)



#define IS_IPHONE6_Plus                 (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)


#define NormalAnimation(_inView,_duration,_frames)            [UIView transitionWithView:_inView duration:_duration options:UIViewAnimationOptionTransitionNone animations:^{ _frames    }





#define TRIM(string)   [string stringByReplacingOccurrencesOfString:@" " withString:@""]

#define stringReplace(_string,_find,_replace)   [_string stringByReplacingOccurrencesOfString:_find withString:_replace];

#define GetresizeFont(labelSize,string)  [string boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:nil context:nil].size

#define getHeightForFont(labelSize,string,font)  [string boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size

#define SCREEN_HEIGHT                    [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width

#define IS_IPHONEX                      (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)

#define CWCColor(color)  [CWCColor color]

FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPHONE6PLUS;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPHONE6;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPHONE5;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPHONE4;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPAD_NON_RETINA;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPAD_RETINA;
FOUNDATION_EXPORT NSString * const DEVICE_TYPE_IPHONEX;

#define ITunesLink @"https://itunes.apple.com/us/app/ninja-biz-center/id1174801323?ls=1&mt=8"

//#define App_Id @"7C8DCD37-AE30-408B-8E90-36EA69117ECB"

#define userDetails @"UserDetails"


#define BTPrinter @"CurrentPrinter"


FOUNDATION_EXPORT int const AppVersion;

FOUNDATION_EXPORT NSString * const BASE_URL;

FOUNDATION_EXPORT NSString * const Post_Login;

FOUNDATION_EXPORT NSString * const Post_Otp;

FOUNDATION_EXPORT NSString * const Post_Signup;

FOUNDATION_EXPORT NSString * const Post_AddVehicle;

FOUNDATION_EXPORT NSString * const Post_GetVehicle;

FOUNDATION_EXPORT NSString * const Post_ForgotPass;

FOUNDATION_EXPORT NSString * const Post_ResetPass;

FOUNDATION_EXPORT NSString * const Post_Requestmap;

FOUNDATION_EXPORT NSString * const Post_Booking;

FOUNDATION_EXPORT NSString * const Post_Partnerlocation;

FOUNDATION_EXPORT NSString * const Post_UpdateStatus;

FOUNDATION_EXPORT NSString * const Post_ResendOtp;

FOUNDATION_EXPORT NSString * const Post_Payment;

FOUNDATION_EXPORT NSString * const Post_Bookinglist;

FOUNDATION_EXPORT NSString * const Post_CancelBooking;

FOUNDATION_EXPORT NSString * const Post_Partnerbylocation;
@end
