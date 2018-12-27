//
//  ForgotViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 22/11/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "ForgotViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
@interface ForgotViewController ()
{
    AppDelegate * appDelegate;
    UIView * contentView;
    UITextField *  userNameTxt,*  passwordTxt;
}
@end

@implementation ForgotViewController

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =RGB(241, 243, 245);
    contentView.userInteractionEnabled=YES;
    self.view = contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDesign];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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
    
    UILabel * resetLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImg.frame)+20, SCREEN_WIDTH, 21)];
    resetLbl.text=@"Reset Password";
    resetLbl.textAlignment=NSTextAlignmentCenter;
    resetLbl.textColor=Singlecolor(whiteColor);
    [contentView addSubview:resetLbl];
    
    userNameTxt = [[UITextField alloc]initWithFrame:CGRectMake(logoImg.frame.origin.x+10, CGRectGetMaxY(resetLbl.frame)+50, logoImg.frame.size.width-20, 30)];
    userNameTxt.textColor=Singlecolor(whiteColor);
    userNameTxt.keyboardType=UIKeyboardTypeNumberPad;
    UIColor *color = [UIColor whiteColor];
    userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    userNameTxt.font=RalewayRegular(appDelegate.font-4);
    [contentView addSubview:userNameTxt];
    
    UIView *  UserLine=[[UIView alloc]initWithFrame:CGRectMake(userNameTxt.x-10, userNameTxt.bottom, userNameTxt.width+20, 1)];
    UserLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:UserLine];
    [UserLine setAlpha:1];
    
    
    UIButton * signupBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(UserLine.frame)+40, 100, 30)];
    [signupBtn setBackgroundColor:Singlecolor(whiteColor)];
    [signupBtn setTitle:@"Recover" forState:UIControlStateNormal];
   [signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    signupBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [signupBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [contentView addSubview:signupBtn];
    
    
    UIButton * loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(logoImg.frame.origin.x+10, CGRectGetMaxY(signupBtn.frame)+40, logoImg.frame.size.width-20, 30)];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    loginBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    loginBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contentView addSubview:loginBtn];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)signupAction
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostForgotPass];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * parameters = @{
                                      @"email":userNameTxt.text
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
                 ResetpassViewController * home=[[ResetpassViewController alloc]init];
                 home.userid=[[responseObject valueForKey:@"data"]valueForKey:@"_id"];
                 [self.navigationController pushViewController:home animated:YES];
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
    if ([userNameTxt.text length]==0) {
        [Utils showErrorAlert:@"Please fill in all the fields" delegate:nil];
        return NO;
    }
    if (!([userNameTxt.text length]==0)) {
        return YES;
    }
    return YES;
}

@end
