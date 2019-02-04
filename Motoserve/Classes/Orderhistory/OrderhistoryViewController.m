//
//  OrderhistoryViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 07/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "OrderhistoryViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface OrderhistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *navHeader,* div1View,* div2View;
    AppDelegate * appDelegate;
    UIButton * prebkBtn,* onrdBtn;
}
@end

@implementation OrderhistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Order History" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    
    [self createDesign];
    [self GetBookinglist];
}

- (void)createDesign
{
    onrdBtn=[[UIButton alloc]init];
    [self.view addSubview:onrdBtn];
    onrdBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [onrdBtn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?90:70].active=YES;
    [onrdBtn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active=YES;
    [onrdBtn.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2.0].active=YES;
    [onrdBtn.heightAnchor constraintEqualToConstant:30].active=YES;
    [onrdBtn setTitle:@"On Road" forState:UIControlStateNormal];
    [onrdBtn setTitleColor:RGB(0, 89, 42) forState:UIControlStateNormal];
    onrdBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    onrdBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    onrdBtn.tag=1;
    [onrdBtn addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    prebkBtn=[[UIButton alloc]init];
    [self.view addSubview:prebkBtn];
    prebkBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [prebkBtn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:IS_IPHONEX?90:70].active=YES;
    [prebkBtn.leftAnchor constraintEqualToAnchor:onrdBtn.rightAnchor constant:0].active=YES;
    [prebkBtn.widthAnchor constraintEqualToAnchor:onrdBtn.widthAnchor constant:0].active=YES;
    [prebkBtn.heightAnchor constraintEqualToAnchor:onrdBtn.heightAnchor constant:0].active=YES;
    [prebkBtn setTitle:@"Pre Booking" forState:UIControlStateNormal];
    [prebkBtn setTitleColor:Singlecolor(lightGrayColor) forState:UIControlStateNormal];
    prebkBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    prebkBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    prebkBtn.tag=2;
    [prebkBtn addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * divView=[[UIView alloc]init];
    [self.view addSubview:divView];
    divView.translatesAutoresizingMaskIntoConstraints = NO;
    [divView.topAnchor constraintEqualToAnchor:prebkBtn.bottomAnchor constant:0].active=YES;
    [divView.leftAnchor constraintEqualToAnchor:self.view .leftAnchor constant:0].active=YES;
    [divView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [divView.heightAnchor constraintEqualToConstant:2].active=YES;
    divView.backgroundColor=Singlecolor(lightGrayColor);
    
    
    div1View=[[UIView alloc]init];
    [divView addSubview:div1View];
    div1View.translatesAutoresizingMaskIntoConstraints = NO;
    [div1View.topAnchor constraintEqualToAnchor:divView.topAnchor constant:0].active=YES;
    [div1View.leftAnchor constraintEqualToAnchor:divView .leftAnchor constant:0].active=YES;
    [div1View.widthAnchor constraintEqualToConstant:SCREEN_WIDTH/2.0].active=YES;
    [div1View.heightAnchor constraintEqualToAnchor:divView.heightAnchor constant:0].active=YES;
    div1View.backgroundColor=RGB(0, 89, 42);
    
    
    div2View=[[UIView alloc]init];
    [divView addSubview:div2View];
    div2View.translatesAutoresizingMaskIntoConstraints = NO;
    [div2View.topAnchor constraintEqualToAnchor:divView.topAnchor constant:0].active=YES;
    [div2View.leftAnchor constraintEqualToAnchor:div1View .rightAnchor constant:0].active=YES;
    [div2View.widthAnchor constraintEqualToAnchor:div1View.widthAnchor constant:0].active=YES;
    [div2View.heightAnchor constraintEqualToAnchor:divView.heightAnchor constant:0].active=YES;
    div2View.backgroundColor=RGB(0, 89, 42);
    div2View.hidden=YES;
    
    UITableView * orderTbl=[[UITableView alloc]init];
    [self.view addSubview:orderTbl];
    orderTbl.translatesAutoresizingMaskIntoConstraints = NO;
    [orderTbl.topAnchor constraintEqualToAnchor:divView.bottomAnchor constant:10].active=YES;
    [orderTbl.leftAnchor constraintEqualToAnchor:self.view .leftAnchor constant:0].active=YES;
    [orderTbl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [orderTbl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
    //orderTbl.backgroundColor=Singlecolor(redColor);
    orderTbl.delegate=self;
    orderTbl.dataSource=self;
}

- (void)orderAction:(id)sender
{
    if ([sender tag]==1) {
        [onrdBtn setTitleColor:RGB(0, 89, 42) forState:UIControlStateNormal];
        [prebkBtn setTitleColor:Singlecolor(lightGrayColor) forState:UIControlStateNormal];
        div1View.hidden=NO;
        div2View.hidden=YES;
        
    }
    else
    {
        [prebkBtn setTitleColor:RGB(0, 89, 42) forState:UIControlStateNormal];
        [onrdBtn setTitleColor:Singlecolor(lightGrayColor)forState:UIControlStateNormal];
        div1View.hidden=YES;
        div2View.hidden=NO;
    }
}
- (void)backAction
{
    constraintViewController *foodType=[[constraintViewController alloc]init];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:foodType] animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    
    OrderViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[OrderViewCell alloc] init];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (void)GetBookinglist
{
    [appDelegate startProgressView:self.view];
    NSString *url =[UrlGenerator PostBookinglist];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
    NSDictionary * dic = @{
                           @"userId":[login valueForKey:@"_id"]
                           };
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         //[Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
         }
         else
         {
             NSLog(@"1");
             
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
    
}
@end
