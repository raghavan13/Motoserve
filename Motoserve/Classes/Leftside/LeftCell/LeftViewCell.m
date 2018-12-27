//
//  LeftViewCell.m
//  Spize
//
//  Created by Karthik Baskaran on 27/03/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "LeftViewCell.h"
#import "Utils.h"
#import "AppDelegate.h"
@implementation LeftViewCell
{
    AppDelegate *appDelegate;
    UIView  * redclrView,* MainView;
    UILabel * countLbl;
}
@synthesize Img,Lbl;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self sidemenuDesign];
    }
    return self;
}

-(void)sidemenuDesign{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
     MainView=[[UIView alloc]init];
    MainView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
    MainView.backgroundColor=Singlecolor(clearColor);
    [self.contentView addSubview:MainView];
    
    
    Img=[[UIImageView alloc]init];
    Img.frame=CGRectMake(15, 5, 22, 22);
    [MainView addSubview:Img];
    
    Lbl=[[UILabel alloc]init];
    Lbl.frame=CGRectMake(MainView.frame.size.width/2.5, 0, MainView.frame.size.width, 21);
    Lbl.textColor=Singlecolor(whiteColor);
    [MainView addSubview:Lbl];
    
}

@end
