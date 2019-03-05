//
//  MapViewController.m
//  GMapSample
//
//  Created by VictorSebastian on 27/07/18.
//  Copyright © 2018 Thiru. All rights reserved.
//
//Reference

//https://stackoverflow.com/questions/42620510/how-to-get-animated-polyline-route-in-gmsmapview-so-that-it-move-along-with-map



#import "MapViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
#import "Motosserve-Swift.h"

@interface MapViewController ()<ARCarMovementDelegate>
{



    UIView * navHeader,*prepareView,* startView;
    AppDelegate * appDelegate;
    NSString * bookstatusStr;
    NSTimer * getbookingtimer,*patnerlocationtimer;
    CLLocationManager * locationManager;
    DraggableViewController * ordernw;
}

@property (strong, nonatomic) ARCarMovement *moveMent;
@property(nonatomic, strong) NSMutableArray *arrayCSV, *arrMapList;
@end

@implementation MapViewController
@synthesize mapView;

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBarHidden = YES;
    
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Booking Status" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    
    bookstatusStr=@"2";
    
    //    // Current Location
    //
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;   //100 m
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    //
    
    
    //alloc
    
    self.moveMent = [[ARCarMovement alloc]init];
    self.moveMent.delegate = self;
    
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"coordinates" ofType:@"json"];
    //    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    //
    //    self.CoordinateArr = [[NSMutableArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil]];
    
    //set car coordinate
    
    self.oldCoordinate = CLLocationCoordinate2DMake([self.latStr doubleValue],[self.lonStr doubleValue]);
    
    CLLocation *LocationAtual1=[[CLLocation alloc] initWithLatitude:[self.latStr doubleValue]  longitude:[self.lonStr doubleValue]];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:LocationAtual1.coordinate.latitude longitude:LocationAtual1.coordinate.longitude zoom:14];
    
    // GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:20];
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, IS_IPHONEX?90:70, SCREEN_WIDTH,SCREEN_HEIGHT) camera:camera];
    mapView.myLocationEnabled=YES;
    [self.view addSubview:mapView];
    
    
    UIButton * dragBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    dragBtn.backgroundColor=Singlecolor(whiteColor);
    dragBtn.layer.borderWidth = 1.0f;
    [dragBtn addTarget:self action:@selector(gestureHandlerMethod) forControlEvents:UIControlEventTouchUpInside];
    dragBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:dragBtn];
    
    UIImageView * sliderImg=[[UIImageView alloc]initWithFrame:CGRectMake(dragBtn.frame.size.width/2-22, dragBtn.frame.size.height/2-4.5, 44, 9)];
    sliderImg.image=image(@"seperator");
    [dragBtn addSubview:sliderImg];
    
    
    ordernw = [[DraggableViewController alloc]init];
    
    //=======
    
    // Creates a marker in the center of the map.
    //
    driverMarker = [[GMSMarker alloc] init];
    driverMarker.position = self.oldCoordinate;
    driverMarker.icon = [UIImage imageNamed:@"carIcon"];
    if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"shopName"]]) {
        driverMarker.title=[[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"shopName"]capitalizedString];
    }
    
    driverMarker.map = self.mapView;
    [mapView setSelectedMarker:driverMarker];
    //set counter value 0
    //
    self.counter = 0;
    
    //start the timer, change the interval based on your requirement
    //
    //getbookingtimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatebill)
                                                 name:@"updatebill"
                                               object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changetype" object:nil];
    
    //appDelegate.bookingstatusStr=@"2";
//    [NSTimer scheduledTimerWithTimeInterval:10.0
//                                     target:self
//                                   selector:@selector(targetMethod)
//                                   userInfo:nil
//                                    repeats:NO];
    [self targetMethod];
}

- (void)updatebill
{
    [self->getbookingtimer invalidate];
    self->getbookingtimer = nil;
    NewbillViewController * bill=[[NewbillViewController alloc]init];
    //bill.bookidStr=self->appDelegate.bookingidStr;
    [self.navigationController pushViewController:bill animated:YES];
}


- (void)targetMethod
{
    appDelegate.bookingstatusStr=@"3";
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changetype"
     object:nil];
//    [NSTimer scheduledTimerWithTimeInterval:10.0
//                                     target:self
//                                   selector:@selector(targetMethod1)
//                                   userInfo:nil
//                                    repeats:NO];
}
- (void)targetMethod1
{
    appDelegate.bookingstatusStr=@"4";
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changetype"
     object:nil];
}
- (void)gestureHandlerMethod
{
    ordernw.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
#ifdef __IPHONE_8_0
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [ordernw setModalPresentationStyle:UIModalPresentationOverCurrentContext];
#endif
    [self presentViewController:ordernw animated:YES completion:nil];
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
        // NSLog(@"response data %@",responseObject);
         
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             [self->appDelegate stopProgressView];
         }
         else
         {
             NSLog(@"1");
             
             if (![self->appDelegate.bookingstatusStr isEqualToString:[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]]) {
                 self->appDelegate.bookingstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"];
                 [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"changetype"
                      object:nil];
             }
             
             if ([self->appDelegate.bookingstatusStr isEqualToString:@"2"]) {
                 return ;
             }
             
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]intValue]==2) {
                 self->appDelegate.bookingstatusStr=@"2";
                
                 self->patnerlocationtimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(getpartnerlocation) userInfo:nil repeats:true];
                
             }
             else
             {
                 self->appDelegate.bookingstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"];
             }
//             if ([self->appDelegate.bookingstatusStr isEqualToString:@"6"])
//             {
//                 [self->getbookingtimer invalidate];
//                 self->getbookingtimer = nil;
//                 billViewController * bill=[[billViewController alloc]init];
//                 bill.bookidStr=self->appDelegate.bookingidStr;
//                 [self.navigationController pushViewController:bill animated:YES];
//             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}


- (void)getpartnerlocation
{
    NSString *url =[UrlGenerator PostpartnerLocation];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"bookingId":appDelegate.bookingidStr
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //NSLog(@"response data %@",responseObject);
         
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             [self->appDelegate stopProgressView];
         }
         else
         {
             NSLog(@"1");
             self->_latStr=[[[[responseObject valueForKey:@"data"]valueForKey:@"partnerLocation"]objectAtIndex:0]valueForKey:@"latitude"];
             self->_lonStr=[[[[responseObject valueForKey:@"data"]valueForKey:@"partnerLocation"]objectAtIndex:0]valueForKey:@"longitude"];
             [self CurrentLocationFetch];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self gestureHandlerMethod];
}
#pragma mark - scheduledTimerWithTimeInterval Action
-(void)timerTriggered {
    
    
    if (self.counter < self.CoordinateArr.count) {

        CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake([self.CoordinateArr[self.counter][@"lat"] floatValue],[self.CoordinateArr[self.counter][@"long"] floatValue]);

        /**
         *  You need to pass the created/updating marker, old & new coordinate, mapView and bearing value from backend
         *  to turn properly. Here coordinates json files is used without new bearing value. So that
         *  bearing won't work as expected.
         */
        [self.moveMent ARCarMovementWithMarker:driverMarker oldCoordinate:self.oldCoordinate newCoordinate:newCoordinate mapView:self.mapView bearing:0];  //instead value 0, pass latest bearing value from backend

        self.oldCoordinate = newCoordinate;
        self.counter = self.counter + 1; //increase the value to get all index position from array
    }
    else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - ARCarMovementDelegate
- (void)ARCarMovementMoved:(GMSMarker * _Nonnull)Marker {
    driverMarker = Marker;
    driverMarker.map = self.mapView;
    
    //animation to make car icon in center of the mapview
    //
    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:driverMarker.position zoom:15.0f];
    [self.mapView animateWithCameraUpdate:updatedCamera];
}


#pragma mark Code

-(void)CurrentLocationFetch
{
      CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake([_latStr floatValue],[_lonStr floatValue]);
    [self.moveMent ARCarMovementWithMarker:driverMarker oldCoordinate:self.oldCoordinate newCoordinate:newCoordinate mapView:self.mapView bearing:0];  //instead value 0, pass latest bearing value from backend
    
    self.oldCoordinate = newCoordinate;
}
@end
