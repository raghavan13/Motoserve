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
@property(nonatomic,retain)NSString *deviceType,*bookingidStr,*bookingstatusStr,*servicetype,*serviceon,*vehicleid,*partnerId;
@property(nonatomic,retain)NSMutableDictionary * selectionvalue;
@property(nonatomic,readwrite)float hVal,wVal,font;
@property (strong,nonatomic)NSArray * servicedetails,*PartnerlistArray,*selecteddic;
@property (nonatomic)BOOL isedit,islogin,fromschedule;
@property (nonatomic,retain)NSMutableArray * latArray;
-(void)startProgressView:(UIView *)ContentView;
-(void)startProgressViewFadingCircle:(UIView *)ContentView;
-(void)stopProgressView;
-(void)RemoveActivityOnContentView;
@end

