//
//  AppDelegate.h
//  Motoserve
//
//  Created by Shyam on 02/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//


#define SYSTEM_IS_OS_8_OR_LATER "8.0"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSString *deviceType,*bookingidStr,*bookingstatusStr;
@property(nonatomic,readwrite)float hVal,wVal,font;
@property(nonatomic)BOOL onrdbool;
@property (strong,nonatomic)NSArray * servicedetails;
-(void)startProgressView:(UIView *)ContentView;
-(void)startProgressViewFadingCircle:(UIView *)ContentView;
-(void)stopProgressView;
-(void)RemoveActivityOnContentView;
@end

