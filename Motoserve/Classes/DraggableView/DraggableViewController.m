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
    UIView * prepareView,* startView,* rchView;
    NSDateFormatter *dateFormat;
    UIImageView * prepareImg,* startImg,* rchImg,* doneImg;
    UILabel *  prepareLbl,* startLbl,* starttimeLbl,* rchLbl,* rchtimeLbl,* doneLbl,* donetimeLbl;
    UIButton *  doneBtn;
    int scrollheight;
}
@end

@implementation DraggableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    dateFormat = [[NSDateFormatter alloc] init];
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
    
    //statusScroll.backgroundColor=Singlecolor(redColor);
    
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
    NSDate * startdate=[NSDate date];
    [dateFormat setDateFormat:@"dd.mm.yyyy"];
    dateLbl.text=[NSString stringWithFormat:@"Date:%@",[dateFormat stringFromDate:startdate]];
    //dateLbl.text=@"Date:12.01.2019";
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
    
    UIImageView * callImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(div2View.frame)+10, CGRectGetMaxY(divView.frame)+10, waitingView.frame.size.width/8, waitingView.frame.size.width/8)];
    callImg.layer.cornerRadius = callImg.frame.size.width/2;
    callImg.layer.masksToBounds = YES;
    callImg.image=image(@"logo");
    [waitingView addSubview:callImg];
    
    UILabel * statusLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(waitingView.frame)+10, statusScroll.frame.size.width, 21)];
    statusLbl.text=@"Status";
    statusLbl.textAlignment=NSTextAlignmentCenter;
    statusLbl.font=RalewayRegular(appDelegate.font-2);
    [statusScroll addSubview:statusLbl];
    
    
    prepareImg=[[UIImageView alloc]initWithFrame:CGRectMake(waitingView.frame.origin.x+40, CGRectGetMaxY(statusLbl.frame)+30, 11, 10)];
    prepareImg.image=image(@"Progress");
    [statusScroll addSubview:prepareImg];
    
    prepareLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prepareImg.frame)+20,CGRectGetMaxY(statusLbl.frame)+25,statusLbl.frame.size.width-120, 21)];
    prepareLbl.text=@"Preparing Tools";
    prepareLbl.textColor=Singlecolor(blackColor);
    
    prepareLbl.font=RalewayRegular(appDelegate.font-2);
    [statusScroll addSubview:prepareLbl];
    
    UILabel * preparetimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(prepareLbl.frame), prepareLbl.frame.size.width, 21)];
    NSDate * date=[NSDate date];
    [dateFormat setDateFormat:@"hh:mm a"];
    preparetimeLbl.text=[dateFormat stringFromDate:date];
    preparetimeLbl.textColor=Singlecolor(lightGrayColor);
    preparetimeLbl.font=RalewayRegular(appDelegate.font-4);
    [statusScroll addSubview:preparetimeLbl];
    
    scrollheight=CGRectGetMaxY(preparetimeLbl.frame);
    
    [self receivesegmentNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivesegmentNotification)
                                                 name:@"changetype"
                                               object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)gestureHandlerMethod
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)receivesegmentNotification
{
    
    if ([appDelegate.bookingstatusStr isEqualToString:@"2"]) {
        prepareView=[[UIView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x+5, CGRectGetMaxY(prepareImg.frame), 1, 80)];
        prepareView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:prepareView];
        
       startImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(prepareView.frame), 11, 10)];
        startImg.image=image(@"Progress");
        [statusScroll addSubview:startImg];
        
        startLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,startImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        startLbl.text=@"Start Navigation";
        startLbl.textColor=Singlecolor(blackColor);
        startLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:startLbl];
        
        
        starttimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(startLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * startdate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        starttimeLbl.text=[dateFormat stringFromDate:startdate];
        starttimeLbl.textColor=Singlecolor(lightGrayColor);
        starttimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:starttimeLbl];
        
        scrollheight=CGRectGetMaxY(starttimeLbl.frame);
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"3"])
    {
    startView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(startImg.frame), 1, prepareView.frame.size.height)];
        startView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:startView];
        
        
    rchImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(startView.frame), 11, 10)];
        rchImg.image=image(@"Progress");
        [statusScroll addSubview:rchImg];
        
    rchLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,rchImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        rchLbl.text=@"Work In Progress";
        rchLbl.textColor=Singlecolor(blackColor);
        rchLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:rchLbl];
        
    rchtimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(rchLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * rchdate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        rchtimeLbl.text=[dateFormat stringFromDate:rchdate];
        rchtimeLbl.textColor=Singlecolor(lightGrayColor);
        rchtimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:rchtimeLbl];
        
        scrollheight=CGRectGetMaxY(rchtimeLbl.frame);
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"4"])
    {
    rchView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(rchImg.frame), 1, prepareView.frame.size.height)];
        rchView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:rchView];
        
        
    doneImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(rchView.frame), 11, 10)];
        doneImg.image=image(@"Progress");
        [statusScroll addSubview:doneImg];
        
    doneLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,doneImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        doneLbl.text=@"Work Done";
        doneLbl.textColor=Singlecolor(blackColor);
        doneLbl.font=RalewayRegular(self->appDelegate.font-2);
        [self->statusScroll addSubview:doneLbl];
        
    donetimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(doneLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * donedate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        donetimeLbl.text=[dateFormat stringFromDate:donedate];
        donetimeLbl.textColor=Singlecolor(lightGrayColor);
        donetimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:donetimeLbl];
        
        
    doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(doneLbl.frame)+40, 100, 30)];
        [doneBtn setBackgroundColor:Singlecolor(clearColor)];
        [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        doneBtn.titleLabel.font=RalewayRegular(self->appDelegate.font-2);
        [doneBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
        doneBtn.layer.cornerRadius = 5;
        doneBtn.layer.borderWidth = 0.5;
        doneBtn.layer.masksToBounds = true;
        doneBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
        //[doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [statusScroll addSubview:doneBtn];
        
        scrollheight=CGRectGetMaxY(doneBtn.frame);
    }
    
    statusScroll.contentSize=CGSizeMake(320, scrollheight+20);
}

@end
