//
//  HomeCollectionViewCell.m
//  Motoserve
//
//  Created by Karthik Baskaran on 03/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell
@synthesize  onrdserviceImg,onrdserviceLbl,serviceBtn;
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        serviceBtn=[[UIButton alloc]init];
        [serviceBtn setBackgroundImage:image(@"boxbg") forState:UIControlStateNormal];
        [self addSubview:serviceBtn];
        serviceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [serviceBtn.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active=YES;
        [serviceBtn.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active=YES;
        [serviceBtn.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active=YES;
        [serviceBtn.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active=YES;
        
        onrdserviceImg=[[UIImageView alloc]init];
        [serviceBtn addSubview:onrdserviceImg];
        onrdserviceImg.translatesAutoresizingMaskIntoConstraints = NO;
        [onrdserviceImg.centerXAnchor constraintEqualToAnchor:serviceBtn.centerXAnchor constant:0].active=YES;
        [onrdserviceImg.centerYAnchor constraintEqualToAnchor:serviceBtn.centerYAnchor constant:-10].active=YES;
        [onrdserviceImg.widthAnchor constraintEqualToConstant:self.frame.size.width/3.5].active=YES;
        [onrdserviceImg.heightAnchor constraintEqualToConstant:self.frame.size.width/3.5].active=YES;
        onrdserviceImg.image=image(@"1");
        
        onrdserviceLbl=[[UILabel alloc]init];
        [serviceBtn addSubview:onrdserviceLbl];
        onrdserviceLbl.translatesAutoresizingMaskIntoConstraints = NO;
        [onrdserviceLbl.topAnchor constraintEqualToAnchor:onrdserviceImg.bottomAnchor constant:10].active=YES;
        [onrdserviceLbl.leftAnchor constraintEqualToAnchor:serviceBtn.leftAnchor constant:20].active=YES;
        [onrdserviceLbl.rightAnchor constraintEqualToAnchor:serviceBtn.rightAnchor constant:-20].active=YES;
        onrdserviceLbl.textAlignment=NSTextAlignmentCenter;
        onrdserviceLbl.font=RalewayRegular(appdelegate.font-5);
        onrdserviceLbl.textColor=RGB(0, 89, 45);
        onrdserviceLbl.numberOfLines=0;
    }
    return self;
}



@end
