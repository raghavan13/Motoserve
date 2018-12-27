//
//  HomeViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 12/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"


@interface HomeViewController ()<LCBannerViewDelegate>
{
    UIView * contentView,*navHeader;
    AppDelegate * appDelegate;
    LCBannerView *bannerView;
    NSInteger jslider;
    float xslider;
    NSArray *bannerArray;
    UIScrollView * bannerSrl,* onrdScrl,* prebookScrl;
    UIImageView * bannerImg;
    UIPageControl *  pageControl;
    UIButton * onrdBtn,* prebkBtn;
    NSMutableArray * prebkImgArray,*prebktextArray;
}
@end

@implementation HomeViewController

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =RGB(222, 230, 239);
    self.view = contentView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Motosserve" IsText:YES Menu:YES IsCart:YES LeftClass:nil LeftSelector:nil RightClass:self RightSelector:nil WithCartCount:0 SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    prebkImgArray=[[NSMutableArray alloc]initWithObjects:@"11",@"12",@"13",@"14",@"15",@"16",nil];
    prebktextArray=[[NSMutableArray alloc]initWithObjects:@"Repair Service",@"Oil Change",@"Wheel Alignment",@"Spa",@"Painting",@"AC Repair",nil];
    [self createDesign];
}

- (void)createDesign
{
    UIScrollView * hmeScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IS_IPHONEX?90:70, contentView.frame.size.width, contentView.frame.size.height)];
//    [contentView addSubview:hmeScroll];
    
    bannerArray = [[NSArray alloc]initWithObjects:@"service1.jpg",@"service2.jpg",@"service1.jpg",@"service2.jpg", nil];
   bannerSrl=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IS_IPHONEX?90:70, contentView.frame.size.width, SCREEN_HEIGHT/4)];
    bannerSrl.userInteractionEnabled=NO;
    bannerSrl.pagingEnabled=YES;
    [contentView addSubview:bannerSrl];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    for (int i=0; i<[bannerArray count]; i++) {
         bannerImg=[[UIImageView alloc]initWithFrame:CGRectMake((i*SCREEN_WIDTH), 0, bannerSrl.frame.size.width, bannerSrl.frame.size.height)];
        bannerImg.image=image([bannerArray objectAtIndex:i]);
        [bannerSrl addSubview:bannerImg];
    }
    
    [bannerSrl setContentSize:CGSizeMake((bannerArray.count * SCREEN_WIDTH), 140)];
    
    pageControl = [[UIPageControl alloc] init];
    [pageControl setFrame:CGRectMake(SCREEN_WIDTH/2-(bannerArray.count*6), CGRectGetMaxY(bannerSrl.frame)+5, bannerArray.count*13, 10)];
    pageControl.numberOfPages = bannerArray.count;
    pageControl.currentPageIndicatorTintColor=RGB(0, 89, 42);
    pageControl.pageIndicatorTintColor=Singlecolor(whiteColor);
    [self.view addSubview:pageControl];
    
    xslider=0;
    
    
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    footerView.backgroundColor=Singlecolor(whiteColor);
    [contentView addSubview:footerView];
    
    
    UIButton * trackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, footerView.frame.size.width/2.0, footerView.frame.size.height)];
    [footerView addSubview:trackBtn];
    
    UIImageView * trackImg=[[UIImageView alloc]initWithFrame:CGRectMake(trackBtn.frame.size.width/2-7, 7, 14, 20)];
    trackImg.image=image(@"track");
    [trackBtn addSubview:trackImg];
    
    
    UILabel * tracklbl=[[UILabel alloc]initWithFrame:CGRectMake(0, footerView.frame.size.height-21, trackBtn.frame.size.width, 21)];
    tracklbl.text=@"Track Order";
    tracklbl.font=RalewayRegular(appDelegate.font-7);
    tracklbl.textColor=Singlecolor(grayColor);
    tracklbl.textAlignment=NSTextAlignmentCenter;
    [trackBtn addSubview:tracklbl];
    
    
    UIView * dividerView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(trackBtn.frame), footerView.frame.size.height/2.0-5, 1, 10)];
    dividerView.backgroundColor=Singlecolor(lightGrayColor);
    [footerView addSubview:dividerView];
    
    
    UIButton * addvehicleBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(trackBtn.frame
                                                                                     )+2, 0, trackBtn.frame.size.width, trackBtn.frame.size.height)];
    [addvehicleBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addvehicleBtn];
    
    UIImageView * addImg=[[UIImageView alloc]initWithFrame:CGRectMake(addvehicleBtn.frame.size.width/2-10, 7, 20, 20)];
    addImg.image=image(@"addvechicle");
    [addvehicleBtn addSubview:addImg];
    
    UILabel * addLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, footerView.frame.size.height-21, addvehicleBtn.frame.size.width, 21)];
    addLbl.text=@"Add Vehicle";
    addLbl.font=RalewayRegular(appDelegate.font-7);
    addLbl.textColor=Singlecolor(grayColor);
    addLbl.textAlignment=NSTextAlignmentCenter;
    [addvehicleBtn addSubview:addLbl];
    
    
    
    onrdBtn=[[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(pageControl.frame)+10, contentView.frame.size.width/2.7, 30)];
    onrdBtn.backgroundColor=RGB(0, 88, 42);
    [onrdBtn setTitle:@"On Road Service" forState:UIControlStateNormal];
    onrdBtn.titleLabel.font=RalewayBold(appDelegate.font-2);
    [onrdBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
    onrdBtn.tag=0;
    [onrdBtn addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
    onrdBtn.layer.cornerRadius = 10;
    onrdBtn.layer.masksToBounds = YES;
    [contentView addSubview:onrdBtn];
    
    
    prebkBtn=[[UIButton alloc]initWithFrame:CGRectMake(contentView.frame.size.width-(onrdBtn.frame.size.width)-40, onrdBtn.frame.origin.y, onrdBtn.frame.size.width, onrdBtn.frame.size.height)];
    [prebkBtn setTitle:@"Pre Booking" forState:UIControlStateNormal];
    prebkBtn.titleLabel.font=RalewayBold(appDelegate.font-2);
    [prebkBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    prebkBtn.backgroundColor=[UIColor clearColor];
    prebkBtn.tag=1;
    [prebkBtn addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
    prebkBtn.layer.cornerRadius = 10;
    prebkBtn.layer.masksToBounds = YES;
    [contentView addSubview:prebkBtn];
    
    
    onrdScrl=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(prebkBtn.frame)+10, contentView.frame.size.width, contentView.frame.size.height/2.0)];
    onrdScrl.backgroundColor=Singlecolor(clearColor);
    [contentView addSubview:onrdScrl];
    
     prebookScrl=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(prebkBtn.frame)+10, contentView.frame.size.width, contentView.frame.size.height/2.0)];
    prebookScrl.backgroundColor=Singlecolor(clearColor);
    prebookScrl.hidden=YES;
    [contentView addSubview:prebookScrl];
    
    int x=40;
    int y=10;
    for (int i=0; i<2; i++) {
        
        UIButton * onrdouterBtn=[[UIButton alloc]initWithFrame:CGRectMake(x, y, onrdScrl.frame.size.width/3.2, onrdScrl.frame.size.width/4.0)];
        [onrdouterBtn setBackgroundImage:image(@"boxbg") forState:UIControlStateNormal];
        onrdouterBtn.tag=i;
        [onrdouterBtn addTarget:self action:@selector(onroadAction:) forControlEvents:UIControlEventTouchUpInside];
        [onrdScrl addSubview:onrdouterBtn];
        
        UIImageView * onrdserviceImg=[[UIImageView alloc]initWithFrame:CGRectMake(onrdouterBtn.frame.size.width/2.8, onrdouterBtn.frame.size.height/5.5, onrdouterBtn.frame.size.width/3.5, onrdouterBtn.frame.size.width/3.5)];
        if (i==0) {
          onrdserviceImg.image=image(@"1");
        }
        else
        {
            onrdserviceImg.image=image(@"2");
        }
        
        [onrdouterBtn addSubview:onrdserviceImg];
        
        UILabel * onrdserviceLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(onrdserviceImg.frame)+10, onrdouterBtn.frame.size.width-40, 21)];
        if (i==0) {
            onrdserviceLbl.text=@"Punture";
        }
        else
        {
            onrdserviceLbl.text=@"Repair Mechanic";
        }
        onrdserviceLbl.textAlignment=NSTextAlignmentCenter;
        onrdserviceLbl.font=RalewayRegular(appDelegate.font-5);
        onrdserviceLbl.textColor=RGB(0, 89, 45);
        [onrdouterBtn addSubview:onrdserviceLbl];
        onrdserviceLbl.lineBreakMode=NSLineBreakByWordWrapping;
        [onrdserviceLbl autoHeightOnly:0];
        onrdserviceLbl.numberOfLines=0;
        
        
        x+=onrdScrl.frame.size.width/3.2+70;
        if (i%2==1) {
            y+=onrdScrl.frame.size.width/4.0+10;
            x=40;
        }
    }
    onrdScrl.contentSize=CGSizeMake(SCREEN_WIDTH, y);
    
    int xpos=40;
    int ypos=10;
    for (int i=0; i<prebktextArray.count; i++) {
        
        UIButton * prebkouterBtn=[[UIButton alloc]initWithFrame:CGRectMake(xpos, ypos, prebookScrl.frame.size.width/3.2, prebookScrl.frame.size.width/4.0)];
        [prebkouterBtn setBackgroundImage:image(@"boxbg") forState:UIControlStateNormal];
        [prebookScrl addSubview:prebkouterBtn];
        
        UIImageView * prebkserviceImg=[[UIImageView alloc]initWithFrame:CGRectMake(prebkouterBtn.frame.size.width/2.8, prebkouterBtn.frame.size.height/5.5, prebkouterBtn.frame.size.width/3.5, prebkouterBtn.frame.size.width/3.5)];
        prebkserviceImg.image=image([prebkImgArray objectAtIndex:i]);
        [prebkouterBtn addSubview:prebkserviceImg];
        
        UILabel * prebkserviceLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(prebkserviceImg.frame)+10, prebkouterBtn.frame.size.width-40, 40)];
        prebkserviceLbl.text=[prebktextArray objectAtIndex:i];
        prebkserviceLbl.textAlignment=NSTextAlignmentCenter;
        prebkserviceLbl.font=RalewayRegular(appDelegate.font-5);
        prebkserviceLbl.textColor=RGB(0, 89, 45);
        [prebkouterBtn addSubview:prebkserviceLbl];
        prebkserviceLbl.backgroundColor=Singlecolor(clearColor);
        prebkserviceLbl.numberOfLines=0;
        prebkserviceLbl.lineBreakMode=NSLineBreakByWordWrapping;
        [prebkserviceLbl autoHeightOnly:0];
        
        
        xpos+=prebookScrl.frame.size.width/3.2+70;
        if (i%2==1) {
            ypos+=prebookScrl.frame.size.width/4.0+10;
            xpos=40;
        }
    }
    prebookScrl.contentSize=CGSizeMake(SCREEN_WIDTH, ypos);
}
- (void)onroadAction:(id)sender
{
    if ([sender tag]==0) {
        PuntureViewController * punture=[[PuntureViewController alloc]init];
        [self.navigationController pushViewController:punture animated:YES];
    }
    else
    {
        
    }
}

- (void)serviceAction:(id)sender
{
    if ([sender tag]==0) {
        onrdBtn.backgroundColor=RGB(0, 89, 42);
        [onrdBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
        prebkBtn.backgroundColor=Singlecolor(clearColor);
        [prebkBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
        onrdScrl.hidden=NO;
        prebookScrl.hidden=YES;
    }
    else
    {
        onrdBtn.backgroundColor=Singlecolor(clearColor);
        [onrdBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
        prebkBtn.backgroundColor=RGB(0, 89, 42);
        [prebkBtn setTitleColor:Singlecolor(whiteColor) forState:UIControlStateNormal];
        onrdScrl.hidden=YES;
        prebookScrl.hidden=NO;
    }
}

- (void)timerAction
{
    if(jslider < bannerArray.count-1)
    {
         xslider += SCREEN_WIDTH;
        bannerSrl.contentOffset = CGPointMake(xslider, 0);
        jslider++;
    }
    else
    {
        xslider=0;
        jslider=0;
        [bannerSrl setContentOffset:CGPointMake(0, 0)];
    }
   pageControl.currentPage=jslider;
}


- (void)puntureAction
{
    PuntureViewController * punture=[[PuntureViewController alloc]init];
    [self.navigationController pushViewController:punture animated:YES];
}

- (void)addAction
{
    AddvechicleViewController * addvechicle=[[AddvechicleViewController alloc]init];
    [self.navigationController pushViewController:addvechicle animated:YES];
}
@end
