//
//  UrlGenerator.m
//  DIctionaryApp
//
//  Created by Karthik Baskaran on 04/09/15.
//  Copyright (c) 2015 K2B Solutions. All rights reserved.
//

#import "UrlGenerator.h"
#import "Constants.h"


@implementation UrlGenerator


+ (NSString *) appendBaseUrl:(NSString *) string
{
    return [BASE_URL stringByAppendingString:string];
}

+(NSString *)PostLogin
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Login]];
}

+(NSString *)PostOtp
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Otp]];
}

+(NSString *)PostSignup
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Signup]];
}

+(NSString *)PostAddVehicle
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_AddVehicle]];
}

+(NSString *)PostGetVehicle
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_GetVehicle]];
}

+(NSString *)PostForgotPass
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_ForgotPass]];
}

+(NSString *)PostResetpass
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_ResetPass]];
}

+(NSString *)PostRequestmap
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Requestmap]];
}

+(NSString *)PostBooking
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Booking]];
}

+(NSString *)PostpartnerLocation
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Partnerlocation]];
}

+(NSString *)Postupdatestatus
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_UpdateStatus]];
}

+(NSString *)Postresendotp
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_ResendOtp]];
}

+(NSString *)Postpayment
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Payment]];
}

+(NSString *)PostBookinglist
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Bookinglist]];
}

+(NSString *)PostCancelBooking
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Bookinglist]];
}

+(NSString *)Post_Partnerbylocation
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_Partnerbylocation]];
}

+(NSString *)Post_PrebookRequest
{
    return [NSString stringWithFormat: @"%@",[self appendBaseUrl:Post_PrebookRequest]];
}
@end
