//
//  NewbillViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 08/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "NewbillViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
#import <Razorpay/Razorpay.h>

@interface NewbillViewController ()<RazorpayPaymentCompletionProtocol>
{
    UIView *navHeader;
    AppDelegate * appDelegate;
    NSMutableArray * puntureArray;
    NSTimer *bookingtimer;
    NSString * price;
    UIImageView * cardImg,* cashImg;
    FLAnimatedImageView * sandclockmainImg;
    BOOL paytypeselected,cod;
    Razorpay * razor;
}
@end

@implementation NewbillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Bill Summary" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    
    sandclockmainImg=[[FLAnimatedImageView alloc]init];
    [self.view addSubview:sandclockmainImg];
    sandclockmainImg.translatesAutoresizingMaskIntoConstraints = NO;
    [sandclockmainImg.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?120:100].active=YES;
    [sandclockmainImg.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active=YES;
    [sandclockmainImg.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-40].active=YES;
    [sandclockmainImg.heightAnchor constraintEqualToConstant:SCREEN_HEIGHT/4.0].active=YES;
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"bill" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    sandclockmainImg.animatedImage= animatedImage1;
    sandclockmainImg.contentMode = UIViewContentModeScaleAspectFit;
    [sandclockmainImg startAnimating];
    [self getbooking];
    self->bookingtimer= [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
    paytypeselected=NO;
    cod=NO;
    //[self createDesign];
    razor = [Razorpay initWithKey:@"rzp_test_1DP5mmOlF5G5ag" andDelegate:self];
    //    [NSTimer scheduledTimerWithTimeInterval:10.0
    //                                     target:self
    //                                   selector:@selector(targetMethod)
    //                                   userInfo:nil
    //                                    repeats:NO];
    //
}

//- (void)targetMethod
//{
//    
//    //[self createDesign];
//    
//}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)payment
{
    NSString *url =[UrlGenerator Postpayment];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"bookingId":self->appDelegate.bookingidStr,
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         }
         else
         {
             NSLog(@"1");
             self->sandclockmainImg.hidden=YES;
             [self createDesign];
             self->price=[[[[responseObject valueForKey:@"data"]valueForKey:@"payment"]objectAtIndex:0]valueForKey:@"amount"];
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
                                  @"_id":self->appDelegate.bookingidStr,@"bookingStatus":self->appDelegate.bookingstatusStr
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
             if(self->cod)
             {
                 //SuccessViewController * success=[[SuccessViewController alloc]init];
                 //[self.navigationController pushViewController:success animated:YES];
             }
             else
             {
                 if (![self->appDelegate.bookingstatusStr isEqualToString:@"24"]) {
                     NSDictionary *options = @{
                                               @"amount": @"1000", // mandatory, in paise
                                               // all optional other than amount.
                                               @"image": @"https://url-to-image.png",
                                               @"name": @"business or product name",
                                               @"description": @"purchase description",
                                               @"prefill" : @{
                                                       @"email": @"pranav@razorpay.com",
                                                       @"contact": @"8879524924"
                                                       },
                                               @"theme": @{
                                                       @"color": @"#F37254"
                                                       }
                                               };
                     [self->razor open:options];
                 }
                 
             }
             
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}
- (void)onPaymentSuccess:(nonnull NSString*)payment_id {
//    [[[UIAlertView alloc] initWithTitle:@"Payment Successful" message:payment_id delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [Utils showErrorAlert:@"Payment Success" delegate:nil];
    self->appDelegate.bookingstatusStr=@"24";
    [self updatelocation];
    //SuccessViewController * success=[[SuccessViewController alloc]init];
    //[self.navigationController pushViewController:success animated:YES];
}

- (void)onPaymentError:(int)code description:(nonnull NSString *)str {
//    [[[UIAlertView alloc] initWithTitle:@"Error" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    NSString * failureStr=[NSString stringWithFormat:@"Payment Failure \n %@",str];
    [Utils showErrorAlert:failureStr delegate:nil];
}

- (void)getbooking
{
    NSString *url =[UrlGenerator PostBooking];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":self->appDelegate.bookingidStr
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         }
         else
         {
             NSLog(@"1");
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"] intValue]==17)
             {
                 [self payment];
             }
             else if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"]intValue]==25) {
                 [self->bookingtimer invalidate];
                 self->bookingtimer=nil;
                 [Utils showErrorAlert:@"Thank You" delegate:self];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    if ([string isEqualToString:@"Ok"])
    {
        constraintViewController * home=[[constraintViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    }
}

-(void)submitAction
{
    if(paytypeselected)
    {
        [self updatelocation];
    }
    else
    {
        [Utils showErrorAlert:@"Select Payment Type" delegate:nil];
    }
    
}

- (void)createDesign
{
    
    UIScrollView * scroll=[[UIScrollView alloc]init];
    [self.view addSubview:scroll];
    scroll.translatesAutoresizingMaskIntoConstraints = NO;
    [scroll.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?90:70].active=YES;
    [scroll.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
    [scroll.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [scroll.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
    //scroll.backgroundColor=Singlecolor(redColor);
    
    
    UIView * MainView=[[UIView alloc]init];
    [scroll addSubview:MainView];
    MainView.translatesAutoresizingMaskIntoConstraints = NO;
    [MainView.topAnchor constraintEqualToAnchor:scroll.topAnchor constant:20].active=YES;
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
    
    
    
    UILabel * dateLbl=[[UILabel alloc]init];
    [MainView addSubview:dateLbl];
    dateLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [dateLbl.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:5].active=YES;
    [dateLbl.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:10].active=YES;
    [dateLbl.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/4.5].active=YES;
    [dateLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    //dateLbl.backgroundColor=Singlecolor(redColor);
    dateLbl.text=@"Wed, 12.12.2018";
    dateLbl.font=RalewayRegular(appDelegate.font-7);
    dateLbl.textColor=Singlecolor(grayColor);
    
    
    UIImageView * headerImg=[[UIImageView alloc]init];
    [MainView addSubview:headerImg];
    headerImg.translatesAutoresizingMaskIntoConstraints = NO;
    [headerImg.topAnchor constraintEqualToAnchor:dateLbl.topAnchor constant:0].active=YES;
    [headerImg.leftAnchor constraintEqualToAnchor:dateLbl.rightAnchor constant:5].active=YES;
    [headerImg.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2.5].active=YES;
    [headerImg.heightAnchor constraintEqualToAnchor:dateLbl.heightAnchor constant:5].active=YES;
    headerImg.image=image(@"service_header");
    
    
    UILabel * serviceLbl=[[UILabel alloc]init];
    [headerImg addSubview:serviceLbl];
    serviceLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [serviceLbl.topAnchor constraintEqualToAnchor:headerImg.topAnchor constant:0].active=YES;
    [serviceLbl.leftAnchor constraintEqualToAnchor:headerImg.leftAnchor constant:0].active=YES;
    [serviceLbl.widthAnchor constraintEqualToAnchor:headerImg.widthAnchor constant:0].active=YES;
    [serviceLbl.heightAnchor constraintEqualToAnchor:headerImg.heightAnchor constant:0].active=YES;
    serviceLbl.text=@"General Service";
    serviceLbl.textColor=Singlecolor(whiteColor);
    serviceLbl.textAlignment=NSTextAlignmentCenter;
    serviceLbl.font=RalewayRegular(appDelegate.font-6);
    
    UILabel * orderidLbl=[[UILabel alloc]init];
    [MainView addSubview:orderidLbl];
    orderidLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [orderidLbl.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:10].active=YES;
    [orderidLbl.leftAnchor constraintEqualToAnchor:headerImg.rightAnchor constant:7].active=YES;
    [orderidLbl.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-20].active=YES;
    //[orderidLbl.heightAnchor constraintEqualToConstant:40].active=YES;
    orderidLbl.backgroundColor=Singlecolor(clearColor);
    orderidLbl.text=@"Last Updated : 12pm";
    orderidLbl.font=RalewayRegular(appDelegate.font-7);
    orderidLbl.textColor=Singlecolor(grayColor);
    orderidLbl.textAlignment=NSTextAlignmentRight;
    orderidLbl.numberOfLines=2;
    
    
    UIView * imgdiv=[[UIView alloc]init];
    [MainView addSubview:imgdiv];
    imgdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [imgdiv.topAnchor constraintEqualToAnchor:dateLbl.bottomAnchor constant:20].active=YES;
    [imgdiv.leftAnchor constraintEqualToAnchor:dateLbl.rightAnchor constant:5].active=YES;
    [imgdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [imgdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-20].active=YES;
    imgdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    UIView * orderdiv=[[UIView alloc]init];
    [MainView addSubview:orderdiv];
    orderdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [orderdiv.topAnchor constraintEqualToAnchor:dateLbl.bottomAnchor constant:20].active=YES;
    [orderdiv.leftAnchor constraintEqualToAnchor:orderidLbl.leftAnchor constant:5].active=YES;
    [orderdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [orderdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-20].active=YES;
    orderdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    UIView * namedivView=[[UIView alloc]init];
    [MainView addSubview:namedivView];
    namedivView.translatesAutoresizingMaskIntoConstraints = NO;
    [namedivView.centerYAnchor constraintEqualToAnchor:MainView.centerYAnchor constant:20].active=YES;
    [namedivView.leftAnchor constraintEqualToAnchor:imgdiv.rightAnchor constant:5].active=YES;
    [namedivView.rightAnchor constraintEqualToAnchor:orderdiv.leftAnchor constant:-5].active=YES;
    [namedivView.heightAnchor constraintEqualToConstant:1].active=YES;
    namedivView.backgroundColor=RGB(169, 197, 184);
    
    
    UILabel * noLbl=[[UILabel alloc]init];
    [MainView addSubview:noLbl];
    noLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [noLbl.topAnchor constraintEqualToAnchor:headerImg.bottomAnchor constant:5].active=YES;
    [noLbl.leftAnchor constraintEqualToAnchor:namedivView.leftAnchor constant:0].active=YES;
    [noLbl.rightAnchor constraintEqualToAnchor:namedivView.rightAnchor constant:0].active=YES;
    [noLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    noLbl.text=@"TN 22 1458";
    noLbl.textAlignment=NSTextAlignmentCenter;
    noLbl.font=RalewayRegular(appDelegate.font-4);
    
    
    UILabel * typeLbl=[[UILabel alloc]init];
    [MainView addSubview:typeLbl];
    typeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typeLbl.topAnchor constraintEqualToAnchor:noLbl.bottomAnchor constant:0].active=YES;
    [typeLbl.leftAnchor constraintEqualToAnchor:namedivView.leftAnchor constant:0].active=YES;
    [typeLbl.rightAnchor constraintEqualToAnchor:namedivView.rightAnchor constant:0].active=YES;
    [typeLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    typeLbl.text=@"Maruthi Alto";
    typeLbl.textAlignment=NSTextAlignmentCenter;
    typeLbl.textColor=Singlecolor(grayColor);
    typeLbl.font=RalewayRegular(appDelegate.font-5);
    
    
    UILabel * servicecenterLbl=[[UILabel alloc]init];
    [MainView addSubview:servicecenterLbl];
    servicecenterLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [servicecenterLbl.topAnchor constraintEqualToAnchor:namedivView.bottomAnchor constant:0].active=YES;
    [servicecenterLbl.leftAnchor constraintEqualToAnchor:namedivView.leftAnchor constant:0].active=YES;
    [servicecenterLbl.rightAnchor constraintEqualToAnchor:namedivView.rightAnchor constant:0].active=YES;
    [servicecenterLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    servicecenterLbl.text=@"Rasi Motors, Tambaram";
    servicecenterLbl.textAlignment=NSTextAlignmentCenter;
    servicecenterLbl.textColor=Singlecolor(grayColor);
    servicecenterLbl.font=RalewayRegular(appDelegate.font-5);
    
    
    UIImageView * carImg=[[UIImageView alloc]init];
    [MainView addSubview:carImg];
    carImg.translatesAutoresizingMaskIntoConstraints = NO;
    [carImg.centerYAnchor constraintEqualToAnchor:MainView.centerYAnchor constant:5].active=YES;
    [carImg.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:20].active=YES;
    [carImg.widthAnchor constraintEqualToConstant:60].active=YES;
    [carImg.heightAnchor constraintEqualToConstant:30].active=YES;
    carImg.image=image(@"order_car");
    
    UILabel * servicetypeLbl=[[UILabel alloc]init];
    [MainView addSubview:servicetypeLbl];
    servicetypeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [servicetypeLbl.topAnchor constraintEqualToAnchor:carImg.topAnchor constant:0].active=YES;
    [servicetypeLbl.leftAnchor constraintEqualToAnchor:orderdiv.leftAnchor constant:5].active=YES;
    [servicetypeLbl.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-5].active=YES;
    [servicetypeLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    servicetypeLbl.text=@"Service Type";
    servicetypeLbl.textColor=Singlecolor(blackColor);
    servicetypeLbl.font=RalewayRegular(appDelegate.font-5);
    servicetypeLbl.textAlignment=NSTextAlignmentCenter;
    
    UILabel * servicetype=[[UILabel alloc]init];
    [MainView addSubview:servicetype];
    servicetype.translatesAutoresizingMaskIntoConstraints = NO;
    [servicetype.topAnchor constraintEqualToAnchor:servicetypeLbl.bottomAnchor constant:-5].active=YES;
    [servicetype.leftAnchor constraintEqualToAnchor:orderdiv.leftAnchor constant:5].active=YES;
    [servicetype.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-5].active=YES;
    [servicetype.heightAnchor constraintEqualToConstant:21].active=YES;
    servicetype.text=@"Punture";
    servicetype.textColor=Singlecolor(blackColor);
    servicetype.font=RalewayRegular(appDelegate.font-7);
    servicetype.textAlignment=NSTextAlignmentCenter;
    
    UIImageView * serviceImg=[[UIImageView alloc]init];
    [MainView addSubview:serviceImg];
    serviceImg.translatesAutoresizingMaskIntoConstraints = NO;
    [serviceImg.topAnchor constraintEqualToAnchor:servicetype.bottomAnchor constant:0].active=YES;
    [serviceImg.centerXAnchor constraintEqualToAnchor:servicetype.centerXAnchor constant:0].active=YES;
    [serviceImg.widthAnchor constraintEqualToConstant:18].active=YES;
    [serviceImg.heightAnchor constraintEqualToConstant:18].active=YES;
    serviceImg.image=image(@"1");
    
    UILabel * orderrecLbl=[[UILabel alloc]init];
    [scroll addSubview:orderrecLbl];
    orderrecLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [orderrecLbl.topAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:20].active=YES;
    //[orderrecLbl.leftAnchor constraintEqualToAnchor:scroll.leftAnchor constant:0].active=YES;
    [orderrecLbl.widthAnchor constraintEqualToAnchor:scroll.widthAnchor constant:0].active=YES;
    [orderrecLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    orderrecLbl.text=@"Order Receipt";
    orderrecLbl.textAlignment=NSTextAlignmentCenter;
    orderrecLbl.textColor=Singlecolor(blackColor);
    orderrecLbl.font=RalewayRegular(appDelegate.font-2);
    //orderrecLbl.backgroundColor=Singlecolor(redColor);
    
    
    UIView * particularView=[[UIView alloc]init];
    [scroll addSubview:particularView];
    particularView.translatesAutoresizingMaskIntoConstraints = NO;
    [particularView.topAnchor constraintEqualToAnchor:orderrecLbl.bottomAnchor constant:10].active=YES;
    [particularView.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:10].active=YES;
    [particularView.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-10].active=YES;
    [particularView.heightAnchor constraintEqualToConstant:21].active=YES;
    particularView.backgroundColor=Singlecolor(lightGrayColor);
    
    
    
    UILabel * particularLbl=[[UILabel alloc]init];
    [particularView addSubview:particularLbl];
    particularLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [particularLbl.topAnchor constraintEqualToAnchor:particularView.topAnchor constant:0].active=YES;
    [particularLbl.leftAnchor constraintEqualToAnchor:particularView.leftAnchor constant:10].active=YES;
    [particularLbl.widthAnchor constraintEqualToAnchor:particularView.widthAnchor multiplier:0.4].active=YES;
    [particularLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    particularLbl.text=@"Particulars";
    particularLbl.backgroundColor=Singlecolor(clearColor);
    particularLbl.textAlignment=NSTextAlignmentLeft;
    particularLbl.textColor=Singlecolor(blackColor);
    particularLbl.font=RalewayRegular(appDelegate.font-4);
    
    UILabel * amtLbl=[[UILabel alloc]init];
    [particularView addSubview:amtLbl];
    amtLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [amtLbl.topAnchor constraintEqualToAnchor:particularView.topAnchor constant:0].active=YES;
    //[amtLbl.leftAnchor constraintEqualToAnchor:particularLbl.rightAnchor constant:0].active=YES;
    [amtLbl.rightAnchor constraintEqualToAnchor:particularView.rightAnchor constant:-10].active=YES;
    [amtLbl.widthAnchor constraintEqualToAnchor:particularLbl.widthAnchor constant:0].active=YES;
    [amtLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    amtLbl.text=@"Amount";
    //amtLbl.backgroundColor=Singlecolor(lightGrayColor);
    amtLbl.textColor=Singlecolor(blackColor);
    amtLbl.textAlignment=NSTextAlignmentRight;
    amtLbl.font=RalewayRegular(appDelegate.font-4);
    
    
    
    UILabel * servicetypeinnerLbl=[[UILabel alloc]init];
    [scroll addSubview:servicetypeinnerLbl];
    servicetypeinnerLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [servicetypeinnerLbl.topAnchor constraintEqualToAnchor:particularLbl.bottomAnchor constant:10].active=YES;
    [servicetypeinnerLbl.leftAnchor constraintEqualToAnchor:particularLbl.leftAnchor constant:10].active=YES;
    [servicetypeinnerLbl.widthAnchor constraintEqualToAnchor:particularLbl.widthAnchor constant:-10].active=YES;
    [servicetypeinnerLbl.heightAnchor constraintEqualToAnchor:particularLbl.heightAnchor constant:0].active=YES;
    servicetypeinnerLbl.textColor=Singlecolor(blackColor);
    servicetypeinnerLbl.font=RalewayRegular(appDelegate.font-4);
    servicetypeinnerLbl.text=@"Service type";
    
    
    UILabel * puntureinnerLbl=[[UILabel alloc]init];
    [scroll addSubview:puntureinnerLbl];
    puntureinnerLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [puntureinnerLbl.topAnchor constraintEqualToAnchor:servicetypeinnerLbl.bottomAnchor constant:0].active=YES;
    [puntureinnerLbl.leftAnchor constraintEqualToAnchor:servicetypeinnerLbl.leftAnchor constant:0].active=YES;
    [puntureinnerLbl.widthAnchor constraintEqualToAnchor:servicetypeinnerLbl.widthAnchor constant:0].active=YES;
    [puntureinnerLbl.heightAnchor constraintEqualToAnchor:servicetypeinnerLbl.heightAnchor constant:0].active=YES;
    puntureinnerLbl.textColor=Singlecolor(blackColor);
    puntureinnerLbl.font=RalewayRegular(appDelegate.font-6);
    //puntureinnerLbl.textAlignment=NSTextAlignmentRight;
    puntureinnerLbl.text=@"Punture";
    
    
    UILabel * amtinnerLbl=[[UILabel alloc]init];
    [scroll addSubview:amtinnerLbl];
    amtinnerLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [amtinnerLbl.topAnchor constraintEqualToAnchor:servicetypeinnerLbl.topAnchor constant:0].active=YES;
    [amtinnerLbl.leftAnchor constraintEqualToAnchor:amtLbl.leftAnchor constant:10].active=YES;
    [amtinnerLbl.widthAnchor constraintEqualToAnchor:amtLbl.widthAnchor constant:-10].active=YES;
    [amtinnerLbl.heightAnchor constraintEqualToAnchor:amtLbl.heightAnchor constant:0].active=YES;
    amtinnerLbl.textColor=Singlecolor(blackColor);
    amtinnerLbl.font=RalewayRegular(appDelegate.font-4);
    amtinnerLbl.textAlignment=NSTextAlignmentRight;
    amtinnerLbl.text=@"100. Rs";
    
    
    UIView * typediv=[[UIView alloc]init];
    [scroll addSubview:typediv];
    typediv.translatesAutoresizingMaskIntoConstraints = NO;
    [typediv.topAnchor constraintEqualToAnchor:puntureinnerLbl.bottomAnchor constant:10].active=YES;
    [typediv.leftAnchor constraintEqualToAnchor:particularView.leftAnchor constant:0].active=YES;
    [typediv.widthAnchor constraintEqualToAnchor:particularView.widthAnchor constant:0].active=YES;
    [typediv.heightAnchor constraintEqualToConstant:1].active=YES;
    typediv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    
    UILabel * taxLbl=[[UILabel alloc]init];
    [scroll addSubview:taxLbl];
    taxLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [taxLbl.topAnchor constraintEqualToAnchor:typediv.bottomAnchor constant:0].active=YES;
    [taxLbl.leftAnchor constraintEqualToAnchor:puntureinnerLbl.leftAnchor constant:10].active=YES;
    [taxLbl.widthAnchor constraintEqualToAnchor:puntureinnerLbl.widthAnchor constant:-10].active=YES;
    [taxLbl.heightAnchor constraintEqualToAnchor:particularLbl.heightAnchor constant:0].active=YES;
    taxLbl.textColor=Singlecolor(blackColor);
    taxLbl.font=RalewayRegular(appDelegate.font-4);
    taxLbl.text=@"Tax";
    
    
    UILabel * taxamtLbl=[[UILabel alloc]init];
    [scroll addSubview:taxamtLbl];
    taxamtLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [taxamtLbl.topAnchor constraintEqualToAnchor:typediv.bottomAnchor constant:0].active=YES;
    [taxamtLbl.leftAnchor constraintEqualToAnchor:amtinnerLbl.leftAnchor constant:10].active=YES;
    [taxamtLbl.widthAnchor constraintEqualToAnchor:amtinnerLbl.widthAnchor constant:-10].active=YES;
    [taxamtLbl.heightAnchor constraintEqualToAnchor:amtinnerLbl.heightAnchor constant:0].active=YES;
    taxamtLbl.textColor=Singlecolor(blackColor);
    taxamtLbl.font=RalewayRegular(appDelegate.font-4);
    taxamtLbl.text=@"18. Rs";
    taxamtLbl.textAlignment=NSTextAlignmentRight;
    
    
    
    UIView * taxdiv=[[UIView alloc]init];
    [scroll addSubview:taxdiv];
    taxdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [taxdiv.topAnchor constraintEqualToAnchor:taxamtLbl.bottomAnchor constant:0].active=YES;
    [taxdiv.leftAnchor constraintEqualToAnchor:particularView.leftAnchor constant:0].active=YES;
    [taxdiv.widthAnchor constraintEqualToAnchor:particularView.widthAnchor constant:0].active=YES;
    [taxdiv.heightAnchor constraintEqualToConstant:1].active=YES;
    taxdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    
    UILabel * totalLbl=[[UILabel alloc]init];
    [scroll addSubview:totalLbl];
    totalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [totalLbl.topAnchor constraintEqualToAnchor:taxdiv.bottomAnchor constant:10].active=YES;
    [totalLbl.leftAnchor constraintEqualToAnchor:servicetypeinnerLbl.leftAnchor constant:0].active=YES;
    [totalLbl.widthAnchor constraintEqualToAnchor:servicetypeinnerLbl.widthAnchor constant:0].active=YES;
    [totalLbl.heightAnchor constraintEqualToAnchor:servicetypeinnerLbl.heightAnchor constant:0].active=YES;
    totalLbl.textColor=Singlecolor(blackColor);
    totalLbl.font=RalewayRegular(appDelegate.font-4);
    totalLbl.text=@"Total";
    
    
    UILabel * totalamtLbl=[[UILabel alloc]init];
    [scroll addSubview:totalamtLbl];
    totalamtLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [totalamtLbl.topAnchor constraintEqualToAnchor:taxdiv.topAnchor constant:10].active=YES;
    [totalamtLbl.leftAnchor constraintEqualToAnchor:amtinnerLbl.leftAnchor constant:0].active=YES;
    [totalamtLbl.widthAnchor constraintEqualToAnchor:amtinnerLbl.widthAnchor constant:0].active=YES;
    [totalamtLbl.heightAnchor constraintEqualToAnchor:amtinnerLbl.heightAnchor constant:0].active=YES;
    totalamtLbl.textColor=Singlecolor(blackColor);
    totalamtLbl.font=RalewayRegular(appDelegate.font-4);
    totalamtLbl.textAlignment=NSTextAlignmentRight;
    totalamtLbl.text=@"118. Rs";
    
    
    cashImg=[[UIImageView alloc]init];
    [scroll addSubview:cashImg];
    cashImg.translatesAutoresizingMaskIntoConstraints = NO;
    [cashImg.topAnchor constraintEqualToAnchor:totalamtLbl.bottomAnchor constant:60].active=YES;
    [cashImg.centerXAnchor constraintEqualToAnchor:scroll.centerXAnchor constant:-60].active=YES;
    [cashImg.widthAnchor constraintEqualToConstant:20].active=YES;
    [cashImg.heightAnchor constraintEqualToConstant:20].active=YES;
    cashImg.image=image(@"radiouncheck");
    
    
    UILabel * cashLbl=[[UILabel alloc]init];
    [scroll addSubview:cashLbl];
    cashLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [cashLbl.topAnchor constraintEqualToAnchor:totalamtLbl.bottomAnchor constant:60].active=YES;
    [cashLbl.leftAnchor constraintEqualToAnchor:cashImg.rightAnchor constant:10].active=YES;
    [cashLbl.widthAnchor constraintEqualToConstant:100].active=YES;
    [cashLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    cashLbl.text=@"Cash";
    cashLbl.font=RalewayRegular(appDelegate.font-4);
    
    
    UIButton * cashBtn=[[UIButton alloc]init];
    [scroll addSubview:cashBtn];
    cashBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cashBtn.topAnchor constraintEqualToAnchor:totalamtLbl.bottomAnchor constant:60].active=YES;
    [cashBtn.centerXAnchor constraintEqualToAnchor:scroll.centerXAnchor constant:-60].active=YES;
    [cashBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/3.5].active=YES;
    [cashBtn.heightAnchor constraintEqualToConstant:21].active=YES;
    cashBtn.tag=1;
    [cashBtn addTarget:self action:@selector(paytypeAction:) forControlEvents:UIControlEventTouchUpInside];
    //tubetyreBtn.backgroundColor=Singlecolor(grayColor);
    
    cardImg=[[UIImageView alloc]init];
    [scroll addSubview:cardImg];
    cardImg.translatesAutoresizingMaskIntoConstraints = NO;
    [cardImg.topAnchor constraintEqualToAnchor:cashImg.topAnchor constant:0].active=YES;
    [cardImg.leftAnchor constraintEqualToAnchor:cashBtn.rightAnchor constant:10].active=YES;
    [cardImg.widthAnchor constraintEqualToAnchor:cashImg.widthAnchor constant:0].active=YES;
    [cardImg.heightAnchor constraintEqualToAnchor:cashImg.heightAnchor constant:0].active=YES;
    cardImg.image=image(@"radiouncheck");
    
    
    UILabel * cardLbl=[[UILabel alloc]init];
    [scroll addSubview:cardLbl];
    cardLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [cardLbl.topAnchor constraintEqualToAnchor:cashLbl.topAnchor constant:0].active=YES;
    [cardLbl.leftAnchor constraintEqualToAnchor:cardImg.rightAnchor constant:10].active=YES;
    [cardLbl.widthAnchor constraintEqualToAnchor:cashLbl.widthAnchor constant:0].active=YES;
    [cardLbl.heightAnchor constraintEqualToAnchor:cashLbl.heightAnchor constant:0].active=YES;
    cardLbl.text=@"Online";
    cardLbl.font=RalewayRegular(appDelegate.font-4);
    
    
    UIButton *  cardBtn=[[UIButton alloc]init];
    [scroll addSubview:cardBtn];
    cardBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cardBtn.topAnchor constraintEqualToAnchor:cashBtn.topAnchor constant:0].active=YES;
    [cardBtn.leftAnchor constraintEqualToAnchor:cashBtn.rightAnchor constant:20].active=YES;
    [cardBtn.widthAnchor constraintEqualToAnchor:cashBtn.widthAnchor constant:0].active=YES;
    [cardBtn.heightAnchor constraintEqualToAnchor:cashBtn.heightAnchor constant:0].active=YES;
    cardBtn.tag=2;
    [cardBtn addTarget:self action:@selector(paytypeAction:) forControlEvents:UIControlEventTouchUpInside];
    //cardBtn.backgroundColor=Singlecolor(grayColor);
    
    UIButton *  submitBtn=[[UIButton alloc]init];
    [scroll addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.topAnchor constraintEqualToAnchor:cashBtn.bottomAnchor constant:40].active=YES;
    [submitBtn.centerXAnchor constraintEqualToAnchor:scroll.centerXAnchor constant:0].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:120].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:RGB(0, 87, 41)];
    [submitBtn setTitle:[NSString stringWithFormat:@"Make payment"] forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    //submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [scroll.bottomAnchor constraintEqualToAnchor:submitBtn.bottomAnchor constant:20].active=YES;
}
- (void)paytypeAction:(id)sender
{
    if ([sender tag]==2) {
        cardImg.image=image(@"radiocheck");
        cashImg.image=image(@"radiouncheck");
        cod=NO;
        self->appDelegate.bookingstatusStr=@"23";
    }
    else
    {
        cardImg.image=image(@"radiouncheck");
        cashImg.image=image(@"radiocheck");
        cod=YES;
        self->appDelegate.bookingstatusStr=@"25";
    }
    
    paytypeselected=YES;
}
@end
