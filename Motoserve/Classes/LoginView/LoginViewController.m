//
//  LoginViewController.m
//  Motoserve
//
//  Created by Shyam on 02/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface LoginViewController ()
{
    AppDelegate * appDelegate;
    UIView * contentView;
    UITextField *  userNameTxt,*  passwordTxt;
}
@end

@implementation LoginViewController

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
    
    userNameTxt = [[UITextField alloc]initWithFrame:CGRectMake(logoImg.frame.origin.x+10, CGRectGetMaxY(logoImg.frame)+50, logoImg.frame.size.width-20, 30)];
    userNameTxt.textColor=Singlecolor(whiteColor);
    userNameTxt.keyboardType=UIKeyboardTypeEmailAddress;
    UIColor *color = [UIColor whiteColor];
    userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email/Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    userNameTxt.font=RalewayRegular(appDelegate.font-4);
    [contentView addSubview:userNameTxt];
    
    UIView *  UserLine=[[UIView alloc]initWithFrame:CGRectMake(userNameTxt.x-10, userNameTxt.bottom, userNameTxt.width+20, 1)];
    UserLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:UserLine];
    [UserLine setAlpha:1];
    
    
    
    passwordTxt = [[UITextField alloc]init];
    passwordTxt.frame = CGRectMake(userNameTxt.x, userNameTxt.bottom+20,userNameTxt.width, userNameTxt.height);
    passwordTxt.secureTextEntry=YES;
    passwordTxt.textColor=Singlecolor(whiteColor);
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTxt.font=RalewayRegular(appDelegate.font-4);
    [contentView addSubview:passwordTxt];
    
    UIView *  PasswordLine=[[UIView alloc]initWithFrame:CGRectMake(passwordTxt.x-10, passwordTxt.bottom, passwordTxt.width+20, 1)];
    PasswordLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:PasswordLine];
    [PasswordLine setAlpha:1];
    
    
    UIButton * forgotBtn=[[UIButton alloc]initWithFrame:CGRectMake(UserLine.frame.origin.x, CGRectGetMaxY(PasswordLine.frame)+5, UserLine.frame.size.width, 21)];
    [forgotBtn setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [forgotBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    forgotBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgotBtn addTarget:self action:@selector(forgotAction) forControlEvents:UIControlEventTouchUpInside];
    forgotBtn.titleLabel.font=RalewayLight(appDelegate.font-4);
    [contentView addSubview:forgotBtn];
    
    UIButton * signinBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(forgotBtn.frame)+20, 100, 30)];
    [signinBtn setBackgroundColor:Singlecolor(whiteColor)];
    [signinBtn setTitle:@"Sign In" forState:UIControlStateNormal];
    signinBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [signinBtn addTarget:self action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
    [signinBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [contentView addSubview:signinBtn];
    
    
    UIButton * signupBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(signinBtn.frame)+60, SCREEN_WIDTH, 30)];
    [signupBtn setTitle:@"New User? Sign up" forState:UIControlStateNormal];
    [signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    [signupBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    signupBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    signupBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [contentView addSubview:signupBtn];
    
}

- (void)forgotAction
{
    ForgotViewController * forgot=[[ForgotViewController alloc]init];
    [self.navigationController pushViewController:forgot animated:YES];
}
- (void)signupAction
{
    SignupViewController * signup=[[SignupViewController alloc]init];
    appDelegate.isedit=NO;
    [self.navigationController pushViewController:signup animated:YES];
}

- (void)signinAction
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostLogin];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * parameters = @{
                                      @"email":userNameTxt.text,@"password":passwordTxt.text
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
                 if ([[responseObject valueForKey:@"message"]isEqualToString:@"Mobile number not verified"]) {
                     self->appDelegate.islogin=YES;
                     OTPViewController * otp=[[OTPViewController alloc]init];
                     otp.otpidStr=[[responseObject valueForKey:@"data"]valueForKey:@"_id"];
                     [self.navigationController pushViewController:otp animated:YES];
                 }
                 else
                 {
                     constraintViewController * home=[[constraintViewController alloc]init];
                     [self.navigationController pushViewController:home animated:YES];
                      [Utils archieveRootObject:[responseObject valueForKey:@"data"] forkey:@"logindetails"];
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
    if ([userNameTxt.text length]==0|| [passwordTxt.text length]==0) {
        [Utils showErrorAlert:@"Please fill in all the fields" delegate:nil];
        return NO;
    }
    if ([userNameTxt.text length]!=10) {
        [Utils showErrorAlert:@"Please enter valid Mobile Number." delegate:nil];
        return NO;
    }
    if (!([userNameTxt.text length]==0|| [passwordTxt.text length]==0)) {
        return YES;
    }
    return YES;
}
@end
//12.957221
//80.1478917
