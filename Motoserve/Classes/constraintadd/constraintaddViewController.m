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
    int ypos;
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
}
@end

@implementation constraintaddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (void)createDesign
{
    jockeyStr=@"0";
    engineStr=@"P";
    secondaryStr=@"0";
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
    
    
    twowheelBtn=[[UIButton alloc]init];
    [addvechScroll addSubview:twowheelBtn];
     addvechScroll.translatesAutoresizingMaskIntoConstraints = NO;
    [twowheelBtn.topAnchor constraintEqualToAnchor:addvechScroll.topAnchor constant:30].active=YES;
    [twowheelBtn.leftAnchor constraintEqualToAnchor:addvechScroll.leftAnchor constant:80].active=YES;
    [twowheelBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/4].active=YES;
    [twowheelBtn.heightAnchor constraintEqualToConstant:SCREEN_WIDTH/4].active=YES;
//WithFrame:CGRectMake(80,30, contentView.frame.size.width/4, contentView.frame.size.width/4)];
    twowheelBtn.tag=1;
    [twowheelBtn addTarget:self action:@selector(vechicleAction:) forControlEvents:UIControlEventTouchUpInside];
    [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
    
    typeStr=@"T";
    
    
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
    }
    else
    {
        [fourwheelBtn setBackgroundImage:image(@"car_unselect") forState:UIControlStateNormal];
        [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
        vechicleArray=[[json valueForKey:@"bikeBrands"]valueForKey:@"name"];
        ypos=CGRectGetMaxY(tubelessBtn.frame)+20;
        iscar=NO;
        typeStr=@"T";
    }
   // [self framechange];
}

@end
