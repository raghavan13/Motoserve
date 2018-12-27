//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOLeftMenuViewController.h"
#import "HomeViewController.h"
#import "Constants.h"
#import "CPMetaFile.h"


@interface DEMOLeftMenuViewController ()
{
    NSArray *titles,*images,*abttitles;
    UILabel * logoutLbl,* nameLbl;
    NSDictionary *  token;
    UITableView *tableView;
    UIView * footerView;
}
@end

@implementation DEMOLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableView = ({
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IS_IPHONEX?140:80, self.view.frame.size.width, IS_IPHONEX?self.view.frame.size.height-280:self.view.frame.size.height-160) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.tag=1000;
        tableView;
    });
    
    titles = @[@"Logout"];
    images = @[@"Home"];
    
//    footerView=[[UIView alloc]init];
//    footerView.frame=CGRectMake(0, CGRectGetMaxY(tableView.frame)+10, self.view.frame.size.width, 80);
//    footerView.backgroundColor=Singlecolor(clearColor);
//    [self.view addSubview:footerView];
//
//
//    UIImageView * logoutImg=[[UIImageView alloc]init];
//    logoutImg.frame=CGRectMake(15, 25, 25, 18);
//    logoutImg.image=[UIImage imageNamed:@"Logout"];
//    [footerView addSubview:logoutImg];
//
//    logoutLbl=[[UILabel alloc]init];
//    logoutLbl.frame=CGRectMake(CGRectGetMaxX(logoutImg.frame)+15, -6, footerView.frame.size.width, footerView.frame.size.height);
//    logoutLbl.text=@"Login";
//    [footerView addSubview:logoutLbl];
//
//    UIButton * logoutBtn=[[UIButton alloc]init];
//    logoutBtn.frame=CGRectMake(0, 10, footerView.frame.size.width, 30);
//    [logoutBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:logoutBtn];
//
//
//    nameLbl=[[UILabel alloc]init];
//    nameLbl.frame=CGRectMake(logoutLbl.frame.origin.x, CGRectGetMaxY(logoutBtn.frame), footerView.frame.size.width-100, 21);
//    nameLbl.textColor=RGB(146, 146, 146);
//    [footerView addSubview:nameLbl];
    
    
    
    [self.view addSubview:tableView];
    
    tableView.hidden=NO;
    //footerView.hidden=NO;
    
}
- (void)viewWillAppear:(BOOL)animated
{
//    token= [Utils NSKeyedUnarchiver:@"logindetails"];
//    if ([Utils isCheckNotNULL:token])
//    {
//
//        NSString * nameStr=[[NSString stringWithFormat:@"%@ %@",[token valueForKey:@"customer_first_name"],[token valueForKey:@"customer_last_name"]]capitalizedString];
//        nameLbl.text=[NSString stringWithFormat:@"Signed as %@",nameStr];
//        logoutLbl.text=@"Logout";
//    }
//    else
//    {
//        nameLbl.text=@"";
//        logoutLbl.text=@"Login";
//    }
//
//
//    [tableView reloadData];
}
//- (void)loginAction
//{
//    if ([logoutLbl.text isEqualToString:@"Logout"]) {
//        appDelegate.login=NO;
//        [Utils removeSavedStringData:@"logindetails"];
//        [Utils removeSavedStringData:@"cartcount"];
//        [Utils removeSavedStringData:@"productlist"];
//        [Utils removeSavedStringData:@"cartsavedid"];
//        [Utils removeSavedStringData:@"FBImage"];
//        [Utils removeSavedStringData:@"promodetails"];
//        appDelegate.cartcount=@"0";
//        appDelegate.ordercount=@"0";
//        appDelegate.promotioncount=@"0";
//        appDelegate.notificationcount=@"0";
//        appDelegate.discountApply=NO;
//        appDelegate.redeemApply=NO;
//        [Utils showErrorAlert:@"Successfully Logout" delegate:nil];
//    }
//    else
//    {
//        appDelegate.login=YES;
//    }
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]
//                                                 animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
//}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            [Utils removeSavedStringData:@"logindetails"];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [titles count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    
    LeftViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[LeftViewCell alloc] init];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=Singlecolor(clearColor);
        
        cell.Lbl.text=titles[indexPath.row];
        //cell.Img.image = [UIImage imageNamed:images[indexPath.row]];
    }
    return cell;
}
@end
