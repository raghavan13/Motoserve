//
//  Confirmview.m
//  Motoserve
//
//  Created by Shyam on 31/03/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "Confirmview.h"
#import "CPMetaFile.h"

@implementation Confirmview
{
    MKMapView *pickupMapview;
}
- (id)initWithFrame:(CGRect)frame delegate:(id<OutletDelegate>)delegate
{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.OutletDelegate = delegate;
    }
    return self;
}

-(void)HidePopup:(UITapGestureRecognizer *)gesture{
    
    [Utils RemoveBounceAnimationBtn:pickupView superView:self];
}

- (void)CreateOutletView:(NSArray*)selectedPatner{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int height = IS_IPHONEX?150:80;
    appDelegate.selecteddic= selectedPatner;
    pickupView=[[UIView alloc]initWithFrame:CGRectMake(10,(self.frame.size.height/2-(self.frame.size.height-height)/2.2), self.frame.size.width-20, self.frame.size.height-height)];
    pickupView.backgroundColor=Singlecolor(whiteColor);
    pickupView.layer.borderWidth=1.0;
    pickupView.layer.borderColor=RGB(0, 89, 42).CGColor;
    [self addSubview:pickupView];
    
    
//    UIView *pickupView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, pickupView.frame.size.width-20, pickupView.frame.size.height/4)];
//    pickupView.backgroundColor=Singlecolor(whiteColor);
//    [pickupView addSubview:pickupView];
    
    
    UIButton *CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.frame = CGRectMake(pickupView.frame.size.width-(pickupView.frame.size.width/6),10,pickupView.frame.size.width/6,pickupView.frame.size.height/11);
    CloseBtn.backgroundColor=Singlecolor(clearColor);
    //    [CloseBtn addTarget:self action:@selector(CloseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [pickupView addSubview:CloseBtn];
    
    UIImageView *closeImg=[[UIImageView alloc]init];
    closeImg.image=image(@"white_close");
    [CloseBtn addSubview:closeImg];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseBtnAction)];
    [CloseBtn addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    NSString *TitleStr;
    TitleStr=@"DETAILS";
    
    
    UILabel *pickpLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 50,  pickupView.frame.size.width-60, 21)];
    pickpLbl.textAlignment=NSTextAlignmentCenter;
    pickpLbl.backgroundColor=Singlecolor(clearColor);
    pickpLbl.textColor=Singlecolor(blackColor);
    pickpLbl.text=TitleStr;
    
    [pickupView addSubview:pickpLbl];
    
    
    if([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE6PLUS] || [appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONEX])
    {
        closeImg.frame=CGRectMake(CloseBtn.frame.size.width-(47/2.5), CloseBtn.frame.size.height/(47/2)/2, 47/2.5, 47/2.5);
    }
    else if([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE6])
    {
        closeImg.frame=CGRectMake(CloseBtn.frame.size.width-(47/3)-10, CloseBtn.frame.size.height/3-(47/3)/2, 47/3, 47/3);
    }
    else if([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE5])
    {
        closeImg.frame=CGRectMake(CloseBtn.frame.size.width-(47/3.5)-10, CloseBtn.frame.size.height/3-(47/3.5)/2, 47/3.5, 47/3.5);
    }
    else if([appDelegate.deviceType isEqualToString:DEVICE_TYPE_IPHONE4])
    {
        closeImg.frame=CGRectMake(CloseBtn.frame.size.width-(47/3.8)-10, CloseBtn.frame.size.height/3-(47/3.8)/2, 47/3.5, 47/3.8);
    }
    
    [Utils ShowBounceAnimationBtn:pickupView];
    
    
    UILabel * typeLbl=[[UILabel alloc]init];
    [pickupView addSubview:typeLbl];
    typeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typeLbl.topAnchor constraintEqualToAnchor:pickpLbl.bottomAnchor constant:20].active=YES;
    [typeLbl.leftAnchor constraintEqualToAnchor:pickupView.leftAnchor constant:20].active=YES;
    [typeLbl.widthAnchor constraintEqualToAnchor:pickupView.widthAnchor multiplier:0.5].active=YES;
    typeLbl.text=@"Shop Name";
    typeLbl.font=RalewayRegular(appDelegate.font-4);
    typeLbl.textColor=Singlecolor(blackColor);
    typeLbl.numberOfLines=2;
    
    
    
    UILabel * typevalLbl=[[UILabel alloc]init];
    [pickupView addSubview:typevalLbl];
    typevalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typevalLbl.topAnchor constraintEqualToAnchor:typeLbl.topAnchor constant:0].active=YES;
    [typevalLbl.leftAnchor constraintEqualToAnchor:typeLbl.rightAnchor constant:5].active=YES;
    [typevalLbl.rightAnchor constraintEqualToAnchor:pickupView.rightAnchor constant:-20].active=YES;
    [typevalLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    if ([Utils isCheckNotNULL:[selectedPatner valueForKey:@"shopName"]]) {
        typevalLbl.text=[selectedPatner valueForKey:@"shopName"];
    }
    
    typevalLbl.font=RalewayRegular(appDelegate.font-4);
    typevalLbl.numberOfLines=0;
    [typevalLbl autoHeight:10];
    typevalLbl.textColor=Singlecolor(blackColor);
    
    
    UILabel * contactLbl=[[UILabel alloc]init];
    [pickupView addSubview:contactLbl];
    contactLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [contactLbl.topAnchor constraintEqualToAnchor:typevalLbl.bottomAnchor constant:20].active=YES;
    [contactLbl.leftAnchor constraintEqualToAnchor:typeLbl.leftAnchor constant:0].active=YES;
    [contactLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    contactLbl.text=@"Shop Address";
    contactLbl.font=RalewayRegular(appDelegate.font-4);
    contactLbl.textColor=Singlecolor(blackColor);
    
    
    
    UILabel * contactvalLbl=[[UILabel alloc]init];
    [pickupView addSubview:contactvalLbl];
    contactvalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [contactvalLbl.topAnchor constraintEqualToAnchor:contactLbl.topAnchor constant:0].active=YES;
    [contactvalLbl.leftAnchor constraintEqualToAnchor:typevalLbl.leftAnchor constant:0].active=YES;
    [contactvalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[selectedPatner valueForKey:@"currentLocation"]]) {
        contactvalLbl.text=[selectedPatner valueForKey:@"currentLocation"];
    }
    contactvalLbl.numberOfLines=0;
    [contactvalLbl autoHeight:10];
    contactvalLbl.font=RalewayRegular(appDelegate.font-4);
    contactvalLbl.textColor=Singlecolor(blackColor);
    
    
    UILabel * bookdtLbl=[[UILabel alloc]init];
    [pickupView addSubview:bookdtLbl];
    bookdtLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [bookdtLbl.topAnchor constraintEqualToAnchor:contactvalLbl.bottomAnchor constant:20].active=YES;
    [bookdtLbl.leftAnchor constraintEqualToAnchor:typeLbl.leftAnchor constant:0].active=YES;
    [bookdtLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    bookdtLbl.text=@"Booking Date";
    bookdtLbl.font=RalewayRegular(appDelegate.font-4);
    bookdtLbl.textColor=Singlecolor(blackColor);
    
    
    
    UILabel * bookdtvalLbl=[[UILabel alloc]init];
    [pickupView addSubview:bookdtvalLbl];
    bookdtvalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [bookdtvalLbl.topAnchor constraintEqualToAnchor:bookdtLbl.topAnchor constant:0].active=YES;
    [bookdtvalLbl.leftAnchor constraintEqualToAnchor:typevalLbl.leftAnchor constant:0].active=YES;
    [bookdtvalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[appDelegate.selectionvalue valueForKey:@"date"]]) {
        bookdtvalLbl.text=[appDelegate.selectionvalue valueForKey:@"date"];
    }
    
    bookdtvalLbl.font=RalewayRegular(appDelegate.font-4);
    bookdtvalLbl.textColor=Singlecolor(blackColor);
    
    
    UILabel * booktimeLbl=[[UILabel alloc]init];
    [pickupView addSubview:booktimeLbl];
    booktimeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [booktimeLbl.topAnchor constraintEqualToAnchor:bookdtvalLbl.bottomAnchor constant:20].active=YES;
    [booktimeLbl.leftAnchor constraintEqualToAnchor:typeLbl.leftAnchor constant:0].active=YES;
   [booktimeLbl.widthAnchor constraintEqualToAnchor:typeLbl.widthAnchor constant:0].active=YES;
    booktimeLbl.text=@"Booking Time";
    booktimeLbl.font=RalewayRegular(appDelegate.font-4);
    booktimeLbl.textColor=Singlecolor(blackColor);
    booktimeLbl.numberOfLines=2;
    
    
    
    UILabel * booktimevalLbl=[[UILabel alloc]init];
    [pickupView addSubview:booktimevalLbl];
    booktimevalLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [booktimevalLbl.topAnchor constraintEqualToAnchor:booktimeLbl.topAnchor constant:0].active=YES;
    [booktimevalLbl.leftAnchor constraintEqualToAnchor:typevalLbl.leftAnchor constant:0].active=YES;
    [booktimevalLbl.widthAnchor constraintEqualToAnchor:typevalLbl.widthAnchor constant:0].active=YES;
    if ([Utils isCheckNotNULL:[appDelegate.selectionvalue valueForKey:@"time"]]) {
        booktimevalLbl.text=[appDelegate.selectionvalue valueForKey:@"time"];
    }
    booktimevalLbl.numberOfLines=0;
    [booktimevalLbl autoHeight:10];
    booktimevalLbl.font=RalewayRegular(appDelegate.font-4);
    booktimevalLbl.textColor=Singlecolor(blackColor);
    
    UIButton *  submitBtn=[[UIButton alloc]init];
    [pickupView addSubview:submitBtn];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn.centerXAnchor constraintEqualToAnchor:pickupView.centerXAnchor constant:0].active=YES;
    [submitBtn.topAnchor constraintEqualToAnchor:booktimevalLbl.bottomAnchor constant:40].active=YES;
    [submitBtn.widthAnchor constraintEqualToConstant:150].active=YES;
    [submitBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Confirm Booking" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)submitAction
{
    appDelegate.fromschedule=NO;
    [Utils RemoveBounceAnimationBtn:pickupView superView:self];
    
    if ([self.OutletDelegate respondsToSelector:@selector(afterconfirm)]) {
        [self.OutletDelegate afterconfirm];
    }
}

-(void)CloseBtnAction{
    
    [Utils RemoveBounceAnimationBtn:pickupView superView:self];
    
    if ([self.OutletDelegate respondsToSelector:@selector(ClosePickupSelection)]) {
        [self.OutletDelegate ClosePickupSelection];
    }
}
-(void)CloseAction
{
    [Utils RemoveBounceAnimationBtn:pickupView superView:self];
}
@end
