//
//  ConstraintspuntureViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 03/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "ConstraintspuntureViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
@interface ConstraintspuntureViewController ()<SSPopupDelegate,CLLocationManagerDelegate>
{
    UIView *navHeader;
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

@implementation ConstraintspuntureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Punture Request" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    
    vehiclenoBtn=[[UIButton alloc]init];
    [self.view addSubview:vehiclenoBtn];
    vehiclenoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [vehiclenoBtn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?150:120].active=YES;
    [vehiclenoBtn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:60].active=YES;
    [vehiclenoBtn.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-60].active=YES;
    [vehiclenoBtn.heightAnchor constraintEqualToConstant:40].active=YES;
    vehiclenoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [vehiclenoBtn setTitle:@"Select Vechicle Number" forState:UIControlStateNormal];
    [vehiclenoBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [vehiclenoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,20,0,0)];
    vehiclenoBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    vehiclenoBtn.titleLabel.font=RalewayRegular(appDelegate.font-4);
    vehiclenoBtn.layer.cornerRadius = 5;
    vehiclenoBtn.layer.masksToBounds = true;
    vehiclenoBtn.layer.borderWidth = 0.5;
    vehiclenoBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [vehiclenoBtn addTarget:self action:@selector(vehicleno:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIImageView * dropImg=[[UIImageView alloc]init];
    [vehiclenoBtn addSubview:dropImg];
    dropImg.translatesAutoresizingMaskIntoConstraints = NO;
    [dropImg.centerYAnchor constraintEqualToAnchor:vehiclenoBtn.centerYAnchor constant:0].active=YES;
    [dropImg.rightAnchor constraintEqualToAnchor:vehiclenoBtn.rightAnchor constant:-20].active=YES;
    [dropImg.widthAnchor constraintEqualToConstant:19].active=YES;
    [dropImg.heightAnchor constraintEqualToConstant:10].active=YES;
    dropImg.image=image(@"dropdown");
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
//    latArray=[[NSMutableArray alloc]init];
//    [latArray addObject:@"80.1478233"];
//    [latArray addObject:@"12.9572028"];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSDictionary * parameters = @{
                                  @"userId":[login valueForKey:@"_id"],@"vehicleId":vehicleidStr,@"location":locationDic,@"serviceType":@"P",@"serviceOn":@"o"
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
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"0"]) {
                 self->appDelegate.bookingstatusStr=@"0";
                 if (self->currentsecond==181) {
                     [self->appDelegate stopProgressView];
                     TryagainViewController * try=[[TryagainViewController alloc]init];
                     [self.navigationController pushViewController:try animated:YES];
                 }
             }
             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"1"])
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

- (void)createDesign
{
    [detailView removeFromSuperview];
    detailView=[[UIView alloc]init];
    [self.view addSubview:detailView];
    detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [detailView.topAnchor constraintEqualToAnchor:vehiclenoBtn.bottomAnchor constant:30].active=YES;
    [detailView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
    [detailView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [detailView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
    //detailView.backgroundColor=Singlecolor(redColor);
    
    UILabel * vechicledetailLbl=[[UILabel alloc]init];
    [detailView addSubview:vechicledetailLbl];
    vechicledetailLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [vechicledetailLbl.topAnchor constraintEqualToAnchor:detailView.topAnchor constant:0].active=YES;
    [vechicledetailLbl.leftAnchor constraintEqualToAnchor:detailView.leftAnchor constant:0].active=YES;
    [vechicledetailLbl.rightAnchor constraintEqualToAnchor:detailView.rightAnchor constant:0].active=YES;
    [vechicledetailLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    vechicledetailLbl.text=@"Vehicle Details";
    vechicledetailLbl.textAlignment=NSTextAlignmentCenter;
    
    
    UILabel * typeLbl=[[UILabel alloc]init];
    [detailView addSubview:typeLbl];
    typeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typeLbl.topAnchor constraintEqualToAnchor:vechicledetailLbl.bottomAnchor constant:20].active=YES;
    [typeLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [typeLbl.widthAnchor constraintEqualToAnchor:vehiclenoBtn.widthAnchor multiplier:0.5].active=YES;
    typeLbl.text=@"Vehicle Type";
    typeLbl.font=RalewayRegular(appDelegate.font-2);
    typeLbl.textColor=Singlecolor(blackColor);
    typeLbl.numberOfLines=2;
   // typeLbl.backgroundColor=Singlecolor(greenColor);
    
    UILabel * typedivLbl=[[UILabel alloc]init];
    [detailView addSubview:typedivLbl];
    typedivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typedivLbl.topAnchor constraintEqualToAnchor:vechicledetailLbl.bottomAnchor constant:20].active=YES;
    [typedivLbl.leftAnchor constraintEqualToAnchor:typeLbl.rightAnchor constant:5].active=YES;
    [typedivLbl.widthAnchor constraintEqualToConstant:1];
    typedivLbl.text=@":   ";
    
    
    UILabel * typevalLbl=[[UILabel alloc]init];
    [detailView addSubview:typevalLbl];
    typevalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typevalLbl.topAnchor constraintEqualToAnchor:vechicledetailLbl.bottomAnchor constant:20].active=YES;
    [typevalLbl.leftAnchor constraintEqualToAnchor:typedivLbl.rightAnchor constant:5].active=YES;
    [typevalLbl.widthAnchor constraintEqualToAnchor:vehiclenoBtn.widthAnchor multiplier:0.5].active=YES;
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
    typevalLbl.numberOfLines=2;
    //typevalLbl.text=@":     Car";
    
    UILabel * brandLbl=[[UILabel alloc]init];
    [detailView addSubview:brandLbl];
    brandLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [brandLbl.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:30].active=YES;
    [brandLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [brandLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    brandLbl.text=@"Brand";
    brandLbl.font=RalewayRegular(appDelegate.font-2);
    brandLbl.textColor=Singlecolor(blackColor);
    brandLbl.numberOfLines=2;
    
    UILabel * branddivLbl=[[UILabel alloc]init];
    [detailView addSubview:branddivLbl];
    branddivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [branddivLbl.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:30].active=YES;
    [branddivLbl.leftAnchor constraintEqualToAnchor:brandLbl.rightAnchor constant:5].active=YES;
    [branddivLbl.widthAnchor constraintEqualToConstant:1];
    branddivLbl.text=@":   ";
    
    
    UILabel * brandvalLbl=[[UILabel alloc]init];
    [detailView addSubview:brandvalLbl];
    brandvalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [brandvalLbl.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:30].active=YES;
    [brandvalLbl.leftAnchor constraintEqualToAnchor:branddivLbl.rightAnchor constant:5].active=YES;
    [brandvalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"brand"]]) {
        brandvalLbl.text=[NSString stringWithFormat:@"%@",[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"brand"]];
    }
    brandvalLbl.font=RalewayRegular(appDelegate.font-2);
    brandvalLbl.textColor=Singlecolor(blackColor);
    brandvalLbl.numberOfLines=2;
    //brandvalLbl.text=[NSString stringWithFormat:@":     yamaha"];
    
    UILabel * modelLbl=[[UILabel alloc]init];
    [detailView addSubview:modelLbl];
    modelLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [modelLbl.topAnchor constraintEqualToAnchor:brandLbl.bottomAnchor constant:30].active=YES;
    [modelLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [modelLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    modelLbl.text=@"Model";
    modelLbl.font=RalewayRegular(appDelegate.font-2);
    modelLbl.textColor=Singlecolor(blackColor);
    modelLbl.numberOfLines=2;
    
    
    UILabel * modeldivLbl=[[UILabel alloc]init];
    [detailView addSubview:modeldivLbl];
    modeldivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [modeldivLbl.topAnchor constraintEqualToAnchor:brandLbl.bottomAnchor constant:30].active=YES;
    [modeldivLbl.leftAnchor constraintEqualToAnchor:modelLbl.rightAnchor constant:5].active=YES;
    [modeldivLbl.widthAnchor constraintEqualToConstant:1];
    modeldivLbl.text=@":   ";
    
    UILabel * modelvalLbl=[[UILabel alloc]init];
    [detailView addSubview:modelvalLbl];
    modelvalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [modelvalLbl.topAnchor constraintEqualToAnchor:brandLbl.bottomAnchor constant:30].active=YES;
    [modelvalLbl.leftAnchor constraintEqualToAnchor:modeldivLbl.rightAnchor constant:5].active=YES;
    [modelvalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"model"]]) {
        modelvalLbl.text=[NSString stringWithFormat:@"%@",[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"model"]];
    }
    modelvalLbl.font=RalewayRegular(appDelegate.font-2);
    modelvalLbl.textColor=Singlecolor(blackColor);
    modelvalLbl.numberOfLines=2;
   // modelvalLbl.text=[NSString stringWithFormat:@":     yamaha"];
    
    
    UILabel * tyreLbl=[[UILabel alloc]init];
    [detailView addSubview:tyreLbl];
    tyreLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tyreLbl.topAnchor constraintEqualToAnchor:modelLbl.bottomAnchor constant:30].active=YES;
    [tyreLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [tyreLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    tyreLbl.text=@"Tyre Type";
    tyreLbl.font=RalewayRegular(appDelegate.font-2);
    tyreLbl.textColor=Singlecolor(blackColor);
    tyreLbl.numberOfLines=2;
    
    
    UILabel * tyredivLbl=[[UILabel alloc]init];
    [detailView addSubview:tyredivLbl];
    tyredivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tyredivLbl.topAnchor constraintEqualToAnchor:modelLbl.bottomAnchor constant:30].active=YES;
    [tyredivLbl.leftAnchor constraintEqualToAnchor:tyreLbl.rightAnchor constant:5].active=YES;
    [tyredivLbl.widthAnchor constraintEqualToConstant:1];
    tyredivLbl.text=@":   ";
    
    
    UILabel * tyrevalLbl=[[UILabel alloc]init];
    [detailView addSubview:tyrevalLbl];
    tyrevalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tyrevalLbl.topAnchor constraintEqualToAnchor:modelLbl.bottomAnchor constant:30].active=YES;
    [tyrevalLbl.leftAnchor constraintEqualToAnchor:tyredivLbl.rightAnchor constant:5].active=YES;
    [tyrevalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"tyreType"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"tyreType"]isEqualToString:@"TL"]) {
            tyrevalLbl.text=[NSString stringWithFormat:@"Tubeless"];
        }
        else
        {
            tyrevalLbl.text=[NSString stringWithFormat:@"Tube"];
        }
    }
    tyrevalLbl.font=RalewayRegular(appDelegate.font-2);
    tyrevalLbl.textColor=Singlecolor(blackColor);
    tyrevalLbl.numberOfLines=2;
    //tyrevalLbl.text=[NSString stringWithFormat:@":     yamaha"];
    
    UILabel * engineLbl=[[UILabel alloc]init];
    [detailView addSubview:engineLbl];
    engineLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [engineLbl.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:30].active=YES;
    [engineLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [engineLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    engineLbl.text=@"Engine Type";
    engineLbl.font=RalewayRegular(appDelegate.font-2);
    engineLbl.textColor=Singlecolor(blackColor);
    engineLbl.numberOfLines=2;
    
    
    UILabel * enginedivLbl=[[UILabel alloc]init];
    [detailView addSubview:enginedivLbl];
    enginedivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [enginedivLbl.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:30].active=YES;
    [enginedivLbl.leftAnchor constraintEqualToAnchor:engineLbl.rightAnchor constant:5].active=YES;
    [enginedivLbl.widthAnchor constraintEqualToConstant:1];
    enginedivLbl.text=@":   ";
    
    UILabel * enginevalLbl=[[UILabel alloc]init];
    [detailView addSubview:enginevalLbl];
    enginevalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [enginevalLbl.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:30].active=YES;
    [enginevalLbl.leftAnchor constraintEqualToAnchor:enginedivLbl.rightAnchor constant:5].active=YES;
    [enginevalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"engineType"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"engineType"]isEqualToString:@"P"]) {
            enginevalLbl.text=[NSString stringWithFormat:@"Petrol"];
        }
        else
        {
            enginevalLbl.text=[NSString stringWithFormat:@"Diesel"];
        }
    }
    enginevalLbl.font=RalewayRegular(appDelegate.font-2);
    enginevalLbl.textColor=Singlecolor(blackColor);
    //enginevalLbl.text=[NSString stringWithFormat:@":     yamaha"];
    enginevalLbl.numberOfLines=2;
    
    
    UILabel * jockeyLbl=[[UILabel alloc]init];
    [detailView addSubview:jockeyLbl];
    jockeyLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [jockeyLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:30].active=YES;
    [jockeyLbl.leftAnchor constraintEqualToAnchor:vehiclenoBtn.leftAnchor constant:20].active=YES;
    [jockeyLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    jockeyLbl.text=@"Jockey";
    jockeyLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyLbl.textColor=Singlecolor(blackColor);
    jockeyLbl.numberOfLines=2;
    
    
    UILabel * jockeydivLbl=[[UILabel alloc]init];
    [detailView addSubview:jockeydivLbl];
    jockeydivLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [jockeydivLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:30].active=YES;
    [jockeydivLbl.leftAnchor constraintEqualToAnchor:jockeyLbl.rightAnchor constant:5].active=YES;
    [jockeydivLbl.widthAnchor constraintEqualToConstant:1];
    jockeydivLbl.text=@":   ";
    
    UILabel * jockeyvalLbl=[[UILabel alloc]init];
    [detailView addSubview:jockeyvalLbl];
    jockeyvalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [jockeyvalLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:30].active=YES;
    [jockeyvalLbl.leftAnchor constraintEqualToAnchor:jockeydivLbl.rightAnchor constant:5].active=YES;
    [jockeyvalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"carJockey"]]) {
        if ([[[vehicleDic objectAtIndex:selecedvehicle]valueForKey:@"carJockey"]isEqualToString:@"1"]) {
            jockeyvalLbl.text=[NSString stringWithFormat:@"Yes"];
        }
        else
        {
            jockeyvalLbl.text=[NSString stringWithFormat:@"No"];
        }
    }
    jockeyvalLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyvalLbl.textColor=Singlecolor(blackColor);
    jockeyvalLbl.numberOfLines=2;
    //jockeyvalLbl.text=[NSString stringWithFormat:@":     yamaha"];
    
    UIButton *  submitBtn=[[UIButton alloc]init];
    [detailView addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.centerXAnchor constraintEqualToAnchor:detailView.centerXAnchor constant:0].active=YES;
    [submitBtn.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:40].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:150].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Book Service" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}

@end
