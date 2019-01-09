//
//  SuccessViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 08/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "SuccessViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface SuccessViewController ()
{
    UIView *navHeader;
    AppDelegate * appDelegate;
}
@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Payment Success" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
   
    [self createDesign];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createDesign
{
    UIImageView * successImg=[[UIImageView alloc]init];
    [self.view addSubview:successImg];
    successImg.translatesAutoresizingMaskIntoConstraints = NO;
    [successImg.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?180:160].active=YES;
    [successImg.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active=YES;
    [successImg.widthAnchor constraintEqualToConstant:100].active=YES;
    [successImg.heightAnchor constraintEqualToConstant:91].active=YES;
    successImg.image=image(@"success");
    
    UILabel * successLbl=[[UILabel alloc]init];
    [self.view addSubview:successLbl];
    successLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [successLbl.topAnchor constraintEqualToAnchor:successImg.bottomAnchor constant:50].active=YES;
    [successLbl.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:0].active=YES;
    [successLbl.heightAnchor constraintEqualToConstant:30].active=YES;
    successLbl.text=@"Payment Success";
    successLbl.textAlignment=NSTextAlignmentCenter;
    successLbl.textColor=RGB(0, 89, 42);
    successLbl.font=RalewayBold(appDelegate.font+4);
    
    
    UIButton *  submitBtn=[[UIButton alloc]init];
    [self.view addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.topAnchor constraintEqualToAnchor:successLbl.bottomAnchor constant:60].active=YES;
    [submitBtn.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:120].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:RGB(0, 87, 41)];
    [submitBtn setTitle:[NSString stringWithFormat:@"Done"] forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    
}
- (void)sumbitAction
{
    constraintViewController * home=[[constraintViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

@end
