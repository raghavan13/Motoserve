//
//  OTPViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 03/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "OTPViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface OTPViewController ()
{
    AppDelegate * appDelegate;
    UIView * contentView;
    UITextField *  otpTxt;
}
@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDesign];
}

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =RGB(241, 243, 245);
    //     contentView.image=image(@"login_bg");
    contentView.userInteractionEnabled=YES;
    self.view = contentView;
}
- (void)createDesign
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView * bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImg.image=image(@"bgimage");
    [contentView addSubview:bgImg];

    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-100,100, 200, 123)];
    logoImg.image=image(@"logo");
    [contentView addSubview:logoImg];
    
    otpTxt = [[UITextField alloc]initWithFrame:CGRectMake(logoImg.frame.origin.x, CGRectGetMaxY(logoImg.frame)+50, logoImg.frame.size.width, 30)];
    otpTxt.textColor=Singlecolor(whiteColor);
    otpTxt.keyboardType=UIKeyboardTypeEmailAddress;
    otpTxt.returnKeyType=UIReturnKeyNext;
    UIColor *color = [UIColor whiteColor];
    otpTxt.font=RalewayRegular(appDelegate.font-4);
    otpTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"OTP" attributes:@{NSForegroundColorAttributeName: color}];
    [contentView addSubview:otpTxt];
    
    UIView *  OtpLine=[[UIView alloc]initWithFrame:CGRectMake(otpTxt.x, otpTxt.bottom, otpTxt.width, 1)];
    OtpLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:OtpLine];
    [OtpLine setAlpha:1];
    
    UIButton * resendBtn=[[UIButton alloc]initWithFrame:CGRectMake(OtpLine.frame.origin.x, CGRectGetMaxY(OtpLine.frame)+5, OtpLine.frame.size.width, 21)];
    [resendBtn setTitle:@"Resend" forState:UIControlStateNormal];
    [resendBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    resendBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [resendBtn addTarget:self action:@selector(resendAction) forControlEvents:UIControlEventTouchUpInside];
    resendBtn.titleLabel.font=RalewayLight(appDelegate.font-4);
    [contentView addSubview:resendBtn];
    
    
    UIButton * submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(resendBtn.frame)+20, 100, 30)];
    [submitBtn setBackgroundColor:Singlecolor(whiteColor)];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn addTarget:self action:@selector(otpAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:submitBtn];
    

}
- (void)resendAction
{
    [appDelegate startProgressView:self.view];
    NSString *url =[UrlGenerator Postresendotp];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":self.otpidStr
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
         }
         else
         {
             NSLog(@"1");
             //LoginViewController * home=[[LoginViewController alloc]init];
             //[self.navigationController pushViewController:home animated:YES];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (void)otpAction
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostOtp];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * parameters = @{
                                      @"verificationCode":otpTxt.text,@"_id":self.otpidStr
                                      };
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"response data %@",responseObject);
             [self->appDelegate stopProgressView];
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             if ([[responseObject objectForKey:@"status"]integerValue]==0) {
                 NSLog(@"0");
             }
             else
             {
                 NSLog(@"1");
                 if (self->appDelegate.islogin) {
                    LoginViewController *   home=[[LoginViewController alloc]init];
                      [self.navigationController pushViewController:home animated:YES];
                 }
                 else
                 {
                     ResetpassViewController* home=[[ResetpassViewController alloc]init];
                     home.userid=self.otpidStr;
                      [self.navigationController pushViewController:home animated:YES];
                 }
                
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
             [self->appDelegate stopProgressView];
         }];
    }
}
- (BOOL)isValidEntry
{
    if ([otpTxt.text length]==0) {
        [Utils showErrorAlert:@"Please fill in all the fields" delegate:nil];
        return NO;
    }
    if (!([otpTxt.text length]==0)) {
        return YES;
    }
    return YES;
}
@end
