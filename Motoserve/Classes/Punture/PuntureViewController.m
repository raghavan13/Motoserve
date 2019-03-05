//
//  PuntureViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 09/11/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "PuntureViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
@interface PuntureViewController ()<SSPopupDelegate,CLLocationManagerDelegate>
{
    UIView * navHeader,*contentView;
    AppDelegate * appDelegate;
    SSPopup* selection;
    UIButton * vehiclenoBtn;
    NSMutableArray * vehicleArray;
    NSMutableArray * vehicleDic;
    int selecedvehicle;
    UIView * detailView;
    CLLocationManager *LocationManager;
    CLLocation *Source;
    NSMutableArray * latArray;
    NSString * vehicleidStr;
    NSTimer * checkemptyresponseTimer,*bookingtimer;
    NSInteger currentsecond;
}
@end

@implementation PuntureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Punture Request" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    
    
    vehiclenoBtn=[[UIButton alloc]initWithFrame:CGRectMake(80, IS_IPHONEX?150:120, self.view.frame.size.width-160, 40)];
    vehiclenoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [vehiclenoBtn setTitle:@"Select Vechicle Number" forState:UIControlStateNormal];
    [vehiclenoBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [vehiclenoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,20)];
    [vehiclenoBtn setImageEdgeInsets:UIEdgeInsetsMake(0,vehiclenoBtn.frame.size.width-20,0,0)];
    [vehiclenoBtn setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
    vehiclenoBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    vehiclenoBtn.titleLabel.font=RalewayRegular(appDelegate.font-4);
    vehiclenoBtn.layer.cornerRadius = 5;
    vehiclenoBtn.layer.masksToBounds = true;
    vehiclenoBtn.layer.borderWidth = 0.5;
    vehiclenoBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [vehiclenoBtn addTarget:self action:@selector(vehicleno:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vehiclenoBtn];
    [vehiclenoBtn setBackgroundColor:Singlecolor(redColor)];
    [self GetvehicleAction];
    
    LocationManager = [[CLLocationManager alloc]init];
    LocationManager.delegate = self;
    
    LocationManager.distanceFilter  = kCLDistanceFilterNone;
    LocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [LocationManager requestWhenInUseAuthorization];
    }
    
    [LocationManager startUpdatingLocation];
    latArray=[[NSMutableArray alloc]init];
    [latArray addObject:@"80.1478233"];
    [latArray addObject:@"12.9572028"];
}

- (void)GetvehicleAction
{
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostGetVehicle];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
        NSDictionary * dic = @{
                               @"userId":[login valueForKey:@"_id"]
                               };
    
        [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"response data %@",responseObject);
             [self->appDelegate stopProgressView];
             //[Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             self->vehicleArray=[[NSMutableArray alloc]init];
             if ([[responseObject objectForKey:@"status"]integerValue]==0) {
                 NSLog(@"0");
             }
             else
             {
                 NSLog(@"1");
                 self->vehicleArray=[[[responseObject valueForKey:@"data"]valueForKey:@"vehicleList"]valueForKey:@"vehicleNumber"];
                 self->vehicleDic=[[responseObject valueForKey:@"data"]valueForKey:@"vehicleList"];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
             [self->appDelegate stopProgressView];
         }];
    
}


-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =Singlecolor(whiteColor);
    self.view = contentView;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createDesign
{
    [detailView removeFromSuperview];
     detailView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vehiclenoBtn.frame), contentView.frame.size.width, 100)];
    [contentView addSubview:detailView];
    
    UILabel * vechicledetailLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,40, contentView.frame.size.width, 21)];
    vechicledetailLbl.text=@"Vehicle Details";
    vechicledetailLbl.textAlignment=NSTextAlignmentCenter;
    [detailView addSubview:vechicledetailLbl];
    
    
    UILabel * typeLbl=[[UILabel alloc]initWithFrame:CGRectMake(vehiclenoBtn.frame.origin.x+20, CGRectGetMaxY(vechicledetailLbl.frame)+10, vehiclenoBtn.frame.size.width/2.0-20, 21)];
    typeLbl.text=@"Vehicle Type";
    typeLbl.font=RalewayRegular(appDelegate.font-2);
    typeLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:typeLbl];
    
    UILabel * typevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLbl.frame)+20, CGRectGetMaxY(vechicledetailLbl.frame)+10, vehiclenoBtn.frame.size.width/1.5, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"vehicleType"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"vehicleType"]isEqualToString:@"T"]) {
            typevalLbl.text=@"Bike";
        }
        else
        {
            typevalLbl.text=@"Car";
        }
    }
    typevalLbl.font=RalewayRegular(appDelegate.font-2);
    typevalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:typevalLbl];
    
    UILabel * brandLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(typeLbl.frame)+10, typeLbl.frame.size.width, 21)];
    brandLbl.text=@"Brand";
    brandLbl.font=RalewayRegular(appDelegate.font-2);
    brandLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:brandLbl];
    
    UILabel * brandvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(typeLbl.frame)+10, typevalLbl.frame.size.width, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"brand"]]) {
            brandvalLbl.text=[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"brand"];
    }
    //brandvalLbl.textAlignment=NSTextAlignmentRight;
    brandvalLbl.font=RalewayRegular(appDelegate.font-2);
    brandvalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:brandvalLbl];
    
    
    
    
    UILabel * modelLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(brandLbl.frame)+10, vehiclenoBtn.frame.size.width/2.0-40, 21)];
    modelLbl.text=@"Model";
    modelLbl.font=RalewayRegular(appDelegate.font-2);
    modelLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:modelLbl];
    
    UILabel * modelvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(brandLbl.frame)+10, typevalLbl.frame.size.width, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"model"]]) {
        modelvalLbl.text=[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"model"];
    }
    modelvalLbl.font=RalewayRegular(appDelegate.font-2);
    modelvalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:modelvalLbl];
    
    
    
    
    UILabel * tyreLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(modelLbl.frame)+10, modelLbl.frame.size.width, 21)];
    tyreLbl.text=@"Tyre Type";
    tyreLbl.font=RalewayRegular(appDelegate.font-2);
    tyreLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:tyreLbl];
    
    UILabel * tyrevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(modelLbl.frame)+10, typevalLbl.frame.size.width, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"tyreType"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"tyreType"]isEqualToString:@"TL"]) {
            tyrevalLbl.text=@"Tubeless";
        }
        else
        {
            tyrevalLbl.text=@"Tube";
        }
    }
    tyrevalLbl.font=RalewayRegular(appDelegate.font-2);
    tyrevalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:tyrevalLbl];
    
    UILabel * engineLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(tyreLbl.frame)+10, modelLbl.frame.size.width, 21)];
    engineLbl.text=@"Engine Type";
    engineLbl.font=RalewayRegular(appDelegate.font-2);
    engineLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:engineLbl];
    
    UILabel * enginevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(tyreLbl.frame)+10, typevalLbl.frame.size.width, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"engineType"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"engineType"]isEqualToString:@"P"]) {
            enginevalLbl.text=@"Petrol";
        }
        else
        {
            enginevalLbl.text=@"Diesel";
        }
    }
    enginevalLbl.font=RalewayRegular(appDelegate.font-2);
    enginevalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:enginevalLbl];
    
    
    UILabel * jockeyLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(engineLbl.frame)+10, modelLbl.frame.size.width, 21)];
    jockeyLbl.text=@"Jockey";
    jockeyLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:jockeyLbl];
    
    UILabel * jockeyvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(engineLbl.frame)+10, typevalLbl.frame.size.width, 21)];
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"carJockey"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"carJockey"]isEqualToString:@"1"]) {
            jockeyvalLbl.text=@"Yes";
        }
        else
        {
            jockeyvalLbl.text=@"No";
        }
    }
    jockeyvalLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyvalLbl.textColor=Singlecolor(blackColor);
    [detailView addSubview:jockeyvalLbl];
    
    
   UIButton *  submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-75, CGRectGetMaxY(jockeyvalLbl.frame)+40, 150, 30)];
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Book Service" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(113, 209, 154) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:submitBtn];
    
    detailView.frame=[Utils normalResize:detailView.frame expectedFrame:submitBtn.frame.origin.y+submitBtn.frame.size.height withSpace:20];
    

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *  currentLocation = [locations objectAtIndex:0];
    [LocationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
            // NSLog(@"placemark %@",placemark);
             //NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             // Creates a marker in the center of the map.
             GMSMarker *marker = [[GMSMarker alloc] init];
             marker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
             marker.title = placemark.subLocality;
             marker.snippet = placemark.locality;
             
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
         }
     }];
    NSLog(@"OldLocation %f %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    latArray=[[NSMutableArray alloc]init];
    [latArray addObject:[NSNumber numberWithDouble:currentLocation.coordinate.longitude]];
    [latArray addObject:[NSNumber numberWithDouble:currentLocation.coordinate.latitude]];
    Source = [[CLLocation alloc]init];
    Source = currentLocation;
}

- (void)submitAction
{
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostRequestmap];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
    NSMutableDictionary * locationDic=[[NSMutableDictionary alloc]init];
    [locationDic setObject:@"Point" forKey:@"type"];
    [locationDic setObject:latArray forKey:@"coordinates"];
//        NSDictionary * parameters = @{
//                                      @"userId":[login valueForKey:@"_id"],@"vehicleId":vehicleidStr,@"location":locationDic,@"serviceType":@"P",@"serviceOn":@"o"
//                                      };
    NSString * typeservice=@"P";
    if ([appDelegate.servicetype isEqualToString:@"R"]) {
        typeservice=@"S";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yy";
    NSString *currentdate = [formatter stringFromDate:[NSDate date]];
    formatter.dateFormat = @"dd";
    NSString *currenttime = [formatter stringFromDate:[NSDate date]];
    formatter.dateFormat = @"EE";
    NSString *currentday = [formatter stringFromDate:[NSDate date]];
    NSDictionary * parameters =@{@"userId":[login valueForKey:@"_id"],
                                 @"vehicleId":vehicleidStr,
                                 @"location":locationDic,
                                 @"serviceType":typeservice,
                                 @"subServiceType":appDelegate.servicetype,
                                 @"serviceMode":appDelegate.serviceon,
                                 @"day":currentday,
                                 @"startTime":currenttime,
                                 @"endTime":currenttime,
                                 @"serviceRequiredDate":currentdate,
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
                 self->currentsecond=0;
                 self->appDelegate.bookingidStr=[[responseObject valueForKey:@"data"]valueForKey:@"_id"];
                 self->checkemptyresponseTimer=[NSTimer scheduledTimerWithTimeInterval: 1.0
                                                                                target:self
                                                                              selector:@selector(handleTimer)
                                                                              userInfo:nil
                                                                               repeats:YES];
                 
                 self->bookingtimer= [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
                 [self getbooking];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
             [self->appDelegate stopProgressView];
         }];
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
                 self->appDelegate.bookingstatusStr=@"0";
                 if (self->currentsecond==181) {
                      [self->appDelegate stopProgressView];
                     TryagainViewController * try=[[TryagainViewController alloc]init];
                     [self.navigationController pushViewController:try animated:YES];
                 }
             }
             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]intValue]==1)
             {
                 self->appDelegate.bookingstatusStr=@"1";
                 if (self->currentsecond<=180) {
                 [self->bookingtimer invalidate];
                 self->bookingtimer = nil;
                 [self->checkemptyresponseTimer invalidate];
                 self->checkemptyresponseTimer = nil;
                 self->currentsecond=181;
                 MapViewController * map=[[MapViewController alloc]init];
                 NSLog(@"check----%@",[[[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"partnerId"]valueForKey:@"location"]valueForKey:@"coordinates"]);

                 NSArray * cordArray=[[[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"partnerId"]valueForKey:@"location"]valueForKey:@"coordinates"];

                 map.latStr=[cordArray objectAtIndex:1];
                 map.lonStr=[cordArray objectAtIndex:0];
                 map.serviceprovidername=[[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"partnerId"]valueForKey:@"shopName"];
                [self.navigationController pushViewController:map animated:YES];

             }
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}


- (void)handleTimer
{
    currentsecond++;
    if (currentsecond==180) {
        currentsecond=181;
        [checkemptyresponseTimer invalidate];
        checkemptyresponseTimer = nil;
        [bookingtimer invalidate];
        bookingtimer = nil;
        [self getbooking];
        //[self->appDelegate stopProgressView];
    }
}

//- (void)getpartnerlocation
//{
//    NSString *url =[UrlGenerator PostpartnerLocation];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSDictionary * parameters = @{
//                                  @"bookingId":appDelegate.bookingidStr
//                                  };
//    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//     {
//         NSLog(@"response data %@",responseObject);
//
//         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
//             NSLog(@"0");
//             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
//              [self->appDelegate stopProgressView];
//         }
//         else
//         {
//             NSLog(@"1");
//                 MapViewController * map=[[MapViewController alloc]init];
//                 NSLog(@"%@",[[[[responseObject valueForKey:@"data"]valueForKey:@"partnerLocation"]objectAtIndex:0]valueForKey:@"latitude"]);
//                 map.latStr=[[[[responseObject valueForKey:@"data"]valueForKey:@"partnerLocation"]objectAtIndex:0]valueForKey:@"latitude"];
//                 map.lonStr=[[[[responseObject valueForKey:@"data"]valueForKey:@"partnerLocation"]objectAtIndex:0]valueForKey:@"longitude"];
//                 //map.bookidStr=appDelegate.bookingidStr;
//                 [self.navigationController pushViewController:map animated:YES];
//                  [self->appDelegate stopProgressView];
//             //}
//         }
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         NSLog(@"Error: %@", error);
//         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
//         [self->appDelegate stopProgressView];
//     }];
//}


- (void)vehicleno:(id)sender
{
    if ([Utils isCheckNotNULL:vehicleArray]) {
        selection=[[SSPopup alloc]init];
        selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
        selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        selection.SSPopupDelegate=self;
        [self.view.window  addSubview:selection];
        [selection CreateTableview:vehicleArray withSender:sender  withTitle:@"Please select Vehicle" setCompletionBlock:^(int tag){
            [self->vehiclenoBtn setTitle:[self->vehicleArray objectAtIndex:tag] forState:UIControlStateNormal];
            self->selecedvehicle=tag;
            self->vehicleidStr=[[self->vehicleDic objectAtIndex:tag]valueForKey:@"_id"];
            [self createDesign];
        }];
    }
    
}
@end
