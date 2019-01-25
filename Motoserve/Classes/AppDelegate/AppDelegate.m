//
//  AppDelegate.m
//  Motoserve
//
//  Created by Shyam on 02/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CPMetaFile.h"
#import <AWSCore.h>
@import Firebase;
//#import <AWSCognitoIdentityUserPool.h>

@interface AppDelegate ()<CLLocationManagerDelegate,RESideMenuDelegate>
{
    NSMutableArray *ActivityIndiArray;
    RTSpinKitView *spinner;
    UIView *panel;
    CLLocationManager * locationManager;
    double latitude,longitude;
}
@end

@implementation AppDelegate
@synthesize font;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [GMSServices provideAPIKey:@"AIzaSyCTOLLqKPDjGS588hJULK7MzM7aTGtbuW8"];
    if(self.window.frame.size.height==812){
        
        self.deviceType=DEVICE_TYPE_IPHONEX;
        self.hVal=[[UIScreen mainScreen] bounds].size.height;
        self.wVal=[[UIScreen mainScreen] bounds].size.width;
        
        font=17;
        
    }else if(self.window.frame.size.height==736)
    {
        self.deviceType=DEVICE_TYPE_IPHONE6PLUS;
        self.hVal=[[UIScreen mainScreen] bounds].size.height;
        self.wVal=[[UIScreen mainScreen] bounds].size.width;
        
        font=16;
        
    } else if(self.window.frame.size.height==667) {
        self.deviceType=DEVICE_TYPE_IPHONE6;
        self.hVal=[[UIScreen mainScreen] bounds].size.height;
        self.wVal=[[UIScreen mainScreen] bounds].size.width;
        
        font=15;
        
    } else if(self.window.frame.size.height==568){
        self.deviceType=DEVICE_TYPE_IPHONE5;
        self.hVal=[[UIScreen mainScreen] bounds].size.height;
        self.wVal=[[UIScreen mainScreen] bounds].size.width;
        font=14;
        
    } else if(self.window.frame.size.height==480){
        self.deviceType=DEVICE_TYPE_IPHONE4;
        self.hVal=[[UIScreen mainScreen] bounds].size.height;
        self.wVal=[[UIScreen mainScreen] bounds].size.width;
        font=11;
        
    }
    [FIRApp configure];
//    //setup service config
//    AWSServiceConfiguration *serviceConfiguration =
//    [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:nil];
//
//    //create a pool
//    AWSCognitoIdentityUserPoolConfiguration *configuration =
//    [[AWSCognitoIdentityUserPoolConfiguration alloc] initWithClientId:@"CLIENT_ID"
//                                                         clientSecret:@"CLIENT_SECRET"
//                                                               poolId:@"USER_POOL_ID"];
//
//    [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration
//                                                           userPoolConfiguration:configuration forKey:@"UserPool"];
//    AWSCognitoIdentityUserPool *pool =
//    [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
//
//    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1 identityPoolId:@"IDENTITY_POOL_ID" identityProviderManager:pool];
//    AWSServiceConfiguration *defaultServiceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
//                                                                                       credentialsProvider:credentialsProvider];
//    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = defaultServiceConfiguration;
   
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if(SYSTEM_IS_OS_8_OR_LATER)
    {
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];

    }
//    if ([locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
//        [locationManager setAllowsBackgroundLocationUpdates:YES];
//    }
    [locationManager startUpdatingLocation];
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [locationManager requestAlwaysAuthorization];
    }
    
    NSArray *fontFamilies = [UIFont familyNames];

    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        //statusBar.backgroundColor=RGB(0, 89, 42);
        statusBar.backgroundColor = RGB(33,53,28);//set whatever color you like
    }
    NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
    UIViewController *firstVC;
    if (![Utils isCheckNotNULL:login])
    {
         firstVC=[[MapViewController alloc]init];
    }
    else
    {
        firstVC=[[constraintViewController alloc]init];
    }
    _serviceon=@"p";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:firstVC];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:nil
                                                                   rightMenuViewController:leftMenuViewController];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    

//    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:firstVC];
//    navigation.navigationBarHidden=YES;
//    [self.window setRootViewController:navigation];
    return YES;
}
//starts automatically with locationManager
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    latitude=newLocation.coordinate.latitude;
    longitude=newLocation.coordinate.longitude;
    NSLog(@"Location: %f, %f",newLocation.coordinate.longitude, newLocation.coordinate.latitude);
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"Your latitude %f and longitude %f",latitude,longitude];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark Progress View

-(void)startProgressView:(UIView *)ContentView {
    
    [self RemoveActivityOnContentView];
    
    ActivityIndiArray=nil;
    
    ActivityIndiArray=[[NSMutableArray alloc] init];
    
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:CWCColor(whiteColor) spinnerSize:50];
    
    spinner.center = ContentView.center;
    [spinner startAnimating];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    panel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    panel.backgroundColor =[UIColor colorWithWhite:0.000 alpha:0.500];
    [panel addSubview:spinner];
    [ContentView addSubview:panel];
    
    [ActivityIndiArray addObject:panel];
    
    [ContentView bringSubviewToFront:panel];
    
}

-(void)startProgressViewFadingCircle:(UIView *)ContentView {
    
    [self RemoveActivityOnContentView];
    
    ActivityIndiArray=nil;
    
    ActivityIndiArray=[[NSMutableArray alloc] init];
    
    spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleFadingCircleAlt color:CWCColor(CWCRed) spinnerSize:20];
    
    //    spinner.frame=CGRectMake(ContentView.frame.size.width-(ContentView.frame.size.width/2)/2, ContentView.frame.size.height-(ContentView.frame.size.width/2)/2, ContentView.frame.size.width/2, ContentView.frame.size.width/2);
    spinner.center = CGPointMake(ContentView.center.x, (ContentView.center.y-ContentView.frame.origin.y));
    [spinner startAnimating];
    
    
    
    panel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ContentView.frame.size.width, ContentView.frame.size.height)];
    panel.backgroundColor =Singlecolor(clearColor);
    [panel addSubview:spinner];
    [ContentView addSubview:panel];
    
    [ActivityIndiArray addObject:panel];
    
    [ContentView bringSubviewToFront:panel];
    
}

-(void)stopProgressView {
    [panel removeFromSuperview];
    [spinner stopAnimating];
}

-(void)RemoveActivityOnContentView
{
    if (ActivityIndiArray.count>0) {
        
        NSLog(@"Already Indicator Presents");
        UIView *pView=(UIView*)[ActivityIndiArray objectAtIndex:0];
        
        for (RTSpinKitView *spin in pView.subviews) {
            [spin startAnimating];
        }
        [pView removeFromSuperview];
    }
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}
@end
