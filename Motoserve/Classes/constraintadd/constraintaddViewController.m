//
//  constraintaddViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 03/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "constraintaddViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
#import <AWSCore.h>
#import <AWSS3TransferManager.h>
@interface constraintaddViewController ()<SSPopupDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIView *navHeader;
    AppDelegate * appDelegate;
    UIButton *  twowheelBtn,* fourwheelBtn,* tubetyreBtn,* tubelessBtn,*petrolBtn,* dieselBtn,* submitBtn,* brandBtn,* modelBtn,* imgBtn,*lpgBtn;
    NSInteger selectedtag;
    NSLayoutAnchor * submittopAnch;
    BOOL iscar;
    UIScrollView * addvechScroll;
    UIView * carView;
    UIImageView * bikeradioImg,* bikeavatharImg,* carradioImg,* caravatharImg,* tubeImg,* tubelessImg,* petrolImg,* dieselImg,* yesImg,* noImg,* no1Img,* yes1Img,* camImg,*lpgImg;
    NSMutableArray * vechicleArray,*vechiclesubArray;
    NSDictionary *json;
    SSPopup* selection;
    NSDictionary * vechiclemodeldic;
    UITextField * vechilenoTxtfld;
    NSString * brandStr,*modelStr,*tyreStr,*engineStr,*jockeyStr,*typeStr,*secondaryStr;
    NSString * urlpath,*filePath;
    NSURL* fileUrl;
    UIView * senderView ;
    UILabel * tyreLbl,* tubeLbl,* carLbl,* bikeLbl;
}
@end

@implementation constraintaddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =RGB(222, 230, 239);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Add Vehicle" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    vechicleArray=[[NSMutableArray alloc]init];
    vechiclesubArray=[[NSMutableArray alloc]init];
    // Retrieve local JSON file called example.json
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    // Load the file into an NSData object called JSONData
    
    NSError *error = nil;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    NSLog(@"bike %@",[json valueForKey:@"bikeBrands"]);
    vechicleArray = [[json valueForKey:@"bikeBrands"]valueForKey:@"name"];
    //vechicleidArray=[[json valueForKey:@"bikeBrands"]valueForKey:@"id"];
    [self createDesign];
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
                                                                                                    identityPoolId:@"us-east-1:4d04a84f-44c4-4672-b4b8-bb0c95f2eecb"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
                                                                         credentialsProvider:credentialsProvider];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
    urlpath=@"";
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createDesign
{
    jockeyStr=@"";
    engineStr=@"";
    secondaryStr=@"";
    tyreStr=@"";
    
    addvechScroll=[[UIScrollView alloc]init];
    [self.view addSubview:addvechScroll];
    addvechScroll.translatesAutoresizingMaskIntoConstraints = NO;
    [addvechScroll.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?90:70].active=YES;
    [addvechScroll.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
    [addvechScroll.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [addvechScroll.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
    addvechScroll.showsHorizontalScrollIndicator=NO;
    addvechScroll.showsVerticalScrollIndicator=NO;
    //addvechScroll.backgroundColor=Singlecolor(redColor);
    
    
    twowheelBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:twowheelBtn];
     twowheelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [twowheelBtn.topAnchor constraintEqualToAnchor:addvechScroll.topAnchor constant:30].active=YES;
    [twowheelBtn.leftAnchor constraintEqualToAnchor:addvechScroll.leftAnchor constant:80].active=YES;
    [twowheelBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/4].active=YES;
    [twowheelBtn.heightAnchor constraintEqualToConstant:SCREEN_WIDTH/4].active=YES;
    twowheelBtn.tag=1;
    [twowheelBtn addTarget:self action:@selector(vechicleAction:) forControlEvents:UIControlEventTouchUpInside];
    [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
    typeStr=@"T";
    
    
    bikeLbl=[[UILabel alloc]init];
    [addvechScroll addSubview:bikeLbl];
    bikeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [bikeLbl.topAnchor constraintEqualToAnchor:twowheelBtn.bottomAnchor constant:0].active=YES;
    [bikeLbl.leftAnchor constraintEqualToAnchor:twowheelBtn.leftAnchor constant:0].active=YES;
    [bikeLbl.widthAnchor constraintEqualToAnchor:twowheelBtn.widthAnchor constant:0].active=YES;
    [bikeLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    bikeLbl.text=@"Bike";
    bikeLbl.textColor=RGB(0, 90, 45);
    bikeLbl.textAlignment=NSTextAlignmentCenter;
    bikeLbl.font=RalewayRegular(appDelegate.font-2);
    
    
    
    fourwheelBtn=[[UIButton alloc]init];
    fourwheelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [addvechScroll addSubview:fourwheelBtn];
    [fourwheelBtn.topAnchor constraintEqualToAnchor:addvechScroll.topAnchor constant:30].active=YES;
    [fourwheelBtn.leftAnchor constraintEqualToAnchor:twowheelBtn.rightAnchor constant:30].active=YES;
    [fourwheelBtn.widthAnchor constraintEqualToAnchor:twowheelBtn.widthAnchor constant:0].active=YES;
    [fourwheelBtn.heightAnchor constraintEqualToAnchor:twowheelBtn.heightAnchor constant:0].active=YES;
    fourwheelBtn.tag=2;
    [fourwheelBtn addTarget:self action:@selector(vechicleAction:) forControlEvents:UIControlEventTouchUpInside];
    [fourwheelBtn setBackgroundImage:image(@"car_unselect") forState:UIControlStateNormal];
    
    
    carLbl=[[UILabel alloc]init];
    [addvechScroll addSubview:carLbl];
    carLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [carLbl.topAnchor constraintEqualToAnchor:fourwheelBtn.bottomAnchor constant:0].active=YES;
    [carLbl.leftAnchor constraintEqualToAnchor:fourwheelBtn.leftAnchor constant:0].active=YES;
    [carLbl.widthAnchor constraintEqualToAnchor:fourwheelBtn.widthAnchor constant:0].active=YES;
    [carLbl.heightAnchor constraintEqualToAnchor:bikeLbl.heightAnchor constant:0].active=YES;
    carLbl.text=@"Car";
    carLbl.textColor=Singlecolor(lightGrayColor);
    carLbl.textAlignment=NSTextAlignmentCenter;
    carLbl.font=RalewayRegular(appDelegate.font-2);
    
    
    vechilenoTxtfld=[[UITextField alloc]init];
    [addvechScroll addSubview:vechilenoTxtfld];
    vechilenoTxtfld.translatesAutoresizingMaskIntoConstraints = NO;
    [vechilenoTxtfld.topAnchor constraintEqualToAnchor:carLbl.bottomAnchor constant:40].active=YES;
    [vechilenoTxtfld.leftAnchor constraintEqualToAnchor:addvechScroll.rightAnchor constant:60].active=YES;
    [vechilenoTxtfld.widthAnchor constraintEqualToAnchor:addvechScroll.widthAnchor constant:-120].active=YES;
    [vechilenoTxtfld.heightAnchor constraintEqualToConstant:40].active=YES;
    vechilenoTxtfld.backgroundColor=RGB(217, 217, 217);
    vechilenoTxtfld.textAlignment=NSTextAlignmentCenter;
    vechilenoTxtfld.placeholder=@"Enter Vehicle Number";
    [vechilenoTxtfld  setValue:Singlecolor(blackColor)
                    forKeyPath:@"_placeholderLabel.textColor"];
    vechilenoTxtfld.font=RalewayRegular(appDelegate.font-2);
    vechilenoTxtfld.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    vechilenoTxtfld.textColor=Singlecolor(blackColor);
    
    
    
    brandBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:brandBtn];
    brandBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [brandBtn.topAnchor constraintEqualToAnchor:vechilenoTxtfld.bottomAnchor constant:10].active=YES;
    [brandBtn.leftAnchor constraintEqualToAnchor:vechilenoTxtfld.leftAnchor constant:0].active=YES;
    [brandBtn.widthAnchor constraintEqualToAnchor:vechilenoTxtfld.widthAnchor constant:0].active=YES;
    [brandBtn.heightAnchor constraintEqualToAnchor:vechilenoTxtfld.heightAnchor constant:0].active=YES;
    brandBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [brandBtn setTitle:@"Brand" forState:UIControlStateNormal];
    [brandBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [brandBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,20,0,0)];
    //[brandBtn setImageEdgeInsets:UIEdgeInsetsMake(0,brandBtn.frame.size.width-20,0,0)];
    //[brandBtn setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
    brandBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    brandBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    brandBtn.layer.borderWidth = 0.5;
    brandBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    brandBtn.layer.cornerRadius = 5;
    brandBtn.layer.masksToBounds = true;
    [brandBtn addTarget:self action:@selector(brandAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * dropbrandImg=[[UIImageView alloc]init];
    [brandBtn addSubview:dropbrandImg];
    dropbrandImg.translatesAutoresizingMaskIntoConstraints = NO;
    [dropbrandImg.centerYAnchor constraintEqualToAnchor:brandBtn.centerYAnchor constant:0].active=YES;
    [dropbrandImg.rightAnchor constraintEqualToAnchor:brandBtn.rightAnchor constant:-20].active=YES;
    [dropbrandImg.widthAnchor constraintEqualToConstant:19].active=YES;
    [dropbrandImg.heightAnchor constraintEqualToConstant:10].active=YES;
    dropbrandImg.image=image(@"dropdown");
    
    
    
    modelBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:modelBtn];
    modelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [modelBtn.topAnchor constraintEqualToAnchor:brandBtn.bottomAnchor constant:10].active=YES;
    [modelBtn.leftAnchor constraintEqualToAnchor:vechilenoTxtfld.leftAnchor constant:0].active=YES;
    [modelBtn.widthAnchor constraintEqualToAnchor:vechilenoTxtfld.widthAnchor constant:0].active=YES;
    [modelBtn.heightAnchor constraintEqualToAnchor:vechilenoTxtfld.heightAnchor constant:0].active=YES;
    modelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [modelBtn setTitle:@"Model" forState:UIControlStateNormal];
    [modelBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [modelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,20,0,0)];
    //[modelBtn setImageEdgeInsets:UIEdgeInsetsMake(0,modelBtn.frame.size.width-20,0,0)];
    //[modelBtn setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
    modelBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    modelBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    modelBtn.layer.cornerRadius = 5;
    modelBtn.layer.masksToBounds = true;
    modelBtn.layer.borderWidth = 0.5;
    modelBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [modelBtn addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * dropmodelImg=[[UIImageView alloc]init];
    [modelBtn addSubview:dropmodelImg];
    dropmodelImg.translatesAutoresizingMaskIntoConstraints = NO;
    [dropmodelImg.centerYAnchor constraintEqualToAnchor:modelBtn.centerYAnchor constant:0].active=YES;
    [dropmodelImg.rightAnchor constraintEqualToAnchor:modelBtn.rightAnchor constant:-20].active=YES;
    [dropmodelImg.widthAnchor constraintEqualToConstant:19].active=YES;
    [dropmodelImg.heightAnchor constraintEqualToConstant:10].active=YES;
    dropmodelImg.image=image(@"dropdown");
    
    tyreLbl=[[UILabel alloc]init];
    [addvechScroll addSubview:tyreLbl];
    tyreLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tyreLbl.topAnchor constraintEqualToAnchor:modelBtn.bottomAnchor constant:10].active=YES;
    [tyreLbl.leftAnchor constraintEqualToAnchor:vechilenoTxtfld.leftAnchor constant:0].active=YES;
    [tyreLbl.widthAnchor constraintEqualToAnchor:vechilenoTxtfld.widthAnchor constant:0].active=YES;
    [tyreLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    tyreLbl.text=@"Tyre Type";
    tyreLbl.textColor=RGB(17, 90, 42);
    tyreLbl.textAlignment=NSTextAlignmentLeft;
    tyreLbl.font=RalewayRegular(appDelegate.font-2);
    
    
    tubeImg=[[UIImageView alloc]init];
    [addvechScroll addSubview:tubeImg];
    tubeImg.translatesAutoresizingMaskIntoConstraints = NO;
    [tubeImg.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubeImg.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:20].active=YES;
    [tubeImg.widthAnchor constraintEqualToConstant:20].active=YES;
    [tubeImg.heightAnchor constraintEqualToConstant:20].active=YES;
    tubeImg.image=image(@"radiouncheck");
    
    
    tubeLbl=[[UILabel alloc]init];
    [addvechScroll addSubview:tubeLbl];
    tubeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tubeLbl.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubeLbl.leftAnchor constraintEqualToAnchor:tubeImg.rightAnchor constant:10].active=YES;
    [tubeLbl.widthAnchor constraintEqualToConstant:100].active=YES;
    [tubeLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    tubeLbl.text=@"Tube";
    tubeLbl.font=RalewayRegular(appDelegate.font-2);
    
    
    tubetyreBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:tubetyreBtn];
    tubetyreBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [tubetyreBtn.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubetyreBtn.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:20].active=YES;
    [tubetyreBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/3.5].active=YES;
    [tubetyreBtn.heightAnchor constraintEqualToConstant:21].active=YES;
    tubetyreBtn.tag=1;
    [tubetyreBtn addTarget:self action:@selector(tyretypeAction:) forControlEvents:UIControlEventTouchUpInside];
    //tubetyreBtn.backgroundColor=Singlecolor(grayColor);
    
    tubelessImg=[[UIImageView alloc]init];
    [addvechScroll addSubview:tubelessImg];
    tubelessImg.translatesAutoresizingMaskIntoConstraints = NO;
    [tubelessImg.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubelessImg.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:0].active=YES;
    [tubelessImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
    [tubelessImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
    tubelessImg.image=image(@"radiouncheck");


    UILabel * tubelessLbl=[[UILabel alloc]init];
    [addvechScroll addSubview:tubelessLbl];
    tubelessLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tubelessLbl.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubelessLbl.leftAnchor constraintEqualToAnchor:tubelessImg.rightAnchor constant:10].active=YES;
    [tubelessLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
    [tubelessLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
    tubelessLbl.text=@"Tubeless";
    tubelessLbl.font=RalewayRegular(appDelegate.font-2);


    tubelessBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:tubelessBtn];
    tubelessBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [tubelessBtn.topAnchor constraintEqualToAnchor:tyreLbl.bottomAnchor constant:10].active=YES;
    [tubelessBtn.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:20].active=YES;
    [tubelessBtn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
    [tubelessBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
    tubelessBtn.tag=2;
    [tubelessBtn addTarget:self action:@selector(tyretypeAction:) forControlEvents:UIControlEventTouchUpInside];
    //tubelessBtn.backgroundColor=Singlecolor(grayColor);

    submittopAnch=tubelessBtn.bottomAnchor;
    [self framechange];
}

- (void)submitAction
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostAddVehicle];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
        NSDictionary * dic = @{
                               @"brand":brandStr,@"model":modelStr,@"userId":[login valueForKey:@"_id"],@"vehicleType":typeStr,@"tyreType":tyreStr,@"vehicleNumber":vechilenoTxtfld.text,@"manufactureYear":@"2018",@"carJockey":jockeyStr,@"engineType":engineStr,@"secondaryTyre":secondaryStr
                               };
        NSMutableDictionary * parameters=[[NSMutableDictionary alloc]init];
        [parameters setObject:dic forKey:@"data"];
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"response data %@",responseObject);
             
             if ([[responseObject objectForKey:@"status"]integerValue]==0) {
                 NSLog(@"0");
                 [self->appDelegate stopProgressView];
                 [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             }
             else
             {
                 NSLog(@"1");
                 if (![self->urlpath isEqualToString:@""]) {
                     AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
                     uploadRequest.body = self->fileUrl;
                     uploadRequest.bucket = @"motoserve/MotoServe/Vehicle";
                     uploadRequest.key = self->urlpath;
                     //uploadRequest.contentType = @"image/png";
                     uploadRequest.ACL = AWSS3BucketCannedACLPublicRead;
                     
                     AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
                     
                     [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                        withBlock:^id(AWSTask *task) {
                                                                            if (task.error != nil) {
                                                                                NSLog(@"%s %@","Error uploading :", uploadRequest.key);
                                                                            }else { NSLog(@"Upload completed"); }
                                                                            return nil;
                                                                        }];
                 }
                 [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
                 [self->appDelegate stopProgressView];
                 [self.navigationController popViewControllerAnimated:YES];
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
    if ([vechilenoTxtfld.text length]==0) {
        [Utils showErrorAlert:@"Please Enter Vehicle Number" delegate:nil];
        return NO;
    }
    if ([brandBtn.titleLabel.text isEqualToString:@"Brand"]) {
        [Utils showErrorAlert:@"Please Select Brand" delegate:nil];
        return NO;
    }
    if ([modelBtn.titleLabel.text isEqualToString:@"Model"]) {
        [Utils showErrorAlert:@"Please Select Model" delegate:nil];
        return NO;
    }
    if ([tyreStr isEqualToString:@""]) {
        [Utils showErrorAlert:@"Please Select Tyre Type" delegate:nil];
        return NO;
    }
    if (iscar) {
        if ([engineStr isEqualToString:@""]) {
            [Utils showErrorAlert:@"Please Select Engine Type" delegate:nil];
            return NO;
        }
        if ([jockeyStr isEqualToString:@""]) {
            [Utils showErrorAlert:@"Please Select Jockey Available" delegate:nil];
            return NO;
        }
        if ([secondaryStr isEqualToString:@""]) {
            [Utils showErrorAlert:@"Please Select Spare Tyre" delegate:nil];
            return NO;
        }
    }
    return YES;
}

- (void)tyretypeAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        tubelessImg.image=image(@"radiocheck");
        tubeImg.image=image(@"radiouncheck");
        tyreStr=@"TL";
    }
    else
    {
        tubeImg.image=image(@"radiocheck");
        tubelessImg.image=image(@"radiouncheck");
        tyreStr=@"T";
    }
}
- (void)brandAction:(id)sender
{
    
    selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view.window  addSubview:selection];
    
    [selection CreateTableview:vechicleArray withSender:sender  withTitle:@"Please select Brand" setCompletionBlock:^(int tag){
        [self->brandBtn setTitle:[self->vechicleArray objectAtIndex:tag] forState:UIControlStateNormal];
        self->brandStr=[self->vechicleArray objectAtIndex:tag];
        if (self->iscar) {
            self->vechiclemodeldic=[self->json valueForKey:@"carModels"];
        }
        else
        {
            self->vechiclemodeldic=[self->json valueForKey:@"bikeModels"];
        }
        self->vechiclesubArray=[[NSMutableArray alloc]init];
        self->vechiclesubArray=[[self->vechiclemodeldic valueForKey:[self->vechicleArray objectAtIndex:tag]]valueForKey:@"name"];
    }];
}
- (void)modelAction:(id)sender
{
    selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view.window  addSubview:selection];
    
    [selection CreateTableview:vechiclesubArray withSender:sender  withTitle:@"Please select Model" setCompletionBlock:^(int tag){
        [self->modelBtn setTitle:[self->vechiclesubArray objectAtIndex:tag] forState:UIControlStateNormal];
        self->modelStr=[self->vechiclesubArray objectAtIndex:tag];
    }];
}

- (void)vechicleAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    vechicleArray=[[NSMutableArray alloc]init];
    [brandBtn setTitle:@"Brand" forState:UIControlStateNormal];
    [modelBtn setTitle:@"Model" forState:UIControlStateNormal];
    vechilenoTxtfld.text=@"";
    if (selectedtag==2) {
        [fourwheelBtn setBackgroundImage:image(@"car_select") forState:UIControlStateNormal];
        [twowheelBtn setBackgroundImage:image(@"bike_unselect") forState:UIControlStateNormal];
        vechicleArray=[[json valueForKey:@"carBrands"]valueForKey:@"name"];
        iscar=YES;
        typeStr=@"C";
        carLbl.textColor=RGB(0, 90, 45);
        bikeLbl.textColor=Singlecolor(lightGrayColor);
    }
    else
    {
        [fourwheelBtn setBackgroundImage:image(@"car_unselect") forState:UIControlStateNormal];
        [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
        vechicleArray=[[json valueForKey:@"bikeBrands"]valueForKey:@"name"];
        submittopAnch=tubelessBtn.bottomAnchor;
        iscar=NO;
        typeStr=@"T";
        bikeLbl.textColor=RGB(0, 90, 45);
        carLbl.textColor=Singlecolor(lightGrayColor);
    }
    [self framechange];
}
- (void)framechange
{
    [carView removeFromSuperview];
    if (iscar) {
        
        carView=[[UIView alloc]init];
        [addvechScroll addSubview:carView];
        carView.translatesAutoresizingMaskIntoConstraints = NO;
        [carView.topAnchor constraintEqualToAnchor:tubetyreBtn.bottomAnchor constant:20].active=YES;
        [carView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
        [carView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
        //[carView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
        //carView.backgroundColor=Singlecolor(redColor);
        
        UILabel * engineLbl=[[UILabel alloc]init];
        [carView addSubview:engineLbl];
        engineLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [engineLbl.topAnchor constraintEqualToAnchor:carView.topAnchor constant:0].active=YES;
        [engineLbl.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:0].active=YES;
        [engineLbl.widthAnchor constraintEqualToAnchor:tyreLbl.widthAnchor constant:0].active=YES;
        [engineLbl.heightAnchor constraintEqualToAnchor:tyreLbl.heightAnchor constant:0].active=YES;
        engineLbl.text=@"Engine Type";
        engineLbl.textColor=RGB(17, 90, 42);
        engineLbl.textAlignment=NSTextAlignmentLeft;
        engineLbl.font=RalewayRegular(appDelegate.font-2);
     
        
        petrolImg=[[UIImageView alloc]init];
        [carView addSubview:petrolImg];
        petrolImg.translatesAutoresizingMaskIntoConstraints = NO;
        [petrolImg.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [petrolImg.leftAnchor constraintEqualToAnchor:tubeImg.leftAnchor constant:0].active=YES;
        [petrolImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [petrolImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        petrolImg.image=image(@"radiouncheck");


        UILabel * petrolLbl=[[UILabel alloc]init];
        [carView addSubview:petrolLbl];
        petrolLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [petrolLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [petrolLbl.leftAnchor constraintEqualToAnchor:tubeImg.rightAnchor constant:5].active=YES;
        [petrolLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [petrolLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        petrolLbl.text=@"Petrol";
        petrolLbl.font=RalewayRegular(appDelegate.font-2);


        petrolBtn=[[UIButton alloc]init];
        [carView addSubview:petrolBtn];
        petrolBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [petrolBtn.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [petrolBtn.leftAnchor constraintEqualToAnchor:tubetyreBtn.leftAnchor constant:0].active=YES;
        [petrolBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/3.6].active=YES;
        [petrolBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        petrolBtn.tag=1;
        [petrolBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
        //petrolBtn.backgroundColor=Singlecolor(grayColor);
        
        dieselImg=[[UIImageView alloc]init];
        [carView addSubview:dieselImg];
        dieselImg.translatesAutoresizingMaskIntoConstraints = NO;
        [dieselImg.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [dieselImg.leftAnchor constraintEqualToAnchor:petrolBtn.rightAnchor constant:0].active=YES;
        [dieselImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [dieselImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        dieselImg.image=image(@"radiouncheck");


        UILabel * dieselLbl=[[UILabel alloc]init];
        [carView addSubview:dieselLbl];
        dieselLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [dieselLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [dieselLbl.leftAnchor constraintEqualToAnchor:dieselImg.rightAnchor constant:5].active=YES;
        [dieselLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [dieselLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        dieselLbl.text=@"Diesel";
        dieselLbl.font=RalewayRegular(appDelegate.font-2);


        dieselBtn=[[UIButton alloc]init];
        [carView addSubview:dieselBtn];
        dieselBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [dieselBtn.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [dieselBtn.leftAnchor constraintEqualToAnchor:petrolBtn.rightAnchor constant:0].active=YES;
        [dieselBtn.widthAnchor constraintEqualToAnchor:petrolBtn.widthAnchor constant:0].active=YES;
        [dieselBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        dieselBtn.tag=2;
        [dieselBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
        //dieselBtn.backgroundColor=Singlecolor(grayColor);
        
        
        
        ////////
        lpgImg=[[UIImageView alloc]init];
        [carView addSubview:lpgImg];
        lpgImg.translatesAutoresizingMaskIntoConstraints = NO;
        [lpgImg.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [lpgImg.leftAnchor constraintEqualToAnchor:dieselBtn.rightAnchor constant:0].active=YES;
        [lpgImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [lpgImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        lpgImg.image=image(@"radiouncheck");
        [carView addSubview:lpgImg];

        UILabel * lpgLbl=[[UILabel alloc]init];
        [carView addSubview:lpgLbl];
        lpgLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [lpgLbl.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [lpgLbl.leftAnchor constraintEqualToAnchor:lpgImg.rightAnchor constant:5].active=YES;
        [lpgLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [lpgLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        lpgLbl.text=@"Lpg";
        lpgLbl.font=RalewayRegular(appDelegate.font-2);



        lpgBtn=[[UIButton alloc]init];
         [carView addSubview:lpgBtn];
        lpgBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [lpgBtn.topAnchor constraintEqualToAnchor:engineLbl.bottomAnchor constant:10].active=YES;
        [lpgBtn.leftAnchor constraintEqualToAnchor:dieselBtn.rightAnchor constant:0].active=YES;
        [lpgBtn.widthAnchor constraintEqualToAnchor:petrolBtn.widthAnchor constant:0].active=YES;
        [lpgBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        lpgBtn.tag=3;
        [lpgBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
       
        
        
        UILabel * jockeyLbl=[[UILabel alloc]init];
        [carView addSubview:jockeyLbl];
        jockeyLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [jockeyLbl.topAnchor constraintEqualToAnchor:petrolBtn.bottomAnchor constant:10].active=YES;
        [jockeyLbl.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:0].active=YES;
        [jockeyLbl.widthAnchor constraintEqualToAnchor:tyreLbl.widthAnchor constant:0].active=YES;
        [jockeyLbl.heightAnchor constraintEqualToAnchor:tyreLbl.heightAnchor constant:0].active=YES;
        jockeyLbl.text=@"Jockey Available";
        jockeyLbl.textColor=RGB(17, 90, 42);
        jockeyLbl.font=RalewayRegular(appDelegate.font-2);
        
        
        
        yesImg=[[UIImageView alloc]init];
        [carView addSubview:yesImg];
        yesImg.translatesAutoresizingMaskIntoConstraints = NO;
        [yesImg.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [yesImg.leftAnchor constraintEqualToAnchor:tubeImg.leftAnchor constant:0].active=YES;
        [yesImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [yesImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        yesImg.image=image(@"radiouncheck");
        [carView addSubview:yesImg];
        
        UILabel * yesLbl=[[UILabel alloc]init];
        [carView addSubview:yesLbl];
        yesLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [yesLbl.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [yesLbl.leftAnchor constraintEqualToAnchor:tubeImg.rightAnchor constant:10].active=YES;
        [yesLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [yesLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        yesLbl.text=@"Yes";
        yesLbl.font=RalewayRegular(appDelegate.font-2);
        
        
        
        UIButton *  yesBtn=[[UIButton alloc]init];
        [carView addSubview:yesBtn];
        yesBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [yesBtn.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [yesBtn.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:20].active=YES;
        [yesBtn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [yesBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        yesBtn.tag=1;
        [yesBtn addTarget:self action:@selector(vechiclejockeyAction:) forControlEvents:UIControlEventTouchUpInside];
       // yesBtn.backgroundColor=Singlecolor(grayColor);
        
        noImg=[[UIImageView alloc]init];
        [carView addSubview:noImg];
        noImg.translatesAutoresizingMaskIntoConstraints = NO;
        [noImg.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [noImg.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:0].active=YES;
        [noImg.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [noImg.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        noImg.image=image(@"radiouncheck");
        
        
        UILabel * noLbl=[[UILabel alloc]init];
        [carView addSubview:noLbl];
        noLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [noLbl.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [noLbl.leftAnchor constraintEqualToAnchor:tubelessImg.rightAnchor constant:10].active=YES;
        [noLbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [noLbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        noLbl.text=@"No";
        noLbl.font=RalewayRegular(appDelegate.font-2);
        
        
        
        UIButton * noBtn=[[UIButton alloc]init];
        [carView addSubview:noBtn];
        noBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [noBtn.topAnchor constraintEqualToAnchor:jockeyLbl.bottomAnchor constant:10].active=YES;
        [noBtn.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:20].active=YES;
        [noBtn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [noBtn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        noBtn.tag=2;
        [noBtn addTarget:self action:@selector(vechiclejockeyAction:) forControlEvents:UIControlEventTouchUpInside];
        //noBtn.backgroundColor=Singlecolor(grayColor);
        
        UILabel * secondaryLbl=[[UILabel alloc]init];
        [carView addSubview:secondaryLbl];
        secondaryLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [secondaryLbl.topAnchor constraintEqualToAnchor:noBtn.bottomAnchor constant:10].active=YES;
        [secondaryLbl.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:0].active=YES;
        [secondaryLbl.widthAnchor constraintEqualToAnchor:tyreLbl.widthAnchor constant:0].active=YES;
        [secondaryLbl.heightAnchor constraintEqualToAnchor:tyreLbl.heightAnchor constant:0].active=YES;
        secondaryLbl.text=@"Spare Tyre";
        secondaryLbl.textColor=RGB(17, 90, 42);
        secondaryLbl.font=RalewayRegular(appDelegate.font-2);

        
        
        yes1Img=[[UIImageView alloc]init];
        [carView addSubview:yes1Img];
        yes1Img.translatesAutoresizingMaskIntoConstraints = NO;
        [yes1Img.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [yes1Img.leftAnchor constraintEqualToAnchor:tubeImg.leftAnchor constant:0].active=YES;
        [yes1Img.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [yes1Img.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        yes1Img.image=image(@"radiouncheck");
        
        
        UILabel * yes1Lbl=[[UILabel alloc]init];
        [carView addSubview:yes1Lbl];
        yes1Lbl.translatesAutoresizingMaskIntoConstraints = NO;
        [yes1Lbl.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [yes1Lbl.leftAnchor constraintEqualToAnchor:tubeImg.rightAnchor constant:10].active=YES;
        [yes1Lbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [yes1Lbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        yes1Lbl.text=@"Yes";
        yes1Lbl.font=RalewayRegular(appDelegate.font-2);
        
        
        
        UIButton *  yes1Btn=[[UIButton alloc]init];
        [carView addSubview:yes1Btn];
        yes1Btn.translatesAutoresizingMaskIntoConstraints = NO;
        [yes1Btn.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [yes1Btn.leftAnchor constraintEqualToAnchor:tyreLbl.leftAnchor constant:20].active=YES;
        [yes1Btn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [yes1Btn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        yes1Btn.tag=1;
        [yes1Btn addTarget:self action:@selector(vechiclesecondaryAction:) forControlEvents:UIControlEventTouchUpInside];
        
        no1Img=[[UIImageView alloc]init];
        [carView addSubview:no1Img];
        no1Img.translatesAutoresizingMaskIntoConstraints = NO;
        [no1Img.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [no1Img.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:0].active=YES;
        [no1Img.widthAnchor constraintEqualToAnchor:tubeImg.widthAnchor constant:0].active=YES;
        [no1Img.heightAnchor constraintEqualToAnchor:tubeImg.heightAnchor constant:0].active=YES;
        no1Img.image=image(@"radiouncheck");
        
        
        
        UILabel * no1Lbl=[[UILabel alloc]init];
        [carView addSubview:no1Lbl];
        no1Lbl.translatesAutoresizingMaskIntoConstraints = NO;
        [no1Lbl.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [no1Lbl.leftAnchor constraintEqualToAnchor:tubelessImg.rightAnchor constant:10].active=YES;
        [no1Lbl.widthAnchor constraintEqualToAnchor:tubeLbl.widthAnchor constant:0].active=YES;
        [no1Lbl.heightAnchor constraintEqualToAnchor:tubeLbl.heightAnchor constant:0].active=YES;
        no1Lbl.text=@"No";
        no1Lbl.font=RalewayRegular(appDelegate.font-2);
        
        
        
        UIButton * no1Btn=[[UIButton alloc]init];
        [carView addSubview:no1Btn];
        no1Btn.translatesAutoresizingMaskIntoConstraints = NO;
        [no1Btn.topAnchor constraintEqualToAnchor:secondaryLbl.bottomAnchor constant:10].active=YES;
        [no1Btn.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:20].active=YES;
        [no1Btn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [no1Btn.heightAnchor constraintEqualToAnchor:tubetyreBtn.heightAnchor constant:0].active=YES;
        no1Btn.tag=2;
        [no1Btn addTarget:self action:@selector(vechiclesecondaryAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        imgBtn=[[UIButton alloc]init];
        [carView addSubview:imgBtn];
        imgBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [imgBtn.topAnchor constraintEqualToAnchor:no1Btn.bottomAnchor constant:20].active=YES;
        [imgBtn.leftAnchor constraintEqualToAnchor:engineLbl.leftAnchor constant:0].active=YES;
        [imgBtn.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [imgBtn.heightAnchor constraintEqualToConstant:50].active=YES;
        [imgBtn addTarget:self action:@selector(uploadicon) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.layer.cornerRadius = 5;
        imgBtn.layer.borderWidth = 0.5;
        imgBtn.layer.masksToBounds = true;
        imgBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
        
        camImg=[[UIImageView alloc]init];
        [imgBtn addSubview:camImg];
        camImg.translatesAutoresizingMaskIntoConstraints = NO;
        [camImg.centerXAnchor constraintEqualToAnchor:imgBtn.centerXAnchor constant:0].active=YES;
        [camImg.centerYAnchor constraintEqualToAnchor:imgBtn.centerYAnchor constant:0].active=YES;
        [camImg.widthAnchor constraintEqualToConstant:25].active=YES;
        [camImg.heightAnchor constraintEqualToConstant:20].active=YES;
        camImg.image=image(@"camera");
        
        
        UILabel * uploadLbl=[[UILabel alloc]init];
        [carView addSubview:uploadLbl];
        uploadLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [uploadLbl.topAnchor constraintEqualToAnchor:no1Btn.bottomAnchor constant:25].active=YES;
        [uploadLbl.leftAnchor constraintEqualToAnchor:tubetyreBtn.rightAnchor constant:0].active=YES;
        [uploadLbl.widthAnchor constraintEqualToAnchor:tubetyreBtn.widthAnchor constant:0].active=YES;
        [uploadLbl.heightAnchor constraintEqualToConstant:25].active=YES;
        uploadLbl.text=@"Upload Image";
        uploadLbl.font=RalewayRegular(appDelegate.font-2);
        
        
        [carView.bottomAnchor constraintEqualToAnchor:imgBtn.bottomAnchor constant:10].active=YES;
        submittopAnch=imgBtn.bottomAnchor;
    }
    [submitBtn removeFromSuperview];
    submitBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active=YES;
    [submitBtn.topAnchor constraintEqualToAnchor:submittopAnch constant:20].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:100].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(17, 90, 42) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll.bottomAnchor constraintEqualToAnchor:submitBtn.bottomAnchor constant:20].active=YES;
    
}


- (void)uploadicon
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
#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [imgBtn setBackgroundImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    camImg.hidden=YES;
    NSDate * date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hhmm"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    urlpath=[NSString stringWithFormat:@"img_%@.png",stringFromDate];
    
    //convert uiimage to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",urlpath]];
    UIImage * selectedImg=[info objectForKey:UIImagePickerControllerOriginalImage];
    [UIImagePNGRepresentation(selectedImg) writeToFile:filePath atomically:YES];
    fileUrl = [NSURL fileURLWithPath:filePath];
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
- (void)vechiclesecondaryAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        no1Img.image=image(@"radiocheck");
        yes1Img.image=image(@"radiouncheck");
        secondaryStr=@"0";
    }
    else
    {
        yes1Img.image=image(@"radiocheck");
        no1Img.image=image(@"radiouncheck");
        secondaryStr=@"1";
    }
}
- (void)vechiclejockeyAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        noImg.image=image(@"radiocheck");
        yesImg.image=image(@"radiouncheck");
        jockeyStr=@"0";
    }
    else
    {
        yesImg.image=image(@"radiocheck");
        noImg.image=image(@"radiouncheck");
        jockeyStr=@"1";
    }
}

- (void)vechicletypeAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        dieselImg.image=image(@"radiocheck");
        petrolImg.image=image(@"radiouncheck");
        lpgImg.image=image(@"radiouncheck");
        engineStr=@"D";
    }
    else if (selectedtag==3)
    {
        lpgImg.image=image(@"radiocheck");
        dieselImg.image=image(@"radiouncheck");
        petrolImg.image=image(@"radiouncheck");
        engineStr=@"L";
    }
    else
    {
        petrolImg.image=image(@"radiocheck");
        dieselImg.image=image(@"radiouncheck");
        lpgImg.image=image(@"radiouncheck");
        engineStr=@"P";
    }
}
@end
