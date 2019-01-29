//
//  Constants.m
//  Barzz
//
//  Created by Karthik Baskaran on 23/12/14.
//  Copyright (c) 2014 K2B Solutions. All rights reserved.
//

#import "Constants.h"

@implementation Constants


int const AppVersion=13;


NSString * const DEVICE_TYPE_IPHONE6PLUS=@"iPhone6Plus";
NSString * const DEVICE_TYPE_IPHONE6=@"iPhone6";
NSString * const DEVICE_TYPE_IPHONE5=@"iPhone5";
NSString * const DEVICE_TYPE_IPHONE4=@"iPhone4";
NSString * const DEVICE_TYPE_IPAD_NON_RETINA=@"iPad_Non_Retina";
NSString * const DEVICE_TYPE_IPAD_RETINA=@"iPad_Retina";
NSString * const Word_OF_The_Day=@"iPad_Retina";
NSString * const DEVICE_TYPE_IPHONEX=@"iPhoneX";



NSString * const BASE_URL = @"http://18.222.62.7:4000/";

NSString * const Post_Login = @"userLogin";

NSString * const Post_Otp = @"verifyUserMobile";

NSString * const Post_ResendOtp = @"resendUserVerificationCode";

NSString * const Post_Signup = @"createUser";

NSString * const Post_AddVehicle = @"addVehicle";

NSString * const Post_GetVehicle = @"getVehicle";

NSString * const Post_ForgotPass = @"forgotUserPassword";

NSString * const Post_ResetPass = @"resetUserPassword";

NSString * const Post_Requestmap = @"requestService";

NSString * const Post_Booking = @"getBooking";

NSString * const Post_Partnerlocation = @"getPartnerLocation";

NSString * const Post_UpdateStatus = @"updateBookingStatus";

NSString * const Post_Payment = @"getPayment";

NSString * const Post_Bookinglist = @"getUserBookingList";

@end
