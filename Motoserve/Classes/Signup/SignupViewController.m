//
//  SignupViewController.m
//  Motoserve
//
//  Created by Shyam on 02/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "SignupViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AWSCore.h>
#import <AWSS3TransferManager.h>

@interface SignupViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    AppDelegate * appDelegate;
    UIView * contentView;
    UITextField *  mobTxt,*userNameTxt,*emailTxt,*passTxt,*cppassTxt;
    UIButton * selectimgBtn;
    UIImageView * profImg;
    NSString * urlpath,*filePath;
    NSURL* fileUrl;
    UIImageView * termsImg;
    NSString * termsStr;
}
@end

@implementation SignupViewController

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =RGB(241, 243, 245);
    contentView.userInteractionEnabled=YES;
    self.view = contentView;
    termsStr=@"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
                                                                                                    identityPoolId:@"us-east-1:4d04a84f-44c4-4672-b4b8-bb0c95f2eecb"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
                                                                         credentialsProvider:credentialsProvider];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
    
    urlpath=@"";
    [self createDesign];
}

- (void)createDesign
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView * bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImg.image=image(@"bgimage");
    [contentView addSubview:bgImg];
    
    
    UIScrollView * signupScrl=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentView.frame.size.height)];
    [contentView addSubview:signupScrl];
    
    profImg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-37, 50, 75,75)];
    profImg.image=image(@"upload");
    profImg.layer.cornerRadius = profImg.frame.size.width / 2;
    profImg.clipsToBounds = YES;
    profImg.layer.borderWidth = 1.0f;
    profImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [signupScrl addSubview:profImg];
    
    
    selectimgBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-37, 50, 75,75)];
    //[selectimgBtn setBackgroundImage:image(@"upload") forState:UIControlStateNormal];
    [selectimgBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    [signupScrl addSubview:selectimgBtn];
    
    UILabel * uploadLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectimgBtn.frame)+5, SCREEN_WIDTH, 21)];
    uploadLbl.text=@"Upload Your Photo";
    uploadLbl.font=RalewayRegular(appDelegate.font-4);
    uploadLbl.textColor=Singlecolor(whiteColor);
    uploadLbl.textAlignment=NSTextAlignmentCenter;
    [signupScrl addSubview:uploadLbl];
    
    userNameTxt = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-110, CGRectGetMaxY(uploadLbl.frame)+20, 220, 30)];
    userNameTxt.textColor=Singlecolor(whiteColor);
    UIColor *color = [UIColor whiteColor];
    userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    userNameTxt.font=RalewayRegular(appDelegate.font-4);
    [signupScrl addSubview:userNameTxt];
    
    UIView *  UserLine=[[UIView alloc]initWithFrame:CGRectMake(userNameTxt.x-10, userNameTxt.bottom, userNameTxt.width+20, 1)];
    UserLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:UserLine];
    [UserLine setAlpha:1];
    
    
    
    emailTxt = [[UITextField alloc]init];
    emailTxt.frame = CGRectMake(userNameTxt.frame.origin.x, CGRectGetMaxY(UserLine.frame)+20, userNameTxt.frame.size.width, 30);
    emailTxt.textColor=Singlecolor(whiteColor);
     emailTxt.keyboardType=UIKeyboardTypeEmailAddress;
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    emailTxt.font=RalewayRegular(appDelegate.font-4);
    [signupScrl addSubview:emailTxt];
    
    UIView *  emailLine=[[UIView alloc]initWithFrame:CGRectMake(UserLine.frame.origin.x, emailTxt.bottom, UserLine.frame.size.width, 1)];
    emailLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:emailLine];
    [emailLine setAlpha:1];
    
    mobTxt = [[UITextField alloc]initWithFrame:CGRectMake(emailTxt.frame.origin.x, CGRectGetMaxY(emailLine.frame)+20, emailTxt.frame.size.width, 30)];
    mobTxt.textColor=Singlecolor(whiteColor);
    mobTxt.keyboardType=UIKeyboardTypeNumberPad;
    mobTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    mobTxt.font=RalewayRegular(appDelegate.font-4);
    [signupScrl addSubview:mobTxt];
    
    UIView *  mobLine=[[UIView alloc]initWithFrame:CGRectMake(UserLine.frame.origin.x, mobTxt.bottom, UserLine.frame.size.width, 1)];
    mobLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:mobLine];
    [mobLine setAlpha:1];
    
    
    passTxt = [[UITextField alloc]init];
    passTxt.frame = CGRectMake(mobTxt.frame.origin.x, CGRectGetMaxY(mobLine.frame)+20, mobTxt.frame.size.width, 30);
    passTxt.returnKeyType=UIReturnKeyDone;
    passTxt.secureTextEntry=YES;
    passTxt.textColor=Singlecolor(whiteColor);
    passTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    passTxt.font=RalewayRegular(appDelegate.font-4);
    [signupScrl addSubview:passTxt];
    
    UIView *  passLine=[[UIView alloc]initWithFrame:CGRectMake(UserLine.frame.origin.x, passTxt.bottom, UserLine.frame.size.width, 1)];
    passLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:passLine];
    [passLine setAlpha:1];
    
    cppassTxt = [[UITextField alloc]init];
    cppassTxt.frame = CGRectMake(passLine.frame.origin.x+10, CGRectGetMaxY(passLine.frame)+20, passLine.frame.size.width-20, 30);
    cppassTxt.returnKeyType=UIReturnKeyDone;
    cppassTxt.secureTextEntry=YES;
    cppassTxt.textColor=Singlecolor(whiteColor);
    cppassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    cppassTxt.font=RalewayRegular(appDelegate.font-4);
    [signupScrl addSubview:cppassTxt];
    
    UIView *  cppassLine=[[UIView alloc]initWithFrame:CGRectMake(UserLine.frame.origin.x, cppassTxt.bottom, UserLine.frame.size.width, 1)];
    cppassLine.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:cppassLine];
    [cppassLine setAlpha:1];
    
    
    termsImg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-75, CGRectGetMaxY(cppassLine.frame)+30, 20, 20)];
    termsImg.image=image(@"radiouncheck");
    [signupScrl addSubview:termsImg];
    
    UILabel * termsLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(termsImg.frame)+10, CGRectGetMaxY(cppassLine.frame)+30, 150, 21)];
    termsLbl.text=@"Terms & Conditions";
    termsLbl.textColor=Singlecolor(whiteColor);
    termsLbl.font=RalewayRegular(appDelegate.font-2);
    [signupScrl addSubview:termsLbl];
    
   UIButton *  termsBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-75,CGRectGetMaxY(cppassLine.frame)+30, 200, 21)];
    termsBtn.tag=2;
    [termsBtn addTarget:self action:@selector(termsAction:) forControlEvents:UIControlEventTouchUpInside];
    [signupScrl addSubview:termsBtn];
    
    
    UIButton * signupBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(termsBtn.frame)+40, 100, 30)];
    [signupBtn setBackgroundColor:Singlecolor(whiteColor)];
    [signupBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
    signupBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [signupBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [signupScrl addSubview:signupBtn];
    
    
    UIButton * loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(signupBtn.frame)+40, SCREEN_WIDTH, 30)];
    NSMutableAttributedString *temString=[[NSMutableAttributedString alloc]initWithString:@"Already have an Account ? Login"];
    [temString addAttribute:NSUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:1]
                      range:(NSRange){26,5}];
    
    loginBtn.titleLabel.attributedText = temString;
    [loginBtn setTitle:@"Already have an Account ? Login" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    loginBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    loginBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [signupScrl addSubview:loginBtn];
    
    signupScrl.contentSize=CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(loginBtn.frame)+20);
    
}

- (void)termsAction:(id)sender
{
    if ([sender isSelected]) {
        [sender setSelected:NO];
        termsImg.image=image(@"radiouncheck");
        termsStr=@"0";
    }
    else
    {
        [sender setSelected:YES];
        termsImg.image=image(@"radiocheck");
        termsStr=@"1";
    }
}
- (void)signupAction
{
//    if ([mobTxt.text length]!=10) {
//        [Utils showErrorAlert:@"Please enter valid Mobile Number." delegate:nil];
//    }
//    else
//    {
//        NSString * errStr=[NSString stringWithFormat:@"You will receive OTP to this number %@",mobTxt.text];
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:errStr delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//        [alert show];
//    }
     [self Apicall];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    
        if ([string isEqualToString:@"Ok"])
        {
            [self Apicall];
        }
}

- (void)Apicall
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostSignup];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       NSString *  pathStr=[NSString stringWithFormat:@"https://s3.amazonaws.com/motoserve/MotoServe/User/%@",urlpath];
        NSDictionary * parameters = @{
                                      @"userName":userNameTxt.text,@"password":passTxt.text,@"mobile":mobTxt.text,@"latitude":@"",@"longitude":@"",@"isTerms":termsStr,@"email":emailTxt.text,@"currentLocation":@"",@"confirmPassword":cppassTxt.text,@"imageUrl":pathStr,@"imageLocalUrl":filePath
                                      };
        NSMutableDictionary * parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:parameters forKey:@"data"];
        [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
                 AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
                 uploadRequest.body = self->fileUrl;
                 uploadRequest.bucket = @"motoserve/MotoServe/User";
                 uploadRequest.key = self->urlpath;
                 //uploadRequest.contentType = @"image/png";
                 uploadRequest.ACL = AWSS3BucketCannedACLPublicRead;
                 
                 AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
                 
                 [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                    withBlock:^id(AWSTask *task) {
                                                                        if (task.error != nil) {
                                                                            NSLog(@"%s %@","Error uploading :", uploadRequest.key);
                                                                        }else { NSLog(@"Upload completed"); }
                                                                        [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
                                                                        [self->appDelegate stopProgressView];
                                                                        OTPViewController * home=[[OTPViewController alloc]init];
                                                                        home.otpidStr=[[responseObject valueForKey:@"data"]valueForKey:@"_id"];
                                                                        [self.navigationController pushViewController:home animated:YES];
                                                                        return nil;
                                                                    }];
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
    if ([userNameTxt.text length]==0|| [emailTxt.text length]==0 || [mobTxt.text length]==0 || [passTxt.text length]==0 || [cppassTxt.text length]==0) {
        [Utils showErrorAlert:@"Please fill in all the fields" delegate:nil];
        return NO;
    }
    if ([mobTxt.text length]!=10) {
        [Utils showErrorAlert:@"Please enter valid Mobile Number." delegate:nil];
        return NO;
    }
    if (![Utils validateEmailWithString:emailTxt.text]) {
        [Utils showErrorAlert:@"Please enter valid Email." delegate:nil];
        return NO;
    }
    if (![passTxt.text isEqualToString:cppassTxt.text]) {
        [Utils showErrorAlert:@"Password and confirm password not match" delegate:nil];
        return NO;
    }
    if ([urlpath isEqualToString:@""]) {
        [Utils showErrorAlert:@"Please select image" delegate:nil];
        return NO;
    }
    if ([termsStr isEqualToString:@""]) {
        [Utils showErrorAlert:@"Please select terms & conditions" delegate:nil];
        return NO;
    }
    if (!([userNameTxt.text length]==0|| [emailTxt.text length]==0 || [mobTxt.text length]==0 || [passTxt.text length]==0 || [cppassTxt.text length]==0)) {
        return YES;
    }
    return YES;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    profImg.image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSDate * date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hhmm"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
     urlpath=[NSString stringWithFormat:@"img_%@.png",stringFromDate];
    
    //convert uiimage to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",urlpath]];
    [UIImagePNGRepresentation(profImg.image) writeToFile:filePath atomically:YES];
    
    
    fileUrl = [NSURL fileURLWithPath:filePath];
}
- (void)uploadAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Gallery",  nil];
    actionSheet.delegate = self;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

#pragma mark - Action sheet delegates

- (void)actionSheet:(UIActionSheet *)popup didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex)
    {
        case 0:
            [self takePicture];
            break;
        case 1:
            [self cameraRoll];
            break;
            
        default:
            break;
    }
}
- (void) takePicture
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"",@"")  message:NSLocalizedString(@"Sorry you dont have camera",@"")  delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"")  otherButtonTitles:nil];
        [altView show];
        return;
    }
    else
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
- (void) cameraRoll
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker =
    [[UIImagePickerController alloc] init];
    //NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    //picker.mediaTypes = mediaTypes;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:NO completion:nil];
    
}
@end
