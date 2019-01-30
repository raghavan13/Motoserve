//
//  DraggableViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "DraggableViewController.h"
#import "CPMetaFile.h"
#import "AppDelegate.h"
@interface DraggableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *  statusScroll;
    AppDelegate * appDelegate;
    UIView * prepareView,* startView,* rchView,* distdiv;
    NSDateFormatter *dateFormat;
    UIImageView * prepareImg,* startImg,* rchImg,* doneImg,* esttimeImg,* estdistImg;
    UILabel *  prepareLbl,* startLbl,* starttimeLbl,* rchLbl,* rchtimeLbl,* doneLbl,* donetimeLbl,* estdidtLbl,* esttimeLbl;
    UIButton *  doneBtn;
    int scrollheight;
}
@end

@implementation DraggableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    dateFormat = [[NSDateFormatter alloc] init];
    [self createDesign];
}

- (void)createDesign
{
    UIView * swipeView=[[UIView alloc]init];
    if ([appDelegate.serviceon isEqualToString:@"o"]) {
        swipeView.frame=CGRectMake(0, SCREEN_HEIGHT/3.0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT/3.0);
    }
    else
    {
        swipeView.frame=CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    }
    swipeView.backgroundColor=Singlecolor(whiteColor);
    [self.view addSubview:swipeView];
    
    
    UIButton * dragBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    dragBtn.backgroundColor=Singlecolor(whiteColor);
    dragBtn.layer.borderWidth = 1.0f;
    [dragBtn addTarget:self action:@selector(gestureHandlerMethod) forControlEvents:UIControlEventTouchUpInside];
    dragBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [swipeView addSubview:dragBtn];
    
    UIImageView * sliderImg=[[UIImageView alloc]initWithFrame:CGRectMake(dragBtn.frame.size.width/2-22, dragBtn.frame.size.height/2-4.5, 44, 9)];
    sliderImg.image=image(@"seperator");
    [dragBtn addSubview:sliderImg];
    
    if ([appDelegate.serviceon isEqualToString:@"p"]) {
        UITableView * shoplistTbl=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dragBtn.frame), swipeView.frame.size.width, swipeView.frame.size.height-(CGRectGetMaxY(dragBtn.frame)))];
        shoplistTbl.backgroundColor=Singlecolor(clearColor);
        shoplistTbl.dataSource=self;
        shoplistTbl.delegate=self;
        [swipeView addSubview:shoplistTbl];
    }
    else
    {
        statusScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dragBtn.frame), swipeView.frame.size.width, swipeView.frame.size.height-CGRectGetMaxY(dragBtn.frame))];
        statusScroll.showsHorizontalScrollIndicator=NO;
        statusScroll.showsVerticalScrollIndicator=NO;
        [swipeView addSubview:statusScroll];
        
        //statusScroll.backgroundColor=Singlecolor(redColor);
        
        UILabel * vehiclenoLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, statusScroll.frame.size.width, 21)];
        NSLog(@"srerg %@ bfdbf %@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"vehicleNumber"],[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"model"]);
        if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"vehicleNumber"]]||[Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"model"]]) {
            vehiclenoLbl.text=[[NSString stringWithFormat:@"%@ - %@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"vehicleNumber"],[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"vehicleId"]valueForKey:@"model"]]capitalizedString];//@"TN 45 1420 - Hero Splendor Pro";
        }
        vehiclenoLbl.font=RalewayBold(appDelegate.font-2);
        vehiclenoLbl.textAlignment=NSTextAlignmentCenter;
        [statusScroll addSubview:vehiclenoLbl];
        
        
        UILabel * areaLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vehiclenoLbl.frame)+10, statusScroll.frame.size.width, 21)];
        if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"shopName"]]) {
            areaLbl.text=[[NSString stringWithFormat:@"%@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"shopName"]]uppercaseString];//@"Adyar Motors";
        }
        
        areaLbl.font=RalewayBold(appDelegate.font-2);https://mail.google.com/mail/u/0/#inbox/FMfcgxwBTsjmdrfdWctjPMJfhbCgBKlc?projector=1&messagePartId=0.3
        areaLbl.textAlignment=NSTextAlignmentCenter;
        [statusScroll addSubview:areaLbl];
        
        
        UILabel * bookingidLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(areaLbl.frame)+10, statusScroll.frame.size.width/3.0, 21)];
        // text = [text substringToIndex:NSMaxRange([text rangeOfComposedCharacterSequenceAtIndex:2])];
        
        bookingidLbl.text=[NSString stringWithFormat:@"Booking ID:%@",[appDelegate.bookingidStr substringToIndex:NSMaxRange([appDelegate.bookingidStr rangeOfComposedCharacterSequenceAtIndex:5])]];//@"Booking ID:15257";
        bookingidLbl.font=RalewayRegular(appDelegate.font-7);
        bookingidLbl.textAlignment=NSTextAlignmentLeft;
        [statusScroll addSubview:bookingidLbl];
        
        
        UILabel * dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bookingidLbl.frame), bookingidLbl.frame.origin.y, bookingidLbl.frame.size.width, bookingidLbl.frame.size.height)];
        if ([Utils isCheckNotNULL:[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"lastUpdated"]]) {
            NSArray * seperatetransidArray= [[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"lastUpdated"] componentsSeparatedByString:@"T"];
            if ([Utils isCheckNotNULL:seperatetransidArray]) {
                dateLbl.text=[NSString stringWithFormat:@"Date:%@",[Utils GlobalDateConvert:[seperatetransidArray objectAtIndex:0] inputFormat:@"yyyy-mm-dd" outputFormat:@"dd.mm.yyyy"]];
            }
        }
        
        dateLbl.font=RalewayRegular(appDelegate.font-8);
        dateLbl.textAlignment=NSTextAlignmentRight;
        [statusScroll addSubview:dateLbl];
        
        UIView * waitingView=[[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(dateLbl.frame)+10, statusScroll.frame.size.width-80, IS_IPHONEX?100:statusScroll.frame.size.height/3.5-20)];
        [statusScroll addSubview:waitingView];
        waitingView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        waitingView.layer.borderWidth = 1.0f;
        waitingView.layer.cornerRadius = 8;
        waitingView.layer.masksToBounds = true;
        
        
        UIImageView * profImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, waitingView.frame.size.width/5, waitingView.frame.size.width/5)];
        profImg.layer.cornerRadius = profImg.frame.size.width/2;
        profImg.layer.masksToBounds = YES;
        profImg.image=image(@"logo");
        [waitingView addSubview:profImg];
        
        UILabel * nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(profImg.frame)-5, 5, waitingView.frame.size.width-(CGRectGetMaxX(profImg.frame)-10), 21)];
        if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"userName"]]) {
            nameLbl.text=[NSString stringWithFormat:@"%@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"userName"]];
        }
        
        //nameLbl.backgroundColor=Singlecolor(grayColor);
        nameLbl.textAlignment=NSTextAlignmentCenter;
        [waitingView addSubview:nameLbl];
        
        UIView * divView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(profImg.frame)+10, CGRectGetMaxY(nameLbl.frame)+10, nameLbl.frame.size.width-45, 0.5)];
        divView.backgroundColor=RGB(0, 89, 42);
        [waitingView addSubview:divView];
        
        
        nameLbl.frame=CGRectMake(nameLbl.frame.origin.x, nameLbl.frame.origin.y, divView.frame.size.width, nameLbl.frame.size.height);
        
        
        UILabel * noLbl=[[UILabel alloc]initWithFrame:CGRectMake(nameLbl.frame.origin.x+10, CGRectGetMaxY(divView.frame)+20, nameLbl.frame.size.width/1.8, 21)];
        if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"mobile"]]) {
            noLbl.text=[NSString stringWithFormat:@"%@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"mobile"]];//@"9787430308";
        }
        
        noLbl.textAlignment=NSTextAlignmentCenter;
        // noLbl.backgroundColor=Singlecolor(grayColor);
        [waitingView addSubview:noLbl];
        
        UIView * div2View=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noLbl.frame), noLbl.frame.origin.y,1, 21)];
        div2View.backgroundColor=RGB(0, 89, 42);
        [waitingView addSubview:div2View];
        
        UIImageView * callImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(div2View.frame)+10, CGRectGetMaxY(divView.frame)+12, waitingView.frame.size.width/10, waitingView.frame.size.width/10)];
        callImg.layer.cornerRadius = callImg.frame.size.width/2;
        callImg.layer.masksToBounds = YES;
        callImg.image=image(@"phone");
        [waitingView addSubview:callImg];
        
        
        UIButton * callBtn=[[UIButton alloc]initWithFrame:CGRectMake(noLbl.frame.origin.x, callImg.frame.origin.y, CGRectGetMaxX(callImg.frame),callImg.frame.size.height)];
        [callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        //callBtn.backgroundColor=Singlecolor(redColor);
        [waitingView addSubview:callBtn];
        
        
        
        
        UILabel * statusLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(waitingView.frame)+10, statusScroll.frame.size.width, 21)];
        statusLbl.text=@"Status";
        statusLbl.textAlignment=NSTextAlignmentCenter;
        statusLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:statusLbl];
        
        
        prepareImg=[[UIImageView alloc]initWithFrame:CGRectMake(waitingView.frame.origin.x+40, CGRectGetMaxY(statusLbl.frame)+30, 11, 10)];
        prepareImg.image=image(@"Progress");
        [statusScroll addSubview:prepareImg];
        
        prepareLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prepareImg.frame)+20,CGRectGetMaxY(statusLbl.frame)+25,statusLbl.frame.size.width-120, 21)];
        prepareLbl.text=@"Preparing Tools";
        prepareLbl.textColor=Singlecolor(blackColor);
        
        prepareLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:prepareLbl];
        
        UILabel * preparetimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(prepareLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * date=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        preparetimeLbl.text=[dateFormat stringFromDate:date];
        preparetimeLbl.textColor=Singlecolor(lightGrayColor);
        preparetimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:preparetimeLbl];
        
        scrollheight=CGRectGetMaxY(preparetimeLbl.frame);
        
        [self receivesegmentNotification];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivesegmentNotification)
                                                     name:@"changetype"
                                                   object:nil];
    }
}
- (void)callAction
{
    if ([Utils isCheckNotNULL:[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"mobile"]]) {
        NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",[[[appDelegate.servicedetails valueForKey:@"booking"] valueForKey:@"partnerId"]valueForKey:@"mobile"]];
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
}
- (void)gestureHandlerMethod
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)receivesegmentNotification
{
    
    //if ([appDelegate.bookingstatusStr isEqualToString:@"2"]) {
        prepareView=[[UIView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x+5, CGRectGetMaxY(prepareImg.frame), 1, 80)];
        prepareView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:prepareView];
        
       startImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(prepareView.frame), 11, 10)];
        startImg.image=image(@"Progress");
        [statusScroll addSubview:startImg];
        
        startLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,startImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        startLbl.text=@"Start Navigation";
        startLbl.textColor=Singlecolor(blackColor);
        startLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:startLbl];
        
        
        starttimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(startLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * startdate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        starttimeLbl.text=[dateFormat stringFromDate:startdate];
        starttimeLbl.textColor=Singlecolor(lightGrayColor);
        starttimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:starttimeLbl];
        
        
        estdistImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(starttimeLbl.frame)+5, 15, 13)];
        estdistImg.image=image(@"est_distance");
        [statusScroll addSubview:estdistImg];
        
         estdidtLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(estdistImg.frame),CGRectGetMaxY(starttimeLbl.frame), 50, 21)];
        estdidtLbl.textColor=Singlecolor(lightGrayColor);
        estdidtLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:estdidtLbl];
       
        
         distdiv=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(estdidtLbl.frame)+10, estdistImg.frame.origin.y, 1, estdistImg.frame.size.height)];
        distdiv.backgroundColor=Singlecolor(lightGrayColor);
        [statusScroll addSubview:distdiv];
        
        
        esttimeImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(distdiv.frame)+10, estdistImg.frame.origin.y, 15, 15)];
        esttimeImg.image=image(@"est_time");
        [statusScroll addSubview:esttimeImg];
        
        esttimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(esttimeImg.frame),CGRectGetMaxY(starttimeLbl.frame), 100, 21)];
        esttimeLbl.textColor=Singlecolor(lightGrayColor);
        esttimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:esttimeLbl];
        
        scrollheight=CGRectGetMaxY(esttimeLbl.frame);
    //}
    //else if ([appDelegate.bookingstatusStr isEqualToString:@"3"])
    //{
    startView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(startImg.frame), 1, prepareView.frame.size.height)];
        startView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:startView];
        
        
    rchImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(startView.frame), 11, 10)];
        rchImg.image=image(@"Progress");
        [statusScroll addSubview:rchImg];
        
    rchLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,rchImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        rchLbl.text=@"Work In Progress";
        rchLbl.textColor=Singlecolor(blackColor);
        rchLbl.font=RalewayRegular(appDelegate.font-2);
        [statusScroll addSubview:rchLbl];
        
    rchtimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(rchLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * rchdate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        rchtimeLbl.text=[dateFormat stringFromDate:rchdate];
        rchtimeLbl.textColor=Singlecolor(lightGrayColor);
        rchtimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:rchtimeLbl];
        
        scrollheight=CGRectGetMaxY(rchtimeLbl.frame);
    //}
    //else if ([appDelegate.bookingstatusStr isEqualToString:@"4"])
    //{
    rchView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(rchImg.frame), 1, prepareView.frame.size.height)];
        rchView.backgroundColor=RGB(0, 90, 45);
        [statusScroll addSubview:rchView];
        
        
    doneImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(rchView.frame), 11, 10)];
        doneImg.image=image(@"Progress");
        [statusScroll addSubview:doneImg];
        
    doneLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,doneImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
        doneLbl.text=@"Work Done";
        doneLbl.textColor=Singlecolor(blackColor);
        doneLbl.font=RalewayRegular(self->appDelegate.font-2);
        [self->statusScroll addSubview:doneLbl];
        
    donetimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(doneLbl.frame), prepareLbl.frame.size.width, 21)];
        NSDate * donedate=[NSDate date];
        [dateFormat setDateFormat:@"hh:mm a"];
        donetimeLbl.text=[dateFormat stringFromDate:donedate];
        donetimeLbl.textColor=Singlecolor(lightGrayColor);
        donetimeLbl.font=RalewayRegular(appDelegate.font-4);
        [statusScroll addSubview:donetimeLbl];
        
        
    doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(doneLbl.frame)+40, 100, 30)];
        [doneBtn setBackgroundColor:Singlecolor(clearColor)];
        [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        doneBtn.titleLabel.font=RalewayRegular(self->appDelegate.font-2);
        [doneBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
        doneBtn.layer.cornerRadius = 5;
        doneBtn.layer.borderWidth = 0.5;
        doneBtn.layer.masksToBounds = true;
        doneBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
        [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [statusScroll addSubview:doneBtn];
        
        scrollheight=CGRectGetMaxY(doneBtn.frame);
    //}
    estdidtLbl.text=@": 2.5 Km";
     [estdidtLbl autowidth:0];
    esttimeLbl.text=@": 10 Mins";
    [esttimeLbl autowidth:0];
    statusScroll.contentSize=CGSizeMake(320, scrollheight+20);
    
    if ([appDelegate.bookingstatusStr isEqualToString:@"2"]) {
     
        prepareView.hidden=NO;
        startImg.hidden=NO;
        startLbl.hidden=NO;
        starttimeLbl.hidden=NO;
        estdistImg.hidden=NO;
        estdidtLbl.hidden=NO;
        distdiv.hidden=NO;
        esttimeImg.hidden=NO;
        esttimeLbl.hidden=NO;
        
        startView.hidden=YES;
        rchImg.hidden=YES;
        rchLbl.hidden=YES;
        rchtimeLbl.hidden=YES;
        
        rchView.hidden=YES;
        doneImg.hidden=YES;
        doneLbl.hidden=YES;
        donetimeLbl.hidden=YES;
        doneBtn.hidden=YES;
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"3"])
    {
        prepareView.hidden=NO;
        startImg.hidden=NO;
        startLbl.hidden=NO;
        starttimeLbl.hidden=NO;
        estdistImg.hidden=NO;
        estdidtLbl.hidden=NO;
        distdiv.hidden=NO;
        esttimeImg.hidden=NO;
        esttimeLbl.hidden=NO;
        
        startView.hidden=NO;
        rchImg.hidden=NO;
        rchLbl.hidden=NO;
        rchtimeLbl.hidden=NO;
        
        rchView.hidden=YES;
        doneImg.hidden=YES;
        doneLbl.hidden=YES;
        donetimeLbl.hidden=YES;
        doneBtn.hidden=YES;
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"4"])
    {
        prepareView.hidden=NO;
        startImg.hidden=NO;
        startLbl.hidden=NO;
        starttimeLbl.hidden=NO;
        estdistImg.hidden=NO;
        estdidtLbl.hidden=NO;
        distdiv.hidden=NO;
        esttimeImg.hidden=NO;
        esttimeLbl.hidden=NO;
        
        startView.hidden=NO;
        rchImg.hidden=NO;
        rchLbl.hidden=NO;
        rchtimeLbl.hidden=NO;
        
        rchView.hidden=NO;
        doneImg.hidden=NO;
        doneLbl.hidden=NO;
        donetimeLbl.hidden=NO;
        doneBtn.hidden=NO;
    }
}
- (void)doneAction
{
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"Is your Work Done" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    if ([string isEqualToString:@"Yes"])
    {
        appDelegate.bookingstatusStr=@"5";
        [self updatelocation];
    }
}
- (void)updatelocation
{
    [appDelegate startProgressView:self.view];
    NSString *url =[UrlGenerator Postupdatestatus];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * parameters = @{
                                  @"_id":appDelegate.bookingidStr,@"bookingStatus":appDelegate.bookingstatusStr
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
             self->appDelegate.bookingstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"bookingStatus"];
             [self gestureHandlerMethod];
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"updatebill"
              object:nil];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"Error: %@", error);
         [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
         [self->appDelegate stopProgressView];
     }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    
    ShopviewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[ShopviewCell alloc] init];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
@end
