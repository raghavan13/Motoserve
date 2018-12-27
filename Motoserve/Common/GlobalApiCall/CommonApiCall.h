//
//  CommonApiCall.h
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CommomServicesDelegate <NSObject> //It will call Delivery Charge,View Cart and Pickup outlet services..

@required

-(void)CommonServiceResponse:(NSDictionary *)successResponse withKey:(NSString *)key;

@end

@interface CommonApiCall : NSObject

@property (nonatomic, retain) id<CommomServicesDelegate> CommomServicesDelegate;

+ (instancetype)CommonServiceManager;

-(void)LoaderView:(UIView *)view ServiceName:(NSString *)Name;

@end


