//
//  DraggableViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "DraggableViewController.h"
#import "CPMetaFile.h"
#import "AppDelegate.h"
@interface DraggableViewController ()
{
    UIScrollView *  statusScroll;
    AppDelegate * appDelegate;
}
@end

@implementation DraggableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self createDesign];
}

- (void)createDesign
{
    UIView * swipeView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3.0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT/3.0)];
    swipeView.backgroundColor=Singlecolor(whiteColor);
    [self.view addSubview:swipeView];
    
    
    UIButton * dragBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    dragBtn.backgroundColor=Singlecolor(whiteColor);
    dragBtn.layer.borderWidth = 1.0f;
    [dragBtn addTarget:self action:@selector(gestureHandlerMethod) forControlEvents:UIControlEventTouchUpInside];
    dragBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [swipeView addSubview:dragBtn];
    
    statusScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dragBtn.frame), swipeView.frame.size.width, swipeView.frame.size.height-CGRectGetMaxY(dragBtn.frame))];
    [swipeView addSubview:statusScroll];
    statusScroll.contentSize=CGSizeMake(320, 2000);
    //statusScroll.backgroundColor=Singlecolor(redColor);
    
    [self createSubDesign];
}
- (void)gestureHandlerMethod
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createSubDesign
{
    UILabel * vehiclenoLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, statusScroll.frame.size.width, 21)];
    vehiclenoLbl.text=@"TN 45 1420 - Hero Splendor Pro";
    vehiclenoLbl.font=RalewayRegular(appDelegate.font-2);
    vehiclenoLbl.textAlignment=NSTextAlignmentCenter;
    [statusScroll addSubview:vehiclenoLbl];
    
    
    UILabel * areaLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vehiclenoLbl.frame)+10, statusScroll.frame.size.width, 21)];
    areaLbl.text=@"Adyar Motors";
    areaLbl.font=RalewayRegular(appDelegate.font-2);
    areaLbl.textAlignment=NSTextAlignmentCenter;
    [statusScroll addSubview:areaLbl];
    
    
    UILabel * bookingidLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(areaLbl.frame)+10, statusScroll.frame.size.width/2.5, 21)];
    bookingidLbl.text=@"Booking ID:15257";
    bookingidLbl.font=RalewayRegular(appDelegate.font-2);
    bookingidLbl.textAlignment=NSTextAlignmentLeft;
    [statusScroll addSubview:bookingidLbl];
    
    
    UILabel * dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bookingidLbl.frame), bookingidLbl.frame.origin.y, bookingidLbl.frame.size.width, bookingidLbl.frame.size.height)];
    dateLbl.text=@"Date:12.01.2019";
    dateLbl.font=RalewayRegular(appDelegate.font-2);
    dateLbl.textAlignment=NSTextAlignmentRight;
    [statusScroll addSubview:dateLbl];
    
    UIView * waitingView=[[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(dateLbl.frame)+10, statusScroll.frame.size.width-80, statusScroll.frame.size.height/4.5-20)];
    [statusScroll addSubview:waitingView];
    waitingView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    waitingView.layer.borderWidth = 1.0f;
    waitingView.layer.cornerRadius = 8;
    waitingView.layer.masksToBounds = true;
    
    
    UIImageView * profImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, waitingView.frame.size.width/5, waitingView.frame.size.width/5)];
    profImg.layer.cornerRadius = profImg.frame.size.width/2;
    profImg.layer.masksToBounds = YES;
    profImg.image=image(@"logo");
    [waitingView addSubview:profImg];
    
    UILabel * nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(profImg.frame)-5, 5, waitingView.frame.size.width-(CGRectGetMaxX(profImg.frame)-10), 21)];
    nameLbl.text=@"Vinoth Kumar";
    //nameLbl.backgroundColor=Singlecolor(grayColor);
    nameLbl.textAlignment=NSTextAlignmentCenter;
    [waitingView addSubview:nameLbl];
    
    UIView * divView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(profImg.frame)+10, CGRectGetMaxY(nameLbl.frame)+10, nameLbl.frame.size.width-45, 1)];
    divView.backgroundColor=Singlecolor(lightGrayColor);
    [waitingView addSubview:divView];
    
    
    UILabel * noLbl=[[UILabel alloc]initWithFrame:CGRectMake(nameLbl.frame.origin.x+10, CGRectGetMaxY(divView.frame)+20, nameLbl.frame.size.width/1.8, 21)];
    noLbl.text=@"9787430308";
    noLbl.textAlignment=NSTextAlignmentCenter;
   // noLbl.backgroundColor=Singlecolor(grayColor);
    [waitingView addSubview:noLbl];
    
    UIView * div2View=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noLbl.frame), noLbl.frame.origin.y,1, 21)];
    div2View.backgroundColor=Singlecolor(lightGrayColor);
    [waitingView addSubview:div2View];
    
    UILabel * statusLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(waitingView.frame)+10, statusScroll.frame.size.width, 21)];
    statusLbl.text=@"Status";
    statusLbl.textAlignment=NSTextAlignmentCenter;
    statusLbl.font=RalewayRegular(appDelegate.font-2);
    [statusScroll addSubview:statusLbl];
    [statusLbl autowidth:0.0];
    
    
    
    
    
}

@end
