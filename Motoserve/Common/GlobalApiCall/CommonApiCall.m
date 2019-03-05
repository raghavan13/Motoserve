//
//  CommonApiCall.m
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "CommonApiCall.h"
#import "CPMetaFile.h"
#import "AppDelegate.h"
@interface CommonApiCall ()
{
    AppDelegate *appDelegate;
    NSMutableDictionary *StatusDictionary;
    
}

@property (retain, nonatomic)UIView *LoadView;
@property (retain, nonatomic)NSString *Keyword;

@end
@implementation CommonApiCall


+ (instancetype)CommonServiceManager {
    static CommonApiCall *CommonServive = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        CommonServive = [[CommonApiCall alloc] init];
    });
    return CommonServive;
}



-(void)LoaderView:(UIView *)view ServiceName:(NSString *)Name{
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    StatusDictionary=[[NSMutableDictionary alloc]init];
    
    _LoadView=view;
    
    _Keyword=Name;
}

- (void)getbooking
{
    NSString *url =[UrlGenerator PostBooking];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":appDelegate.bookingidStr
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             [self->appDelegate stopProgressView];
         }
         else
         {
             NSLog(@"1");
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]intValue]==0) {
                 
             }
             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]intValue]==1)
             {
                 
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}







@end
