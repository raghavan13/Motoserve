//
//  TryagainViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "TryagainViewController.h"
#import "CPMetaFile.h"
#import "AppDelegate.h"
@interface TryagainViewController ()
{
    UIView * navHeader,*contentView;
    AppDelegate * appDelegate;
    int currentsecond,overallsecond;
    NSTimer * bookingtimer,*checkemptyresponseTimer;
    UIButton *  tryagainBtn;
}
@end

@implementation TryagainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Booking Request" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    [self createdesign];
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

- (void)createdesign
{
    UIImageView * headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(40, IS_IPHONEX?110:90, contentView.frame.size.width-80, contentView.frame.size.height/5.0)];
    headerImg.image=image(@"tryagainheader");
    [contentView addSubview:headerImg];
    
    
    UIView * waitingView=[[UIView alloc]initWithFrame:CGRectMake(headerImg.frame.origin.x, CGRectGetMaxY(headerImg.frame)+60, headerImg.frame.size.width, headerImg.frame.size.height-60)];
    [contentView addSubview:waitingView];
    waitingView.layer.borderColor = [UIColor blackColor].CGColor;
    waitingView.layer.borderWidth = 1.0f;
    waitingView.layer.cornerRadius = 8;
    waitingView.layer.masksToBounds = true;
    
    
    UILabel * waitingLbl=[[UILabel alloc]initWithFrame:CGRectMake(waitingView.frame.size.width/3.5, 10, waitingView.frame.size.width/2.5, waitingView.frame.size.height-20)];
    waitingLbl.text=@"Waiting for service provider acceptance........";
    waitingLbl.textAlignment=NSTextAlignmentCenter;
    [waitingView addSubview:waitingLbl];
    waitingLbl.numberOfLines=0;
    waitingLbl.textColor=Singlecolor(blackColor);
    waitingLbl.font=RalewayRegular(appDelegate.font-2);
    
    
//    UIView * callView=[[UIView alloc]initWithFrame:CGRectMake(waitingView.frame.origin.x+20, CGRectGetMaxY(waitingView.frame)+20, waitingView.frame.size.width-40, 50)];
//    callView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    callView.layer.borderWidth = 1.0f;
//    callView.layer.cornerRadius = 8;
//    callView.layer.masksToBounds = true;
//    [contentView addSubview:callView];
    
    
    UIButton * callBtn=[[UIButton alloc]initWithFrame:CGRectMake(waitingView.frame.origin.x+20, CGRectGetMaxY(waitingView.frame)+20, waitingView.frame.size.width-40, 50)];
    callBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    callBtn.layer.borderWidth = 1.0f;
    callBtn.layer.cornerRadius = 8;
    callBtn.layer.masksToBounds = true;
    [callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:callBtn];
    
    UILabel * noLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, callBtn.frame.size.width/1.4, callBtn.frame.size.height)];
    noLbl.text=@"8778441334000";
    noLbl.textAlignment=NSTextAlignmentCenter;
    [callBtn addSubview:noLbl];
    noLbl.textColor=Singlecolor(blackColor);
    noLbl.font=RalewayRegular(appDelegate.font-2);
    
    UIImageView * callImg=[[UIImageView alloc]initWithFrame:CGRectMake(callBtn.frame.size.width-60, callBtn.frame.size.height/2.0-15, 50, 30)];
    callImg.image=image(@"24");
    [callBtn addSubview:callImg];
    
//    UIButton * callBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, callView.frame.size.width, callView.frame.size.height)];
//    [callView addSubview:callBtn];
    
    
    
    tryagainBtn=[[UIButton alloc]initWithFrame:CGRectMake(contentView.frame.size.width/4, CGRectGetMaxY(callBtn.frame)+30, contentView.frame.size.width/4, 25)];
    [tryagainBtn setBackgroundImage:image(@"tryagain") forState:UIControlStateNormal];
    [tryagainBtn addTarget:self action:@selector(tryagainAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:tryagainBtn];
    
    UIButton * cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tryagainBtn.frame)+5, tryagainBtn.frame.origin.y, tryagainBtn.frame.size.width, tryagainBtn.frame.size.height)];
    [cancelBtn setBackgroundImage:image(@"cancel") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    overallsecond=0;
}


- (void)callAction
{
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",@"8778441334"];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}
- (void)tryagainAction
{
    [appDelegate startProgressView:self.view];
    currentsecond=0;
    checkemptyresponseTimer=[NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(handleTimer)userInfo:nil repeats:YES];
    [self getbooking];
    bookingtimer= [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
}

- (void)cancelAction
{
    [checkemptyresponseTimer invalidate];
    checkemptyresponseTimer = nil;
    [bookingtimer invalidate];
    bookingtimer = nil;
    currentsecond=181;
    [self->appDelegate stopProgressView];
    [Utils showErrorAlert:@"Sorry for inconvience" delegate:nil];
    constraintViewController * home=[[constraintViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}
- (void)handleTimer
{
    currentsecond++;
    overallsecond++;
    if (overallsecond==1800) {
        [checkemptyresponseTimer invalidate];
        checkemptyresponseTimer = nil;
        [bookingtimer invalidate];
        bookingtimer = nil;
        currentsecond=181;
        [self->appDelegate stopProgressView];
        tryagainBtn.hidden=YES;
    }
    else if (currentsecond==180) {
        [checkemptyresponseTimer invalidate];
        checkemptyresponseTimer = nil;
        [bookingtimer invalidate];
        bookingtimer = nil;
        currentsecond=181;
        [self->appDelegate stopProgressView];
    }
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
                 if (self->currentsecond>181) {
                     [self->appDelegate stopProgressView];
                     
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
@end
