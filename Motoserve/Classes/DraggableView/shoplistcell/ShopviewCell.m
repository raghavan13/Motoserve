//
//  ShopviewCell.m
//  Motoserve
//
//  Created by Karthik Baskaran on 25/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "ShopviewCell.h"
#import "Utils.h"
#import "AppDelegate.h"

#define kLabelAllowance 16.0f
#define kStarViewHeight 20.0f
#define kStarViewWidth 150.0f
#define kLeftPadding 5.0f

@implementation ShopviewCell
{
    AppDelegate *appDelegate;
    UIView  * MainView;
    UIImageView * carImg;
    UILabel * noLbl,* servicecenterLbl;
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

- (void)createDesign
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MainView=[[UIView alloc]init];
    [self.contentView addSubview:MainView];
    MainView.translatesAutoresizingMaskIntoConstraints = NO;
    [MainView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active=YES;
    [MainView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active=YES;
    [MainView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active=YES;
    [MainView.heightAnchor constraintEqualToConstant:110].active=YES;
    MainView.backgroundColor=Singlecolor(clearColor);
    MainView.layer.borderColor = [UIColor clearColor].CGColor;
    MainView.layer.borderWidth = 1.0f;
    MainView.layer.cornerRadius = 8;
    MainView.layer.masksToBounds = true;
    
    
    UIButton * bgBtn=[[UIButton alloc]init];
    [MainView addSubview:bgBtn];
    bgBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [bgBtn.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:0].active=YES;
    [bgBtn.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:0].active=YES;
    [bgBtn.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:0].active=YES;
    [bgBtn.heightAnchor constraintEqualToAnchor:MainView.heightAnchor constant:0].active=YES;
    [bgBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
    bgBtn.userInteractionEnabled=NO;
    
    carImg=[[UIImageView alloc]init];
    [MainView addSubview:carImg];
    carImg.translatesAutoresizingMaskIntoConstraints = NO;
    [carImg.centerYAnchor constraintEqualToAnchor:MainView.centerYAnchor constant:5].active=YES;
    [carImg.leftAnchor constraintEqualToAnchor:MainView.leftAnchor constant:20].active=YES;
    [carImg.widthAnchor constraintEqualToConstant:60].active=YES;
    [carImg.heightAnchor constraintEqualToConstant:30].active=YES;
    carImg.image=image(@"order_car");
    
    
    UIView * imgdiv=[[UIView alloc]init];
    [MainView addSubview:imgdiv];
    imgdiv.translatesAutoresizingMaskIntoConstraints = NO;
    [imgdiv.topAnchor constraintEqualToAnchor:MainView.topAnchor constant:20].active=YES;
    [imgdiv.leftAnchor constraintEqualToAnchor:carImg.rightAnchor constant:5].active=YES;
    [imgdiv.widthAnchor constraintEqualToConstant:1].active=YES;
    [imgdiv.bottomAnchor constraintEqualToAnchor:MainView.bottomAnchor constant:-20].active=YES;
    imgdiv.backgroundColor=Singlecolor(lightGrayColor);
    
    
    noLbl=[[UILabel alloc]init];
    [MainView addSubview:noLbl];
    noLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [noLbl.topAnchor constraintEqualToAnchor:imgdiv.topAnchor constant:5].active=YES;
    [noLbl.leftAnchor constraintEqualToAnchor:imgdiv.leftAnchor constant:10].active=YES;
    [noLbl.rightAnchor constraintEqualToAnchor:MainView.rightAnchor constant:-10].active=YES;
    [noLbl.heightAnchor constraintEqualToConstant:21].active=YES;
    noLbl.textColor=Singlecolor(blackColor);
    noLbl.textAlignment=NSTextAlignmentLeft;
    noLbl.font=RalewayBold(appDelegate.font-5);
    
    
    UILabel * typeLbl=[[UILabel alloc]init];
    [MainView addSubview:typeLbl];
    typeLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [typeLbl.topAnchor constraintEqualToAnchor:noLbl.bottomAnchor constant:0].active=YES;
    [typeLbl.leftAnchor constraintEqualToAnchor:noLbl.leftAnchor constant:0].active=YES;
    //[typeLbl.rightAnchor constraintEqualToAnchor:noLbl.rightAnchor constant:0].active=YES;
    [typeLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    typeLbl.text=@"Rating :";
    typeLbl.textAlignment=NSTextAlignmentLeft;
    typeLbl.textColor=Singlecolor(blackColor);
    typeLbl.font=RalewayRegular(appDelegate.font-5);
    
    
//    StarRatingView* starviewAnimated = [[StarRatingView alloc]init];
//    [starviewAnimated.topAnchor constraintEqualToAnchor:noLbl.bottomAnchor constant:5].active=YES;
//    [starviewAnimated.leftAnchor constraintEqualToAnchor:typeLbl.rightAnchor constant:0].active=YES;
//    [starviewAnimated.widthAnchor constraintEqualToConstant:kStarViewWidth+kLabelAllowance+kLeftPadding].active=YES;
//    [starviewAnimated.heightAnchor constraintEqualToConstant:kStarViewHeight].active=YES;
//    //[starviewAnimated setFrame:CGRectMake(92, 72, kStarViewWidth+kLabelAllowance+kLeftPadding, kStarViewHeight) andRating:2 withLabel:YES animated:YES];
//    [MainView addSubview:starviewAnimated];
    
    UIImageView *  estdistImg=[[UIImageView alloc]init];
    [MainView addSubview:estdistImg];
    estdistImg.translatesAutoresizingMaskIntoConstraints = NO;
    [estdistImg.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:10].active=YES;
    [estdistImg.leftAnchor constraintEqualToAnchor:noLbl.leftAnchor constant:0].active=YES;
    [estdistImg.widthAnchor constraintEqualToConstant:15].active=YES;
    [estdistImg.heightAnchor constraintEqualToConstant:13].active=YES;
    estdistImg.image=image(@"est_distance");
    
    
   
    
    servicecenterLbl=[[UILabel alloc]init];
    [MainView addSubview:servicecenterLbl];
    servicecenterLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [servicecenterLbl.topAnchor constraintEqualToAnchor:typeLbl.bottomAnchor constant:5].active=YES;
    [servicecenterLbl.leftAnchor constraintEqualToAnchor:estdistImg.rightAnchor constant:5].active=YES;
    [servicecenterLbl.rightAnchor constraintEqualToAnchor:noLbl.rightAnchor constant:0].active=YES;
    [servicecenterLbl.heightAnchor constraintEqualToAnchor:noLbl.heightAnchor constant:0].active=YES;
    servicecenterLbl.textAlignment=NSTextAlignmentLeft;
    servicecenterLbl.textColor=Singlecolor(grayColor);
    servicecenterLbl.font=RalewayRegular(appDelegate.font-5);
}



- (void)value:(NSArray*)values
{
    if ([Utils isCheckNotNULL:[values valueForKey:@"vehicleType"]]) {
        if ([[values valueForKey:@"vehicleType"]isEqualToString:@"T"]) {
            carImg.image=image(@"order_bike");
        }
    }
    if ([Utils isCheckNotNULL:[values valueForKey:@"shopName"]]) {
        noLbl.text=[values valueForKey:@"shopName"];
    }
    if ([Utils isCheckNotNULL:[[values valueForKey:@"location"]valueForKey:@"coordinates"]]) {
        
        NSString * startlon=[appDelegate.latArray objectAtIndex:0];
        NSString * startlat=[appDelegate.latArray objectAtIndex:1];
        
        NSArray * locaArray=[[values valueForKey:@"location"]valueForKey:@"coordinates"];
        NSString * endlonStr=[locaArray objectAtIndex:0];
        NSString * endlatStr=[locaArray objectAtIndex:1];
        
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:[startlat doubleValue] longitude:[startlon doubleValue]];
        
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:[endlatStr doubleValue]  longitude:[endlonStr doubleValue]];
        
        CLLocationDistance distance = [loc1 distanceFromLocation:loc2];

        float totalDistance =0.0;
        totalDistance = totalDistance + (distance / 1000);

        NSLog(@"totalDistance: %@",[NSString stringWithFormat:@"%.2f KM", totalDistance]);
        servicecenterLbl.text=[NSString stringWithFormat:@"%.2f KM", totalDistance];
    }
    
}
@end
