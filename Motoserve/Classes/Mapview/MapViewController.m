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
    UIScrollView * statusScroll;
    UIImageView * prepareImg,* startImg,* rchImg;
    UILabel * prepareLbl,* startLbl,* rchLbl,* doneLbl;
    CLLocationManager * locationManager;
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



- (void)doneAction
{
    
UIAlertView * alert=[[UIAlertView alloc]initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"Is your Work Done" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
    
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
    
    
//    UIView * statusview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mapView.frame), SCREEN_WIDTH, mapView.frame.size.height)];
//    statusview.backgroundColor=Singlecolor(whiteColor);
//    [self.view addSubview:statusview];
//
//    statusScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, statusview.frame.size.width, statusview.frame.size.height)];
//    //statusScroll.backgroundColor=Singlecolor(blackColor);
//    [statusview addSubview:statusScroll];
//
//    UIButton *  submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-75, 10, 150, 30)];
//    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
//    [submitBtn setTitle:@"Request Accepted" forState:UIControlStateNormal];
//    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
//    [submitBtn setTitleColor:RGB(113, 209, 154) forState:UIControlStateNormal];
//    submitBtn.layer.cornerRadius = 5;
//    submitBtn.layer.borderWidth = 0.5;
//    submitBtn.layer.masksToBounds = true;
//    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
//    //[submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
//    [statusScroll addSubview:submitBtn];
//
//    UILabel * providernameLbl=[[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(submitBtn.frame)+20,statusview.frame.size.width-40, 21)];
//    providernameLbl.text=[[NSString stringWithFormat:@"Service Provider Name  :   %@",self.serviceprovidername]capitalizedString];
//    providernameLbl.textColor=Singlecolor(blackColor);
//    providernameLbl.font=RalewayBold(appDelegate.font-2);
//    [statusScroll addSubview:providernameLbl];
//
//    UILabel * distanceLbl=[[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(providernameLbl.frame)+5,statusview.frame.size.width-40, 21)];
//    distanceLbl.text=@"Distance                :     2KM";
//    distanceLbl.textColor=Singlecolor(blackColor);
//    distanceLbl.font=RalewayRegular(appDelegate.font-2);
//    [statusScroll addSubview:distanceLbl];
//
//    UILabel * estimateLbl=[[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(distanceLbl.frame)+5,statusview.frame.size.width-40, 21)];
//    estimateLbl.text=@"Estimated Time    :    10Mins";
//    estimateLbl.textColor=Singlecolor(blackColor);
//    estimateLbl.font=RalewayRegular(appDelegate.font-2);
//    [statusScroll addSubview:estimateLbl];
//
//    prepareImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(estimateLbl.frame)+30, 11, 10)];
//    prepareImg.image=image(@"Progress");
//    [statusScroll addSubview:prepareImg];
//
//    prepareLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prepareImg.frame)+20,CGRectGetMaxY(estimateLbl.frame)+25,statusview.frame.size.width-100, 21)];
//    prepareLbl.text=@"Preparing Tools";
//    prepareLbl.textColor=Singlecolor(blackColor);
//    //prepareLbl.backgroundColor=Singlecolor(grayColor);
//    prepareLbl.font=RalewayRegular(appDelegate.font-2);
//    [statusScroll addSubview:prepareLbl];
    
    //=======
    
    // Creates a marker in the center of the map.
    //
    driverMarker = [[GMSMarker alloc] init];
    driverMarker.position = self.oldCoordinate;
    driverMarker.icon = [UIImage imageNamed:@"carIcon"];
    driverMarker.map = self.mapView;
    
    //set counter value 0
    //
    self.counter = 0;
    
    //start the timer, change the interval based on your requirement
    //
   // getbookingtimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
}

- (void)gestureHandlerMethod
{
    DraggableViewController * ordernw = [[DraggableViewController alloc]init];
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
             
             if ([self->appDelegate.bookingstatusStr isEqualToString:@"2"]) {
                 return ;
             }
             
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"2"]) {
                 self->appDelegate.bookingstatusStr=@"2";
                
                 self->patnerlocationtimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(getpartnerlocation) userInfo:nil repeats:true];
                
                 
//                 self->prepareView=[[UIView alloc]initWithFrame:CGRectMake(self->prepareImg.frame.origin.x+5, CGRectGetMaxY(self->prepareImg.frame), 1, 40)];
//                 self->prepareView.backgroundColor=RGB(95, 208, 154);
//                 [self->statusScroll addSubview:self->prepareView];
//                 
//                 self->startImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self->prepareImg.frame)+40, 11, 10)];
//                 self->startImg.image=image(@"Progress");
//                 [self->statusScroll addSubview:self->startImg];
//                 
//                 self->startLbl=[[UILabel alloc]initWithFrame:CGRectMake(self->prepareLbl.frame.origin.x,CGRectGetMaxY(self->prepareLbl.frame)+30,self->prepareLbl.frame.size.width, 21)];
//                 self->startLbl.text=@"Start Navigation";
//                 self->startLbl.textColor=Singlecolor(blackColor);
//                 self->startLbl.font=RalewayRegular(self->appDelegate.font-2);
//                 [self->statusScroll addSubview:self->startLbl];
                 
             }
             else
             {
                 self->appDelegate.bookingstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"];
             }
             
             
             
             
//             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"3"])
//             {
//                 self->appDelegate.bookingstatusStr=@"3";
//                 [self->patnerlocationtimer invalidate];
//                 self->patnerlocationtimer = nil;
//
//                 self->startView=[[UIView alloc]initWithFrame:CGRectMake(self->prepareView.frame.origin.x, CGRectGetMaxY(self->startImg.frame), 1, 40)];
//                 self->startView.backgroundColor=RGB(95, 208, 154);
//                 [self->statusScroll addSubview:self->startView];
//
//
//                 self->rchImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self->startImg.frame)+40, 11, 10)];
//                 self->rchImg.image=image(@"Progress");
//                 [self->statusScroll addSubview:self->rchImg];
//
//                 self->rchLbl=[[UILabel alloc]initWithFrame:CGRectMake(self->prepareLbl.frame.origin.x,CGRectGetMaxY(self->startLbl.frame)+30,self->prepareLbl.frame.size.width, 21)];
//                 self->rchLbl.text=@"Work In Progress";
//                 self->rchLbl.textColor=Singlecolor(blackColor);
//                 self->rchLbl.font=RalewayRegular(self->appDelegate.font-2);
//                 [self->statusScroll addSubview:self->rchLbl];
//
//
//
//             }
//             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"4"])
//             {
//                 self->appDelegate.bookingstatusStr=@"4";
//
//                 UIView * rchView=[[UIView alloc]initWithFrame:CGRectMake(self->prepareView.frame.origin.x, CGRectGetMaxY(self->rchImg.frame), 1, 40)];
//                 rchView.backgroundColor=RGB(95, 208, 154);
//                 [self->statusScroll addSubview:rchView];
//
//
//                 UIImageView * doneImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self->rchImg.frame)+40, 11, 10)];
//                 doneImg.image=image(@"Progress");
//                 [self->statusScroll addSubview:doneImg];
//
//                 self->doneLbl=[[UILabel alloc]initWithFrame:CGRectMake(self->prepareLbl.frame.origin.x,CGRectGetMaxY(self->rchLbl.frame)+30,self->prepareLbl.frame.size.width, 21)];
//                 self->doneLbl.text=@"Work Done";
//                 self->doneLbl.textColor=Singlecolor(blackColor);
//                 self->doneLbl.font=RalewayRegular(self->appDelegate.font-2);
//                 [self->statusScroll addSubview:self->doneLbl];
//
//
//                 UIButton *  doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(self->doneLbl.frame)+10, 100, 30)];
//                 [doneBtn setBackgroundColor:Singlecolor(clearColor)];
//                 [doneBtn setTitle:@"Completed" forState:UIControlStateNormal];
//                 doneBtn.titleLabel.font=RalewayRegular(self->appDelegate.font-2);
//                 [doneBtn setTitleColor:RGB(113, 209, 154) forState:UIControlStateNormal];
//                 doneBtn.layer.cornerRadius = 5;
//                 doneBtn.layer.borderWidth = 0.5;
//                 doneBtn.layer.masksToBounds = true;
//                 doneBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
//                 [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
//                 [self->statusScroll addSubview:doneBtn];
//
//
//             }
//             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"6"])
//             {
//                 self->appDelegate.bookingstatusStr=@"6";
//
//                 [self->getbookingtimer invalidate];
//                 self->getbookingtimer = nil;
//                 billViewController * bill=[[billViewController alloc]init];
//                 bill.bookidStr=self->appDelegate.bookingidStr;
//                 [self.navigationController pushViewController:bill animated:YES];
//             }
         }
         //self->statusScroll.contentSize=CGSizeMake(SCREEN_WIDTH, self.view.frame.size.height/1.5);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
        if ([string isEqualToString:@"Yes"])
        {
            bookstatusStr=@"5";
            [self updatelocation];
        }
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





- (void)updatelocation
{
    [appDelegate startProgressView:self.view];
    NSString *url =[UrlGenerator Postupdatestatus];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":appDelegate.bookingidStr,@"bookingStatus":bookstatusStr
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
             self->bookstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"];
           
             
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}


-(void)viewWillAppear:(BOOL)animated
{
    
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
