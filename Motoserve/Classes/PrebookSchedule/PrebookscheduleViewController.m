//
//  PrebookscheduleViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 25/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "PrebookscheduleViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface PrebookscheduleViewController ()<SSPopupDelegate>
{
    UIView *navHeader;
    AppDelegate * appDelegate;
    UIView *DatePickerView;
    UIDatePicker *myPicker;
    UILabel * dateLbl,*timeinsideLbl;
    SSPopup* selection;
    NSArray * timeseperateArray;
    NSMutableArray * timeArray;
}
@end

@implementation PrebookscheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Pre Booking Shedule" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    timeArray=[[NSMutableArray alloc]initWithObjects:@"09:00 AM - 11:00 AM",@"10:00 AM - 12:00 PM",@"11:00 AM - 01:00 PM",@"12:00 PM - 02:00 PM",@"01:00 PM - 03:00 PM",@"02:00 PM - 04:00 PM",@"04:00 PM - 06:00 PM", nil];
    [self createdesign];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createdesign
{
    UIView * MainView=[[UIView alloc]init];
    [self.view addSubview:MainView];
    MainView.translatesAutoresizingMaskIntoConstraints = NO;
    [MainView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?130:110].active=YES;
    [MainView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10].active=YES;
    [MainView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active=YES;
    [MainView.heightAnchor constraintEqualToConstant:110].active=YES;
    MainView.backgroundColor=Singlecolor(clearColor);
    MainView.layer.borderColor = [UIColor clearColor].CGColor;
    MainView.layer.borderWidth = 1.0f;
    MainView.layer.cornerRadius = 8;
    MainView.layer.masksToBounds = true;
    
    
    UIButton * bgBtn=[[UIButton alloc]init];
    [MainView addSubview:bgBtn];
    bgBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [bgBtn.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:0].active=YES;
    [bgBtn.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:0].active=YES;
    [bgBtn.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:0].active=YES;
    [bgBtn.heightAnchor constraintEqualToAnchor:MainView.heightAnchor constant:0].active=YES;
    [bgBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
    bgBtn.userInteractionEnabled=NO;
    
    
    UIImageView * headerImg=[[UIImageView alloc]init];
    [MainView addSubview:headerImg];
    headerImg.translatesAutoresizingMaskIntoConstraints = NO;
    [headerImg.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:5].active=YES;
    [headerImg.centerXAnchor constraintEqualToAnchor:MainView.centerXAnchor constant:5].active=YES;
    [headerImg.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2.5].active=YES;
    [headerImg.heightAnchor constraintEqualToConstant:21].active=YES;
    headerImg.image=image(@"service_header");
    
    
    UILabel * serviceLbl=[[UILabel alloc]init];
    [headerImg addSubview:serviceLbl];
    serviceLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [serviceLbl.topAnchor constraintEqualToAnchor:headerImg.topAnchor constant:0].active=YES;
    [serviceLbl.leftAnchor constraintEqualToAnchor:headerImg.leftAnchor constant:0].active=YES;
    [serviceLbl.widthAnchor constraintEqualToAnchor:headerImg.widthAnchor constant:0].active=YES;
    [serviceLbl.heightAnchor constraintEqualToAnchor:headerImg.heightAnchor constant:0].active=YES;
    if ( [appDelegate.servicetype isEqualToString:@"R"]) {
       serviceLbl.text=@"Repair Service";
    }
    else if ([appDelegate.servicetype isEqualToString:@"O"])
    {
       serviceLbl.text=@"Oil Change";
    }
    else if ([appDelegate.servicetype isEqualToString:@"W"])
    {
        serviceLbl.text=@"Wheel Alignment";
    }
    else if ([appDelegate.servicetype isEqualToString:@"S"])
    {
        serviceLbl.text=@"Spa";
    }
    else if ([appDelegate.servicetype isEqualToString:@"T"])
    {
        serviceLbl.text=@"Painting";
    }
    else
    {
        serviceLbl.text=@"AC Repair";
    }
    serviceLbl.textColor=Singlecolor(whiteColor);
    serviceLbl.textAlignment=NSTextAlignmentCenter;
    serviceLbl.font=RalewayRegular(appDelegate.font-6);
    
    UIImageView * carImg=[[UIImageView alloc]init];
    [MainView addSubview:carImg];
    carImg.translatesAutoresizingMaskIntoConstraints = NO;
    [carImg.centerYAnchor constraintEqualToAnchor:MainView.centerYAnchor constant:5].active=YES;
    [carImg.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:20].active=YES;
    [carImg.widthAnchor constraintEqualToConstant:60].active=YES;
    [carImg.heightAnchor constraintEqualToConstant:30].active=YES;
    if ([[_vehicledetailDic valueForKey:@"vehicleType"]isEqualToString:@"C"]) {
        carImg.image=image(@"order_car");
    }
    else
    {
        carImg.image=image(@"order_bike");
    }
    
    
    UIView * imgdiv=[[UIView alloc]init];
    [MainView addSubview:imgdiv];
    imgdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [imgdiv.topAnchor constraintEqualToAnchor:headerImg.bottomAnchor constant:20].active=YES;
    [imgdiv.leftAnchor constraintEqualToAnchor:carImg.rightAnchor constant:5].active=YES;
    [imgdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [imgdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-20].active=YES;
    imgdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    UILabel * noLbl=[[UILabel alloc]init];
    [MainView addSubview:noLbl];
    noLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [noLbl.topAnchor constraintEqualToAnchor:headerImg.bottomAnchor constant:5].active=YES;
    [noLbl.leftAnchor constraintEqualToAnchor:imgdiv.leftAnchor constant:10].active=YES;
    [noLbl.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-10].active=YES;
    [noLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    noLbl.text=[NSString stringWithFormat:@"%@",[_vehicledetailDic valueForKey:@"vehicleNumber"]];
    noLbl.textColor=Singlecolor(grayColor);
    noLbl.textAlignment=NSTextAlignmentLeft;
    noLbl.font=RalewayRegular(appDelegate.font-5);
    
    
    UILabel * typeLbl=[[UILabel alloc]init];
    [MainView addSubview:typeLbl];
    typeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typeLbl.topAnchor constraintEqualToAnchor:noLbl.bottomAnchor constant:0].active=YES;
    [typeLbl.leftAnchor constraintEqualToAnchor:noLbl.leftAnchor constant:0].active=YES;
    [typeLbl.rightAnchor constraintEqualToAnchor:noLbl.rightAnchor constant:0].active=YES;
    [typeLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    typeLbl.text=[NSString stringWithFormat:@"%@",[_vehicledetailDic valueForKey:@"model"]];
    typeLbl.textAlignment=NSTextAlignmentLeft;
    typeLbl.textColor=Singlecolor(grayColor);
    typeLbl.font=RalewayRegular(appDelegate.font-5);
    
    
    UILabel * servicecenterLbl=[[UILabel alloc]init];
    [MainView addSubview:servicecenterLbl];
    servicecenterLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [servicecenterLbl.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:0].active=YES;
    [servicecenterLbl.leftAnchor constraintEqualToAnchor:noLbl.leftAnchor constant:0].active=YES;
    [servicecenterLbl.rightAnchor constraintEqualToAnchor:noLbl.rightAnchor constant:0].active=YES;
    [servicecenterLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    servicecenterLbl.text=@"Rasi Motors, Tambaram";
    servicecenterLbl.textAlignment=NSTextAlignmentLeft;
    servicecenterLbl.textColor=Singlecolor(grayColor);
    servicecenterLbl.font=RalewayRegular(appDelegate.font-5);
    
    
    UILabel * scheduledateLbl=[[UILabel alloc]init];
    [self.view addSubview:scheduledateLbl];
    scheduledateLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [scheduledateLbl.topAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:10].active=YES;
    [scheduledateLbl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:80].active=YES;
    [scheduledateLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    scheduledateLbl.text=@"Schedule Date";
    scheduledateLbl.textAlignment=NSTextAlignmentLeft;
    scheduledateLbl.textColor=Singlecolor(grayColor);
    scheduledateLbl.font=RalewayRegular(appDelegate.font-4);
    scheduledateLbl.textColor=RGB(0, 89, 42);
    [scheduledateLbl autowidth:0.0];
    
    
    UIView * datedivView=[[UIView alloc]init];
    [self.view addSubview:datedivView];
    datedivView.translatesAutoresizingMaskIntoConstraints = NO;
    [datedivView.topAnchor constraintEqualToAnchor:scheduledateLbl.bottomAnchor constant:0].active=YES;
    [datedivView.leftAnchor constraintEqualToAnchor:scheduledateLbl.leftAnchor constant:0].active=YES;
    [datedivView.widthAnchor constraintEqualToAnchor:scheduledateLbl.widthAnchor constant:10].active=YES;
    [datedivView.heightAnchor constraintEqualToConstant:1].active=YES;
    datedivView.backgroundColor=Singlecolor(lightGrayColor);
    
    UIButton * choosedateBtn=[[UIButton alloc]init];
    [self.view addSubview:choosedateBtn];
    choosedateBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [choosedateBtn.topAnchor constraintEqualToAnchor:datedivView.bottomAnchor constant:10].active=YES;
    [choosedateBtn.leftAnchor constraintEqualToAnchor:scheduledateLbl.leftAnchor constant:0].active=YES;
    [choosedateBtn.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-80].active=YES;
    [choosedateBtn.heightAnchor constraintEqualToConstant:50].active=YES;
    [choosedateBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
    choosedateBtn.userInteractionEnabled=YES;
    [choosedateBtn addTarget:self action:@selector(CreateDatePicker) forControlEvents:UIControlEventTouchUpInside];

    UIView * dateimgdivView=[[UIView alloc]init];
    [choosedateBtn addSubview:dateimgdivView];
    dateimgdivView.translatesAutoresizingMaskIntoConstraints = NO;
    [dateimgdivView.topAnchor constraintEqualToAnchor:choosedateBtn.topAnchor constant:10].active=YES;
    [dateimgdivView.rightAnchor constraintEqualToAnchor:choosedateBtn.rightAnchor constant:-50].active=YES;
    [dateimgdivView.widthAnchor constraintEqualToConstant:1].active=YES;
    [dateimgdivView.bottomAnchor constraintEqualToAnchor:choosedateBtn.bottomAnchor constant:-10].active=YES;
    dateimgdivView.backgroundColor=Singlecolor(lightGrayColor);
    
    
    UIImageView * dateimg=[[UIImageView alloc]init];
    [choosedateBtn addSubview:dateimg];
    dateimg.translatesAutoresizingMaskIntoConstraints = NO;
    [dateimg.centerYAnchor constraintEqualToAnchor:choosedateBtn.centerYAnchor constant:0].active=YES;
    [dateimg.leftAnchor constraintEqualToAnchor:dateimgdivView.rightAnchor constant:10].active=YES;
    [dateimg.widthAnchor constraintEqualToConstant:20].active=YES;
    [dateimg.heightAnchor constraintEqualToConstant:20].active=YES;
    dateimg.image=image(@"scheduledate");
    
    dateLbl=[[UILabel alloc]init];
    [choosedateBtn addSubview:dateLbl];
    dateLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [dateLbl.topAnchor constraintEqualToAnchor:choosedateBtn.topAnchor constant:0].active=YES;
    [dateLbl.leftAnchor constraintEqualToAnchor:choosedateBtn.leftAnchor constant:10].active=YES;
    [dateLbl.rightAnchor constraintEqualToAnchor:dateimgdivView.leftAnchor constant:-10].active=YES;
    [dateLbl.heightAnchor constraintEqualToAnchor:choosedateBtn.heightAnchor constant:0].active=YES;
    dateLbl.text=@"Choose Date";
    dateLbl.textColor=Singlecolor(grayColor);
    dateLbl.font=RalewayRegular(appDelegate.font-4);
    


    UILabel * timeLbl=[[UILabel alloc]init];
    [self.view addSubview:timeLbl];
    timeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [timeLbl.topAnchor constraintEqualToAnchor:choosedateBtn.bottomAnchor constant:30].active=YES;
    [timeLbl.leftAnchor constraintEqualToAnchor:scheduledateLbl.leftAnchor constant:0].active=YES;
    [timeLbl.widthAnchor constraintEqualToAnchor:scheduledateLbl.widthAnchor constant:0].active=YES;
    [timeLbl.heightAnchor constraintEqualToAnchor:scheduledateLbl.heightAnchor constant:0].active=YES;
    timeLbl.text=@"Time";
    timeLbl.textAlignment=NSTextAlignmentCenter;
    timeLbl.textColor=Singlecolor(grayColor);
    timeLbl.font=RalewayRegular(appDelegate.font-4);
    timeLbl.textColor=RGB(0, 89, 42);



    UIView * timedivView=[[UIView alloc]init];
    [self.view addSubview:timedivView];
    timedivView.translatesAutoresizingMaskIntoConstraints = NO;
    [timedivView.topAnchor constraintEqualToAnchor:timeLbl.bottomAnchor constant:0].active=YES;
    [timedivView.leftAnchor constraintEqualToAnchor:timeLbl.leftAnchor constant:0].active=YES;
    [timedivView.widthAnchor constraintEqualToAnchor:timeLbl.widthAnchor constant:10].active=YES;
    [timedivView.heightAnchor constraintEqualToConstant:1].active=YES;
    timedivView.backgroundColor=Singlecolor(lightGrayColor);

    UIButton * choosetimeBtn=[[UIButton alloc]init];
    [self.view addSubview:choosetimeBtn];
    choosetimeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [choosetimeBtn.topAnchor constraintEqualToAnchor:timedivView.bottomAnchor constant:10].active=YES;
    [choosetimeBtn.leftAnchor constraintEqualToAnchor:scheduledateLbl.leftAnchor constant:0].active=YES;
    [choosetimeBtn.rightAnchor constraintEqualToAnchor:choosedateBtn.rightAnchor constant:0].active=YES;
    [choosetimeBtn.heightAnchor constraintEqualToConstant:50].active=YES;
    [choosetimeBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
    choosetimeBtn.userInteractionEnabled=YES;
    [choosetimeBtn addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside];


    UIView * timeimgdivView=[[UIView alloc]init];
    [choosetimeBtn addSubview:timeimgdivView];
    timeimgdivView.translatesAutoresizingMaskIntoConstraints = NO;
    [timeimgdivView.topAnchor constraintEqualToAnchor:choosetimeBtn.topAnchor constant:10].active=YES;
    [timeimgdivView.rightAnchor constraintEqualToAnchor:choosetimeBtn.rightAnchor constant:-50].active=YES;
    [timeimgdivView.widthAnchor constraintEqualToConstant:1].active=YES;
    [timeimgdivView.bottomAnchor constraintEqualToAnchor:choosetimeBtn.bottomAnchor constant:-10].active=YES;
    timeimgdivView.backgroundColor=Singlecolor(lightGrayColor);
    
    
    UIImageView * timeimg=[[UIImageView alloc]init];
    [choosetimeBtn addSubview:timeimg];
    timeimg.translatesAutoresizingMaskIntoConstraints = NO;
    [timeimg.centerYAnchor constraintEqualToAnchor:choosetimeBtn.centerYAnchor constant:0].active=YES;
    [timeimg.leftAnchor constraintEqualToAnchor:timeimgdivView.rightAnchor constant:10].active=YES;
    [timeimg.widthAnchor constraintEqualToConstant:20].active=YES;
    [timeimg.heightAnchor constraintEqualToConstant:20].active=YES;
    timeimg.image=image(@"scheduletime");
    
    timeinsideLbl=[[UILabel alloc]init];
    [choosetimeBtn addSubview:timeinsideLbl];
    timeinsideLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [timeinsideLbl.topAnchor constraintEqualToAnchor:choosetimeBtn.topAnchor constant:0].active=YES;
    [timeinsideLbl.leftAnchor constraintEqualToAnchor:choosetimeBtn.leftAnchor constant:10].active=YES;
    [timeinsideLbl.rightAnchor constraintEqualToAnchor:timeimgdivView.leftAnchor constant:-10].active=YES;
    [timeinsideLbl.heightAnchor constraintEqualToAnchor:choosetimeBtn.heightAnchor constant:0].active=YES;
    timeinsideLbl.text=@"Choose Time";
    timeinsideLbl.textColor=Singlecolor(grayColor);
    timeinsideLbl.font=RalewayRegular(appDelegate.font-4);
    
    
    
    UIButton *  submitBtn=[[UIButton alloc]init];
    [self.view addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active=YES;
    [submitBtn.topAnchor constraintEqualToAnchor:choosetimeBtn.bottomAnchor constant:60].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:150].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Next" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)submitAction
{
    if ([Utils isCheckNotNULL:appDelegate.latArray]) {
        
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator Post_Partnerbylocation];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
        NSMutableDictionary * locationDic=[[NSMutableDictionary alloc]init];
        [locationDic setObject:@"Point" forKey:@"type"];
        [locationDic setObject:appDelegate.latArray forKey:@"coordinates"];
        NSString * typeservice=@"P";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd-MM-yy";
        NSString *currentdate = [NSString stringWithFormat:@"%@",[NSDate date]];
        formatter.dateFormat = @"EEEE";
        NSString *currentday = [formatter stringFromDate:[NSDate date]];
        NSArray * startArray = [[timeseperateArray objectAtIndex:0] componentsSeparatedByString:@":"];
        NSArray * endArray =[[timeseperateArray objectAtIndex:1] componentsSeparatedByString:@":"];
        
        
        NSDictionary * parameters =@{@"userId":[login valueForKey:@"_id"],
                                     @"vehicleId":_vehicleidStr,
                                     @"location":locationDic,
                                     @"serviceType":@"S",
                                     @"subServiceType":appDelegate.servicetype,
                                     @"serviceMode":typeservice,
                                     @"day":currentday,
                                     @"startTime":[startArray objectAtIndex:0],
                                     @"endTime":[endArray objectAtIndex:0],
                                     @"serviceDate":currentdate,
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
                 MapViewController * tryagain=[[MapViewController alloc]init];
                 self->appDelegate.fromschedule=YES;
                 [self.navigationController pushViewController:tryagain animated:YES];
                 [self->appDelegate stopProgressView];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
             [self->appDelegate stopProgressView];
         }];
    }
    
}


- (void)timeAction
{
     [DatePickerView removeFromSuperview];
        
        selection=[[SSPopup alloc]init];
        selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
        selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        selection.SSPopupDelegate=self;
        [self.view.window  addSubview:selection];
        
        [selection CreateTableview:timeArray withSender:nil  withTitle:@"Please select Time" setCompletionBlock:^(int tag){
            self->timeinsideLbl.text=[self->timeArray objectAtIndex:tag];
            self->timeinsideLbl.textColor=Singlecolor(blackColor);
            
            self->timeseperateArray = [self->timeinsideLbl.text componentsSeparatedByString:@" - "];
        }];
}
-(void)CreateDatePicker
{
    
    [self.view endEditing:YES];
    [DatePickerView removeFromSuperview];
    DatePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, appDelegate.hVal, appDelegate.wVal, appDelegate.hVal)];
    DatePickerView.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:0.000 alpha:0.750];
    [self.view addSubview:DatePickerView];
    
    int ypo = 0;
    
    if ([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE6PLUS])
    {
        ypo =appDelegate.hVal/1.5;
    }
    else if([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE6])
    {
        ypo = appDelegate.hVal/1.5;
    }
    else  if ([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE5])
    {
        ypo = appDelegate.hVal/1.56;
    }
    else if ([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE4])
    {
        ypo = appDelegate.hVal/1.6;
    }else {
        ypo = appDelegate.hVal/1.5;
    }
    
    
    UIView *vyt = [[UIView alloc] initWithFrame:CGRectMake(0, ypo, appDelegate.wVal, 40)];
    vyt.backgroundColor=RGB(0, 90, 45);
    [DatePickerView addSubview:vyt];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(vyt.frame.size.width - 80, 0, 80, 40)];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    doneBtn.layer.cornerRadius = 4;
    // doneBtn.titleLabel.font = AllerRegular(appDelegate.font);
    doneBtn.clipsToBounds = YES;
    doneBtn.backgroundColor = [UIColor clearColor];
    [doneBtn addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [vyt addSubview:doneBtn];
    
    UIButton *cance = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [cance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cance setTitle:@"CANCEL" forState:UIControlStateNormal];
    cance.layer.cornerRadius = 4;
    //cance.titleLabel.font = AllerRegular(appDelegate.font);
    ;
    cance.clipsToBounds = YES;
    cance.backgroundColor = [UIColor clearColor];
    [cance addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [vyt addSubview:cance];
    
    CGRect pickerFrame = CGRectMake(0, vyt.frame.origin.y+vyt.frame.size.height, appDelegate.wVal, appDelegate.hVal/3.4);
    myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    myPicker.backgroundColor = Singlecolor(whiteColor);
    myPicker.datePickerMode = UIDatePickerModeDate;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //[comps setDay:maxdate];
   // NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setDay:0];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    myPicker.minimumDate=minDate;
    //myPicker.maximumDate=maxDate;
    [DatePickerView addSubview:myPicker];
    
    [UIView transitionWithView:DatePickerView
                      duration:0.50
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        self->DatePickerView.frame=CGRectMake(0, 0, self->appDelegate.wVal, self->appDelegate.hVal);
                    }
                    completion:nil];
    
}
-(void)doneButtonClick:(id)sender
{
    [self.view endEditing:YES];
    
    [UIView transitionWithView:DatePickerView
                      duration:0.50
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [self performSelector:@selector(removePickerCall) withObject:nil afterDelay:0.5];
                        
                        self->DatePickerView.frame=CGRectMake(0,self->appDelegate.wVal, self->appDelegate.wVal, self->appDelegate.hVal);
                        
                    }
     
                    completion:nil];
    
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"dd-MM-yyyy"];//
    
    dateLbl.text=[format1 stringFromDate:myPicker.date];
    dateLbl.textColor=Singlecolor(blackColor);
}

-(void)cancelButtonClick:(id)sender
{
    [UIView transitionWithView:DatePickerView
                      duration:0.50
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [self performSelector:@selector(removePickerCall) withObject:nil afterDelay:0.5];
                        
                        self->DatePickerView.frame=CGRectMake(0,self->appDelegate.wVal, self->appDelegate.wVal, appDelegate.hVal);
                        
                    }
                    completion:nil];
}

-(void)removePickerCall
{
    [DatePickerView removeFromSuperview];
}

@end
