//
//  constraintViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 02/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "constraintViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface constraintViewController ()
{
    UIView * contentView,*navHeader;
    AppDelegate * appDelegate;
    NSMutableArray * prebkImgArray,*prebktextArray;
    NSArray * bannerArray;
    NSInteger jslider;
    float xslider;
    UIScrollView * bannerSrl;
    NSTimer *timer;
    UIPageControl * pageControl;
}
@end

@implementation constraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =RGB(222, 230, 239);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Motosserve" IsText:YES Menu:YES IsCart:YES LeftClass:nil LeftSelector:nil RightClass:self RightSelector:nil WithCartCount:0 SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    prebkImgArray=[[NSMutableArray alloc]initWithObjects:@"11",@"12",@"13",@"14",@"15",@"16",nil];
    prebktextArray=[[NSMutableArray alloc]initWithObjects:@"Repair Service",@"Oil Change",@"Wheel Alignment",@"Spa",@"Painting",@"AC Repair",nil];
    [self createDesign];
}
- (void)createDesign
{
    bannerSrl=[[UIScrollView alloc]init];
    bannerSrl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerSrl];
    [bannerSrl.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?90:70].active=YES;
    [bannerSrl.heightAnchor constraintEqualToConstant:SCREEN_HEIGHT/4].active=YES;
    [bannerSrl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=true;
    [bannerSrl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=true;
    bannerSrl.userInteractionEnabled=NO;
    bannerSrl.pagingEnabled=YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    bannerArray = [[NSArray alloc]initWithObjects:@"service1.jpg",@"service2.jpg",@"service1.jpg",@"service2.jpg", nil];
    
    NSLayoutAnchor * leftAnc=bannerSrl.leftAnchor;
    
    for (int i=0; i<[bannerArray count]; i++) {
        UIImageView *  bannerImg=[[UIImageView alloc]init];
        bannerImg.translatesAutoresizingMaskIntoConstraints = NO;
        [bannerSrl addSubview:bannerImg];
        
        [bannerImg.topAnchor constraintEqualToAnchor:bannerSrl.topAnchor constant:0].active=true;
        [bannerImg.widthAnchor constraintEqualToConstant:SCREEN_WIDTH].active=true;
        [bannerImg.leftAnchor constraintEqualToAnchor:leftAnc constant:0].active=true;
        [bannerImg.heightAnchor constraintEqualToAnchor:bannerSrl.heightAnchor constant:0].active=true;
        bannerImg.image=image([bannerArray objectAtIndex:i]);
        
        leftAnc=bannerImg.rightAnchor;
    }
    [bannerSrl.rightAnchor constraintEqualToAnchor:leftAnc constant:0].active=true;
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pageControl];
    [pageControl.topAnchor constraintEqualToAnchor:bannerSrl.bottomAnchor constant:5].active=YES;
    [pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active=YES;
    pageControl.numberOfPages = bannerArray.count;
    pageControl.currentPageIndicatorTintColor=RGB(0, 89, 42);
    pageControl.pageIndicatorTintColor=Singlecolor(whiteColor);
    
    
    xslider=0;
    UIView * footerView=[[UIView alloc]init];
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:footerView];
    [footerView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50].active=YES;
    [footerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
    [footerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [footerView.heightAnchor constraintEqualToConstant:50].active=YES;
    
    
    UIButton * trackBtn=[[UIButton alloc]init];
    [footerView addSubview:trackBtn];
    trackBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [trackBtn.topAnchor constraintEqualToAnchor:footerView.topAnchor constant:0].active=YES;
    [trackBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2].active=YES;
    [trackBtn.heightAnchor constraintEqualToAnchor:footerView.heightAnchor constant:0].active=YES;
    //trackBtn.backgroundColor=Singlecolor(greenColor);
    
    UIImageView * trackImg=[[UIImageView alloc]init];
    [footerView addSubview:trackImg];
    trackImg.translatesAutoresizingMaskIntoConstraints = NO;
    [trackImg.centerXAnchor constraintEqualToAnchor:trackBtn.centerXAnchor constant:0].active=YES;
    [trackImg.topAnchor constraintEqualToAnchor:trackBtn.topAnchor constant:7].active=YES;
    [trackImg.widthAnchor constraintLessThanOrEqualToConstant:14].active=YES;
    [trackImg.heightAnchor constraintEqualToConstant:20].active=YES;
    trackImg.image=image(@"track");
    
    UILabel * tracklbl=[[UILabel alloc]init];
    [footerView addSubview:tracklbl];
    tracklbl.translatesAutoresizingMaskIntoConstraints = NO;
    [tracklbl.topAnchor constraintEqualToAnchor:footerView.bottomAnchor constant:-21].active=YES;
    [tracklbl.widthAnchor constraintEqualToAnchor:trackBtn.widthAnchor constant:0].active=YES;
    [tracklbl.heightAnchor constraintLessThanOrEqualToConstant:21].active=YES;
    tracklbl.text=@"Track Order";
    tracklbl.font=RalewayRegular(appDelegate.font-7);
    tracklbl.textColor=Singlecolor(grayColor);
    tracklbl.textAlignment=NSTextAlignmentCenter;
    [trackBtn addSubview:tracklbl];
    
    
    UIView * dividerView=[[UIView alloc]init];
    [footerView addSubview:dividerView];
    dividerView.translatesAutoresizingMaskIntoConstraints = NO;
    [dividerView.leftAnchor constraintEqualToAnchor:trackBtn.rightAnchor constant:0].active=YES;
    [dividerView.centerYAnchor constraintEqualToAnchor:footerView.centerYAnchor constant:0].active=YES;
    [dividerView.widthAnchor constraintLessThanOrEqualToConstant:1].active=YES;
    [dividerView.heightAnchor constraintLessThanOrEqualToConstant:10].active=YES;
    dividerView.backgroundColor=Singlecolor(lightGrayColor);

    
    UIButton * addvehicleBtn=[[UIButton alloc]init];
    [footerView addSubview:addvehicleBtn];
    addvehicleBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [addvehicleBtn.topAnchor constraintEqualToAnchor:footerView.topAnchor constant:0].active=YES;
    [addvehicleBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2].active=YES;
    [addvehicleBtn.heightAnchor constraintEqualToAnchor:footerView.heightAnchor constant:0].active=YES;
    [addvehicleBtn.leftAnchor constraintEqualToAnchor:dividerView.rightAnchor constant:2].active=YES;
    addvehicleBtn.backgroundColor=Singlecolor(greenColor);
   // [addvehicleBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView * addImg=[[UIImageView alloc]initWithFrame:CGRectMake(addvehicleBtn.frame.size.width/2-10, 7, 20, 20)];
    addImg.image=image(@"addvechicle");
    [addvehicleBtn addSubview:addImg];
    
    UILabel * addLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, footerView.frame.size.height-21, addvehicleBtn.frame.size.width, 21)];
    addLbl.text=@"Add Vehicle";
    addLbl.font=RalewayRegular(appDelegate.font-7);
    addLbl.textColor=Singlecolor(grayColor);
    addLbl.textAlignment=NSTextAlignmentCenter;
    [addvehicleBtn addSubview:addLbl];
    
    
    
    
}

- (void)timerAction
{
    if(jslider < bannerArray.count-1)
    {
        xslider += SCREEN_WIDTH;
        jslider++;
    }
    else
    {
        xslider=0;
        jslider=0;
    }
     [bannerSrl setContentOffset:CGPointMake(xslider, 0)];
    pageControl.currentPage=jslider;
}

@end
