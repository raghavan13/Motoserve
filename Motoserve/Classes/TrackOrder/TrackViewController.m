//
//  TrackViewController.m
//  Motoserve
//
//  Created by Shyam on 07/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import "TrackViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface TrackViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *navHeader,* div1View,* div2View;
    AppDelegate * appDelegate;
    UIButton * prebkBtn,* onrdBtn;
    NSMutableArray * onrdtracklistArray,*prebooktracklistArray;
    UITableView * orderTbl;
    UILabel * noDataLabel;
    BOOL onrdcheck;
}
@end

@implementation TrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor =Singlecolor(whiteColor);
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:self.view HeaderTitle:@"Track Order" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    onrdcheck=YES;
    [self GetBookinglist];
    [self createDesign];
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
    
    orderTbl=[[UITableView alloc]init];
    [self.view addSubview:orderTbl];
    orderTbl.translatesAutoresizingMaskIntoConstraints = NO;
    [orderTbl.topAnchor constraintEqualToAnchor:divView.bottomAnchor constant:10].active=YES;
    [orderTbl.leftAnchor constraintEqualToAnchor:self.view .leftAnchor constant:0].active=YES;
    [orderTbl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active=YES;
    [orderTbl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active=YES;
    //orderTbl.backgroundColor=Singlecolor(redColor);
    orderTbl.delegate=self;
    orderTbl.dataSource=self;
    orderTbl.hidden=YES;
    
    noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, orderTbl.bounds.size.width, orderTbl.bounds.size.height)];
    noDataLabel.text             = @"No Orders Found";
    noDataLabel.textColor        = [UIColor blackColor];
    noDataLabel.textAlignment    = NSTextAlignmentCenter;
    noDataLabel.textColor=[UIColor grayColor];
    noDataLabel.font=RalewayRegular(appDelegate.font-4);
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.backgroundColor=[UIColor clearColor];
    orderTbl.backgroundView = noDataLabel;
    orderTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [noDataLabel setHidden:YES];
}
- (void)orderAction:(id)sender
{
    if ([sender tag]==1) {
        onrdcheck=YES;
        [onrdBtn setTitleColor:RGB(0, 89, 42) forState:UIControlStateNormal];
        [prebkBtn setTitleColor:Singlecolor(lightGrayColor) forState:UIControlStateNormal];
        div1View.hidden=NO;
        div2View.hidden=YES;
        if ([Utils isCheckNotNULL:self->onrdtracklistArray]) {
            self->noDataLabel.hidden=YES;
        }
        else
        {
            self->noDataLabel.hidden=NO;
        }
    }
    else
    {
        [prebkBtn setTitleColor:RGB(0, 89, 42) forState:UIControlStateNormal];
        [onrdBtn setTitleColor:Singlecolor(lightGrayColor)forState:UIControlStateNormal];
        div1View.hidden=YES;
        div2View.hidden=NO;
        onrdcheck=NO;
        if ([Utils isCheckNotNULL:self->prebooktracklistArray]) {
            self->noDataLabel.hidden=YES;
        }
        else
        {
            self->noDataLabel.hidden=NO;
        }
    }
    [orderTbl reloadData];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (onrdcheck) {
        return [onrdtracklistArray count];
    }
    else
    {
       return [prebooktracklistArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    
    TrackViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[TrackViewCell alloc] init];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (onrdcheck) {
        [cell settext:[onrdtracklistArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell settext:[prebooktracklistArray objectAtIndex:indexPath.row]];
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
             self->onrdtracklistArray=[[NSMutableArray alloc]init];
             self->prebooktracklistArray=[[NSMutableArray alloc]init];
             for (int i=0; i<[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] count]; i++) {
                 int trackno=[[[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] objectAtIndex:i]valueForKey:@"lastBookingStatus"]intValue];
                 NSLog(@"track no %d",trackno);//)
                 if (!(trackno ==25 || trackno ==1 || trackno ==3 || trackno ==4)) {
                     if ([[[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] objectAtIndex:i]valueForKey:@"serviceMode"]isEqualToString:@"o"]||[[[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] objectAtIndex:i]valueForKey:@"serviceMode"]isEqualToString:@"O"]) {
                         [self->onrdtracklistArray addObject:[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] objectAtIndex:i]];
                         [self->orderTbl reloadData];
                     }
                     else
                     {
                         [self->prebooktracklistArray addObject:[[[responseObject valueForKey:@"data"]valueForKey:@"bookingList"] objectAtIndex:i]];
                         [self->orderTbl reloadData];
                     }
                 }
             }
             if ([Utils isCheckNotNULL:self->onrdtracklistArray]) {
                 self->noDataLabel.hidden=YES;
             }
             else
             {
                 self->noDataLabel.hidden=NO;
             }
             self->orderTbl.hidden=NO;
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (onrdcheck) {
           appDelegate.serviceon=@"O";
        NSLog(@"vfdv %@",[onrdtracklistArray objectAtIndex:indexPath.row]);
        if ([[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"lastBookingStatus"]intValue]==0)
        {
            TryagainViewController * tryagain=[[TryagainViewController alloc]init];
            appDelegate.bookingidStr=[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"_id"];
            [self .navigationController pushViewController:tryagain animated:YES];
        }
        if ([[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"lastBookingStatus"]intValue]==16)
        {
            NewbillViewController * bill=[[NewbillViewController alloc]init];
            appDelegate.bookingidStr=[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"_id"];
            [self.navigationController pushViewController:bill animated:YES];
        }
        else
        {
            MapViewController * map=[[MapViewController alloc]init];
            NSLog(@"check----%@",[[[[[onrdtracklistArray objectAtIndex:indexPath.row] valueForKey:@"data"]valueForKey:@"bookingList"]valueForKey:@"location"]valueForKey:@"coordinates"]);
            
            NSArray * cordArray=[[[[[onrdtracklistArray objectAtIndex:indexPath.row] valueForKey:@"data"]valueForKey:@"bookingList"]valueForKey:@"location"]valueForKey:@"coordinates"];
            
            map.latStr=[cordArray objectAtIndex:1];
            map.lonStr=[cordArray objectAtIndex:0];
            //map.serviceprovidername=[[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"partnerId"]valueForKey:@"shopName"];
            self->appDelegate.fromschedule=NO;
            appDelegate.bookingidStr=[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"_id"];
            [self.navigationController pushViewController:map animated:YES];
        }
    }
    else
    {
        appDelegate.serviceon=@"P";
        if ([[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"lastBookingStatus"]intValue]==0)
        {
            MapViewController * map=[[MapViewController alloc]init];
            NSLog(@"check----%@",[[[[[onrdtracklistArray objectAtIndex:indexPath.row] valueForKey:@"data"]valueForKey:@"bookingList"]valueForKey:@"location"]valueForKey:@"coordinates"]);
            
            NSArray * cordArray=[[[[[onrdtracklistArray objectAtIndex:indexPath.row] valueForKey:@"data"]valueForKey:@"bookingList"]valueForKey:@"location"]valueForKey:@"coordinates"];
            
            map.latStr=[cordArray objectAtIndex:1];
            map.lonStr=[cordArray objectAtIndex:0];
            //map.serviceprovidername=[[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"partnerId"]valueForKey:@"shopName"];
            self->appDelegate.fromschedule=NO;
            appDelegate.bookingidStr=[[onrdtracklistArray objectAtIndex:indexPath.row]valueForKey:@"_id"];
            [self.navigationController pushViewController:map animated:YES];
        }
    }
    
}

@end
