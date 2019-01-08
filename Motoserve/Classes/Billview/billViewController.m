//
//  billViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 12/11/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "billViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"

@interface billViewController ()
{
    UIView * contentView,*navHeader;
    AppDelegate * appDelegate;
    NSMutableArray * puntureArray;
    NSTimer *bookingtimer;
    NSString * price;
    
}
@end

@implementation billViewController

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =Singlecolor(whiteColor);
    self.view = contentView;
    
    puntureArray=[[NSMutableArray alloc]initWithObjects:@"Punture", nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Bill Summary" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    [self createDesign];
    [self payment];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)payment
{
    NSString *url =[UrlGenerator Postpayment];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"bookingId":self.bookidStr,
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         }
         else
         {
             NSLog(@"1");
             self->price=[[[[responseObject valueForKey:@"data"]valueForKey:@"payment"]objectAtIndex:0]valueForKey:@"amount"];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (void)updatelocation
{
     [appDelegate startProgressView:self.view];
    NSString *url =[UrlGenerator Postupdatestatus];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":self.bookidStr,@"bookingStatus":@"7"
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             [self->appDelegate stopProgressView];
         }
         else
         {
             NSLog(@"1");
             self->bookingtimer= [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getbooking) userInfo:nil repeats:YES];
            
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (void)getbooking
{
    NSString *url =[UrlGenerator PostBooking];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":_bookidStr
                                  };
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response data %@",responseObject);
         [self->appDelegate stopProgressView];
         if ([[responseObject objectForKey:@"status"]integerValue]==0) {
             NSLog(@"0");
             [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
         }
         else
         {
             NSLog(@"1");
             if ([[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"]isEqualToString:@"8"]) {
                 [self->bookingtimer invalidate];
                 self->bookingtimer=nil;
                // [Utils showErrorAlert:@"Thank You" delegate:self];
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    if ([string isEqualToString:@"Ok"])
    {
        constraintViewController * home=[[constraintViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    }
}
- (void)createDesign
{
    UILabel * vechicledetailLbl=[[UILabel alloc]initWithFrame:CGRectMake(20,IS_IPHONEX?110:90, contentView.frame.size.width-40, 21)];
    vechicledetailLbl.text=@"Vehicle Details";
    vechicledetailLbl.textAlignment=NSTextAlignmentLeft;
    [contentView addSubview:vechicledetailLbl];
    
    
    UILabel * typeLbl=[[UILabel alloc]initWithFrame:CGRectMake(vechicledetailLbl.frame.origin.x+20, CGRectGetMaxY(vechicledetailLbl.frame)+10, vechicledetailLbl.frame.size.width/2.0-20, 21)];
    typeLbl.text=@"Vehicle Type";
    typeLbl.font=RalewayRegular(appDelegate.font-2);
    typeLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:typeLbl];
    
    UILabel * typevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(typeLbl.frame)+20, CGRectGetMaxY(vechicledetailLbl.frame)+10, typeLbl.frame.size.width, 21)];
    typevalLbl.text=@"Bike";
    typevalLbl.font=RalewayRegular(appDelegate.font-2);
    typevalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:typevalLbl];
    
    UILabel * brandLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(typeLbl.frame)+10, typeLbl.frame.size.width, 21)];
    brandLbl.text=@"Brand";
    brandLbl.font=RalewayRegular(appDelegate.font-2);
    brandLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:brandLbl];
    
    UILabel * brandvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(typeLbl.frame)+10, typeLbl.frame.size.width, 21)];
    brandvalLbl.text=@"Toyota";
    brandvalLbl.font=RalewayRegular(appDelegate.font-2);
    brandvalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:brandvalLbl];
    
    
    
    
    UILabel * modelLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(brandLbl.frame)+10, vechicledetailLbl.frame.size.width,21)];
    modelLbl.text=@"Model";
    modelLbl.font=RalewayRegular(appDelegate.font-2);
    modelLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:modelLbl];
    
    UILabel * modelvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(brandLbl.frame)+10, modelLbl.frame.size.width, 21)];
   modelvalLbl.text=@"Innova";
    modelvalLbl.font=RalewayRegular(appDelegate.font-2);
    modelvalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:modelvalLbl];
    
    
    
    
    UILabel * tyreLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(modelLbl.frame)+10, modelLbl.frame.size.width, 21)];
    tyreLbl.text=@"Tyre Type";
    tyreLbl.font=RalewayRegular(appDelegate.font-2);
    tyreLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:tyreLbl];
    
    UILabel * tyrevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(modelLbl.frame)+10, modelLbl.frame.size.width, 21)];
    tyrevalLbl.text=@"Tubeless";
    tyrevalLbl.font=RalewayRegular(appDelegate.font-2);
    tyrevalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:tyrevalLbl];
    
    UILabel * engineLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(tyreLbl.frame)+10, modelLbl.frame.size.width, 21)];
    engineLbl.text=@"Engine Type";
    engineLbl.font=RalewayRegular(appDelegate.font-2);
    engineLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:engineLbl];
    
    UILabel * enginevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(tyreLbl.frame)+10, modelLbl.frame.size.width, 21)];
    enginevalLbl.text=@"Petrol";
    enginevalLbl.font=RalewayRegular(appDelegate.font-2);
    enginevalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:enginevalLbl];
    
    
    UILabel * jockeyLbl=[[UILabel alloc]initWithFrame:CGRectMake(typeLbl.frame.origin.x, CGRectGetMaxY(engineLbl.frame)+10, modelLbl.frame.size.width, 21)];
    jockeyLbl.text=@"Jockey";
    jockeyLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:jockeyLbl];
    
    UILabel * jockeyvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(typevalLbl.frame.origin.x, CGRectGetMaxY(engineLbl.frame)+10, modelLbl.frame.size.width, 21)];
    jockeyvalLbl.text=@"Yes";
    jockeyvalLbl.font=RalewayRegular(appDelegate.font-2);
    jockeyvalLbl.textColor=Singlecolor(blackColor);
    [contentView addSubview:jockeyvalLbl];
    
    UILabel * orderidLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(jockeyLbl.frame)+20, contentView.frame.size.width-20, 30)];
    orderidLbl.backgroundColor=RGB(250, 247, 144);
    orderidLbl.textColor=RGB(41, 58, 157);
    orderidLbl.text=@"     Order id:#2588";
    orderidLbl.font=RalewayRegular(appDelegate.font-2);
    [contentView addSubview:orderidLbl];
    

    UIView * billheaderView=[[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(orderidLbl.frame)+10, contentView.frame.size.width-40, 30)];
    billheaderView.backgroundColor=RGB(218, 218, 218);
    [contentView addSubview:billheaderView];
    
    
    UILabel * particularLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,0, billheaderView.frame.size.width/3.0-5, billheaderView.frame.size.height)];
    particularLbl.text=@"Particular";
    particularLbl.textColor=Singlecolor(blackColor);
    particularLbl.font=RalewayRegular(appDelegate.font-2);
    particularLbl.textAlignment=NSTextAlignmentLeft;
    [billheaderView addSubview:particularLbl];
    
    UILabel * qualityLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(particularLbl.frame),0, particularLbl.frame.size.width, billheaderView.frame.size.height)];
    qualityLbl.text=@"Quality";
    qualityLbl.textColor=Singlecolor(blackColor);
    qualityLbl.font=RalewayRegular(appDelegate.font-2);
    qualityLbl.textAlignment=NSTextAlignmentCenter;
    [billheaderView addSubview:qualityLbl];
    
    UILabel * amtLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(qualityLbl.frame),0, particularLbl.frame.size.width, billheaderView.frame.size.height)];
    amtLbl.text=@"Amount(Rs)";
    amtLbl.font=RalewayRegular(appDelegate.font-2);
    amtLbl.textColor=Singlecolor(blackColor);
    amtLbl.textAlignment=NSTextAlignmentRight;
    [billheaderView addSubview:amtLbl];
    int yaxis=CGRectGetMaxY(billheaderView.frame)+10;
    UILabel * productamtLbl;
    for (int i=0; i<[puntureArray count]; i++) {
        
        UILabel * puntureLbl=[[UILabel alloc]initWithFrame:CGRectMake(particularLbl.frame.origin.x, yaxis, particularLbl.frame.size.width, 21)];
        puntureLbl.text=[puntureArray objectAtIndex:i];
        puntureLbl.textColor=Singlecolor(blackColor);
        puntureLbl.font=RalewayRegular(appDelegate.font-2);
        puntureLbl.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:puntureLbl];
        
        UILabel * productqtyLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(puntureLbl.frame)+20, yaxis, particularLbl.frame.size.width, 21)];
        productqtyLbl.text=@"1";
        productqtyLbl.textColor=Singlecolor(blackColor);
        productqtyLbl.font=RalewayRegular(appDelegate.font-2);
        productqtyLbl.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:productqtyLbl];
        
        productamtLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(productqtyLbl.frame)+10, yaxis, particularLbl.frame.size.width, 21)];
        productamtLbl.text=price;
        productamtLbl.textColor=Singlecolor(blackColor);
        productamtLbl.font=RalewayRegular(appDelegate.font-2);
        productamtLbl.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:productamtLbl];
        
        yaxis+=30;
    }
    yaxis=CGRectGetMaxY(productamtLbl.frame)+5;
    UIView * line1View=[[UIView alloc]initWithFrame:CGRectMake(10, yaxis, contentView.frame.size.width-20, 1)];
    line1View.backgroundColor=Singlecolor(lightGrayColor);
    [contentView addSubview:line1View];
    
    UILabel * totalLbl=[[UILabel alloc]initWithFrame:CGRectMake(qualityLbl.frame.origin.x, CGRectGetMaxY(line1View.frame), particularLbl.frame.size.width, 21)];
    totalLbl.text=@"Total";
    totalLbl.textColor=Singlecolor(blackColor);
    totalLbl.font=RalewayRegular(appDelegate.font-2);
    totalLbl.textAlignment=NSTextAlignmentCenter;
    [contentView addSubview:totalLbl];
    
    UILabel * finamtLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalLbl.frame)+20, CGRectGetMaxY(line1View.frame), particularLbl.frame.size.width, 21)];
    finamtLbl.text=[NSString stringWithFormat:@"Rs.%@",price];
    finamtLbl.font=RalewayRegular(appDelegate.font-2);
    finamtLbl.textColor=Singlecolor(blackColor);
    finamtLbl.textAlignment=NSTextAlignmentCenter;
    [contentView addSubview:finamtLbl];
    
    UIView * line2View=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(finamtLbl.frame), contentView.frame.size.width-20, 1)];
    line2View.backgroundColor=Singlecolor(lightGrayColor);
    [contentView addSubview:line2View];
    
    
    
    UIButton *  submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-100, CGRectGetMaxY(line2View.frame)+40, 200, 30)];
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:[NSString stringWithFormat:@"Make payment Rs.%@",price] forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(113, 209, 154) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:submitBtn];

}
-(void)submitAction
{
  [self updatelocation];
}

@end
