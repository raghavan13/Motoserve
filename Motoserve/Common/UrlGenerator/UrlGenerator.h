//
//  UrlGenerator.h
//  DIctionaryApp
//
//  Created by Karthik Baskaran on 04/09/15.
//  Copyright (c) 2015 K2B Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlGenerator : NSObject

+(NSString *) appendBaseUrl:(NSString *)string;

+(NSString *)PostLogin;

+(NSString *)PostOtp;

+(NSString *)PostSignup;

+(NSString *)PostAddVehicle;

+(NSString *)PostGetVehicle;

+(NSString *)PostForgotPass;

+(NSString *)PostResetpass;

+(NSString *)PostRequestmap;

+(NSString *)PostBooking;

+(NSString *)PostpartnerLocation;

+(NSString *)Postupdatestatus;

+(NSString *)Postresendotp;

+(NSString *)Postpayment;

+(NSString *)PostBookinglist;
@end


