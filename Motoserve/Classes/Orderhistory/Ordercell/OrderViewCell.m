//
//  OrderViewCell.m
//  Motoserve
//
//  Created by Karthik Baskaran on 07/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "OrderViewCell.h"
#import "Utils.h"
#import "AppDelegate.h"

@implementation OrderViewCell
{
    AppDelegate *appDelegate;
    UIView  * MainView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createDesign];
    }
    return self;
}
-(void)createDesign{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MainView=[[UIView alloc]init];
    [self.contentView addSubview:MainView];
    MainView.translatesAutoresizingMaskIntoConstraints = NO;
    [MainView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active=YES;
    [MainView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active=YES;
    [MainView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active=YES;
    [MainView.heightAnchor constraintEqualToConstant:130].active=YES;
    MainView.backgroundColor=Singlecolor(clearColor);
    MainView.layer.borderColor = [UIColor blackColor].CGColor;
    MainView.layer.borderWidth = 1.0f;
    MainView.layer.cornerRadius = 8;
    MainView.layer.masksToBounds = true;
    
    
    
    UILabel * dateLbl=[[UILabel alloc]init];
    [MainView addSubview:dateLbl];
    dateLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [dateLbl.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:0].active=YES;
    [dateLbl.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:10].active=YES;
    [dateLbl.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/4.5].active=YES;
    [dateLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    //dateLbl.backgroundColor=Singlecolor(redColor);
    dateLbl.text=@"Date : 12.12.2018";
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
    [orderidLbl.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:0].active=YES;
    [orderidLbl.leftAnchor constraintEqualToAnchor:headerImg.rightAnchor constant:5].active=YES;
    [orderidLbl.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-10].active=YES;
    [orderidLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    //orderidLbl.backgroundColor=Singlecolor(redColor);
    orderidLbl.text=@"Order ID : 1525252";
    orderidLbl.font=RalewayRegular(appDelegate.font-7);
    orderidLbl.textColor=Singlecolor(grayColor);
    orderidLbl.textAlignment=NSTextAlignmentRight;
    
    
    UIView * imgdiv=[[UIView alloc]init];
    [MainView addSubview:imgdiv];
    imgdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [imgdiv.topAnchor constraintEqualToAnchor:dateLbl.bottomAnchor constant:20].active=YES;
    [imgdiv.leftAnchor constraintEqualToAnchor:dateLbl.rightAnchor constant:5].active=YES;
    [imgdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [imgdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-30].active=YES;
    imgdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    UIView * orderdiv=[[UIView alloc]init];
    [MainView addSubview:orderdiv];
    orderdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [orderdiv.topAnchor constraintEqualToAnchor:orderidLbl.bottomAnchor constant:20].active=YES;
    [orderdiv.leftAnchor constraintEqualToAnchor:orderidLbl.leftAnchor constant:5].active=YES;
    [orderdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [orderdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-30].active=YES;
    orderdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    UIView * namedivView=[[UIView alloc]init];
    [MainView addSubview:namedivView];
    namedivView.translatesAutoresizingMaskIntoConstraints = NO;
    [namedivView.centerYAnchor constraintEqualToAnchor:MainView.centerYAnchor constant:10].active=YES;
    [namedivView.leftAnchor constraintEqualToAnchor:imgdiv.rightAnchor constant:5].active=YES;
    [namedivView.rightAnchor constraintEqualToAnchor:orderdiv.leftAnchor constant:-5].active=YES;
    [namedivView.heightAnchor constraintEqualToConstant:1].active=YES;
    namedivView.backgroundColor=Singlecolor(lightGrayColor);
    
    
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
    
}

@end