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
    UIView * prepareView,* startView,* rchView,* distdiv,* driverView,*  deliveredView,* deliverView;
    NSDateFormatter *dateFormat;
    UIImageView * prepareImg,* startImg,* rchImg,* doneImg,* esttimeImg,* estdistImg,* driverImg,* drivercallImg,* deliverImg,* deliveredImg,* delivercallImg;
    UILabel *  prepareLbl,* startLbl,* starttimeLbl,* rchLbl,* rchtimeLbl,* doneLbl,* donetimeLbl,* estdidtLbl,* esttimeLbl,* drivernameLbl,* drivernoLbl,* Amtlbl,* amtpriceLbl,* delivdatelbl,* delivdatevalLbl,* paylbl,* payvalLbl,*  deliverbl,* delivertimeLbl,* delivernameLbl,* delivernoLbl;
    UIButton *  doneBtn,* driverBtn,* drivercallBtn,* viewreceiptBtn,* deliverBtn,* delivercallBtn;
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
    if (appDelegate.fromschedule==YES) {
     swipeView.frame=CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    }
    else
    {
        swipeView.frame=CGRectMake(0, SCREEN_HEIGHT/3.0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT/3.0);
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
    
    if (appDelegate.fromschedule==YES) {
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
//        waitingView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        waitingView.layer.borderWidth = 1.0f;
//        waitingView.layer.cornerRadius = 8;
//        waitingView.layer.masksToBounds = true;
        
        UIButton * waitingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, waitingView.frame.size.width, waitingView.frame.size.height)];
        [waitingBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
        [waitingView addSubview:waitingBtn];
         waitingBtn.userInteractionEnabled=NO;
        
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
        int y=CGRectGetMaxY(statusLbl.frame)+30;
        
        prepareImg=[[UIImageView alloc]initWithFrame:CGRectMake(waitingView.frame.origin.x+40, y, 11, 10)];
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
        
            
            y=CGRectGetMaxY(preparetimeLbl.frame);
        
        
        scrollheight=y;
        if ([appDelegate.serviceon isEqualToString:@"o"]) {
            prepareLbl.text=@"Accepted on";
            preparetimeLbl.text=[dateFormat stringFromDate:date];
            
            prepareView=[[UIView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x+5, CGRectGetMaxY(prepareImg.frame), 1, 120)];
            prepareView.backgroundColor=RGB(0, 90, 45);
            [statusScroll addSubview:prepareView];
            
            startImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(prepareView.frame), 11, 10)];
            startImg.image=image(@"Progress");
            [statusScroll addSubview:startImg];
            
            startLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,startImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
            startLbl.text=@"Pick up";
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
            
            driverView=[[UIView alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(starttimeLbl.frame), prepareLbl.frame.size.width, 50)];
            [statusScroll addSubview:driverView];
            
            driverBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, driverView.frame.size.width-20, 50)];
            [driverBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
            [driverView addSubview:driverBtn];
            driverBtn.userInteractionEnabled=NO;
            scrollheight=CGRectGetMaxY(driverView.frame);
            
            driverImg=[[UIImageView alloc]initWithFrame:CGRectMake(10,5, 40, 40)];
            driverImg.layer.cornerRadius = driverImg.frame.size.width/2;
            driverImg.layer.masksToBounds = YES;
            driverImg.image=image(@"logo");
            [driverView addSubview:driverImg];
            
            drivernameLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(driverImg.frame)+5, 5, driverView.frame.size.width-(CGRectGetMaxX(driverImg.frame)+80), 21)];
            drivernameLbl.text=@"Ramesh";
            drivernameLbl.textColor=Singlecolor(blackColor);
            drivernameLbl.font=RalewayRegular(appDelegate.font-2);
            [driverView addSubview:drivernameLbl];
            
            drivernoLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(driverImg.frame)+5, CGRectGetMaxY(drivernameLbl.frame), drivernameLbl.frame.size.width, 21)];
            drivernoLbl.text=@"9787430508";
            drivernoLbl.textColor=Singlecolor(blackColor);
            drivernoLbl.font=RalewayRegular(appDelegate.font-2);
            [driverView addSubview:drivernoLbl];
            
            drivercallImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(drivernoLbl.frame)+5, 10, 30, 30)];
            drivercallImg.layer.cornerRadius = callImg.frame.size.width/2;
            drivercallImg.layer.masksToBounds = YES;
            drivercallImg.image=image(@"phone");
            [driverView addSubview:drivercallImg];


            drivercallBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(drivercallImg.frame),drivercallImg.frame.size.height)];
            [drivercallBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
            [drivercallImg addSubview:drivercallBtn];
            
            
            scrollheight=CGRectGetMaxY(drivercallImg.frame);
            
            startView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(startImg.frame), 1, prepareView.frame.size.height)];
            startView.backgroundColor=RGB(0, 90, 45);
            [statusScroll addSubview:startView];

            rchImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(startView.frame), 11, 10)];
            rchImg.image=image(@"Progress");
            [statusScroll addSubview:rchImg];

            rchLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,rchImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
            rchLbl.text=@"Estimation Accepted";
            rchLbl.textColor=Singlecolor(blackColor);
            rchLbl.font=RalewayRegular(appDelegate.font-2);
            [statusScroll addSubview:rchLbl];

            Amtlbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(rchLbl.frame), prepareLbl.frame.size.width/2.0, 21)];
            Amtlbl.text=@"Amount            :";
            Amtlbl.textColor=Singlecolor(blackColor);
            Amtlbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:Amtlbl];
            [Amtlbl autowidth:0];

            amtpriceLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Amtlbl.frame)+5, Amtlbl.frame.origin.y, prepareLbl.frame.size.width/2.0, 21)];
            amtpriceLbl.text=@"1800 Rs";
            amtpriceLbl.textColor=Singlecolor(blackColor);
            amtpriceLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:amtpriceLbl];


            delivdatelbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(Amtlbl.frame), prepareLbl.frame.size.width/2.0, 21)];
            delivdatelbl.text=@"Delivery date  :";
            delivdatelbl.textColor=Singlecolor(blackColor);
            delivdatelbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:delivdatelbl];
            [delivdatelbl autowidth:0];

             delivdatevalLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(delivdatelbl.frame)+5, delivdatelbl.frame.origin.y, prepareLbl.frame.size.width/2.0, 21)];
            delivdatevalLbl.text=@"19.0.2019 2:00PM";
            delivdatevalLbl.textColor=Singlecolor(blackColor);
            delivdatevalLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:delivdatevalLbl];

            rchtimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(delivdatelbl.frame), prepareLbl.frame.size.width, 21)];
            NSDate * rchdate=[NSDate date];
            [dateFormat setDateFormat:@"hh:mm a"];
            rchtimeLbl.text=[dateFormat stringFromDate:rchdate];
            rchtimeLbl.textColor=Singlecolor(lightGrayColor);
            rchtimeLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:rchtimeLbl];

            scrollheight=CGRectGetMaxY(rchtimeLbl.frame);


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


            paylbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(doneLbl.frame), prepareLbl.frame.size.width/2.0, 21)];
            paylbl.text=@"Pay bill  :";
            paylbl.textColor=Singlecolor(lightGrayColor);
            paylbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:paylbl];
            [paylbl autowidth:0];

            payvalLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(paylbl.frame)+5, paylbl.frame.origin.y, prepareLbl.frame.size.width/2.0, 21)];
            payvalLbl.text=@"1500 Rs";
            payvalLbl.textColor=Singlecolor(lightGrayColor);
            payvalLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:payvalLbl];
            [payvalLbl autowidth:0];

            viewreceiptBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(payvalLbl.frame)+5, paylbl.frame.origin.y-10, 80, 30)];
            [viewreceiptBtn setTitle:@"View Receipt" forState:UIControlStateNormal];
            [viewreceiptBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
            [viewreceiptBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
            [statusScroll addSubview:viewreceiptBtn];
            viewreceiptBtn.userInteractionEnabled=NO;
            [statusScroll addSubview:viewreceiptBtn];
            viewreceiptBtn.titleLabel.font=RalewayRegular(appDelegate.font-6);


            donetimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(paylbl.frame), prepareLbl.frame.size.width, 21)];
            NSDate * donedate=[NSDate date];
            [dateFormat setDateFormat:@"hh:mm a"];
            donetimeLbl.text=[dateFormat stringFromDate:donedate];
            donetimeLbl.textColor=Singlecolor(lightGrayColor);
            donetimeLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:donetimeLbl];

            scrollheight=CGRectGetMaxY(donetimeLbl.frame);

           deliveredView=[[UIView alloc]initWithFrame:CGRectMake(prepareView.frame.origin.x, CGRectGetMaxY(doneImg.frame), 1, prepareView.frame.size.height)];
            deliveredView.backgroundColor=RGB(0, 90, 45);
            [statusScroll addSubview:deliveredView];


            deliverImg=[[UIImageView alloc]initWithFrame:CGRectMake(prepareImg.frame.origin.x, CGRectGetMaxY(deliveredView.frame), 11, 10)];
            deliverImg.image=image(@"Progress");
            [statusScroll addSubview:deliverImg];


            deliverbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x,deliverImg.frame.origin.y-5,prepareLbl.frame.size.width, 21)];
            deliverbl.text=@"Delivered";
            deliverbl.textColor=Singlecolor(blackColor);
            deliverbl.font=RalewayRegular(self->appDelegate.font-2);
            [self->statusScroll addSubview:deliverbl];

          delivertimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(deliverbl.frame), prepareLbl.frame.size.width, 21)];
            NSDate * deliverdate=[NSDate date];
            [dateFormat setDateFormat:@"hh:mm a"];
            delivertimeLbl.text=[dateFormat stringFromDate:deliverdate];
            delivertimeLbl.textColor=Singlecolor(lightGrayColor);
            delivertimeLbl.font=RalewayRegular(appDelegate.font-4);
            [statusScroll addSubview:delivertimeLbl];


             deliverView=[[UIView alloc]initWithFrame:CGRectMake(prepareLbl.frame.origin.x, CGRectGetMaxY(delivertimeLbl.frame), prepareLbl.frame.size.width, 50)];
            [statusScroll addSubview:deliverView];

            deliverBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, driverView.frame.size.width-20, 50)];
            [deliverBtn setBackgroundImage:image(@"list_bg") forState:UIControlStateNormal];
            [deliverView addSubview:deliverBtn];
            deliverBtn.userInteractionEnabled=NO;
            

            deliveredImg=[[UIImageView alloc]initWithFrame:CGRectMake(10,5, 40, 40)];
            deliveredImg.layer.cornerRadius = deliveredImg.frame.size.width/2;
            deliveredImg.layer.masksToBounds = YES;
            deliveredImg.image=image(@"logo");
            [deliverView addSubview:deliveredImg];

            delivernameLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deliveredImg.frame)+5, 5, deliverView.frame.size.width-(CGRectGetMaxX(deliveredImg.frame)+80), 21)];
            delivernameLbl.text=@"Ramesh";
            delivernameLbl.textColor=Singlecolor(blackColor);
            delivernameLbl.font=RalewayRegular(appDelegate.font-2);
            [deliverView addSubview:delivernameLbl];

           delivernoLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deliveredImg.frame)+5, CGRectGetMaxY(delivernameLbl.frame), delivernameLbl.frame.size.width, 21)];
            delivernoLbl.text=@"9787430508";
            delivernoLbl.textColor=Singlecolor(blackColor);
            delivernoLbl.font=RalewayRegular(appDelegate.font-2);
            [deliverView addSubview:delivernoLbl];

            delivercallImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(delivernoLbl.frame)+5, 10, 30, 30)];
            delivercallImg.layer.cornerRadius = callImg.frame.size.width/2;
            delivercallImg.layer.masksToBounds = YES;
            delivercallImg.image=image(@"phone");
            [deliverView addSubview:delivercallImg];


            delivercallBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(delivercallImg.frame),delivercallImg.frame.size.height)];
            [delivercallBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
            [delivercallImg addSubview:delivercallBtn];

            
            doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-75, CGRectGetMaxY(deliverView.frame)+40, 150, 30)];
            [doneBtn setBackgroundColor:Singlecolor(clearColor)];
            [doneBtn setTitle:@"Make Payment" forState:UIControlStateNormal];
            doneBtn.titleLabel.font=RalewayRegular(self->appDelegate.font-2);
            [doneBtn setTitleColor:RGB(0, 90, 45) forState:UIControlStateNormal];
            doneBtn.layer.cornerRadius = 5;
            doneBtn.layer.borderWidth = 0.5;
            doneBtn.layer.masksToBounds = true;
            doneBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
            [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
            [statusScroll addSubview:doneBtn];

            scrollheight=CGRectGetMaxY(doneBtn.frame);
            
            
            statusScroll.contentSize=CGSizeMake(320, scrollheight+20);
        }
        else
        {
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
            
            
            //}
            estdidtLbl.text=@": 2.5 Km";
            [estdidtLbl autowidth:0];
            esttimeLbl.text=@": 10 Mins";
            [esttimeLbl autowidth:0];
            statusScroll.contentSize=CGSizeMake(320, scrollheight+20);
        }
        
        CGPoint bottomOffset = CGPointMake(0, (statusScroll.contentSize.height - statusScroll.bounds.size.height)+20);
        [statusScroll setContentOffset:bottomOffset animated:YES];
        
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
    if ([appDelegate.serviceon isEqualToString:@"O"]) {
        
    }
    else
    {
    if ([appDelegate.bookingstatusStr isEqualToString:@"5"]) {
     
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
        
        scrollheight=CGRectGetMaxY(esttimeLbl.frame);
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"6"])
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
        
        scrollheight=CGRectGetMaxY(rchtimeLbl.frame);
    }
    else if ([appDelegate.bookingstatusStr isEqualToString:@"15"])
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
        
        scrollheight=CGRectGetMaxY(doneBtn.frame);
    }
  }
    CGPoint bottomOffset = CGPointMake(0, (statusScroll.contentSize.height - statusScroll.bounds.size.height)+20);
    [statusScroll setContentOffset:bottomOffset animated:YES];
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
        appDelegate.bookingstatusStr=@"16";
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
             self->appDelegate.bookingstatusStr=[[[responseObject valueForKey:@"data"]valueForKey:@"booking"]valueForKey:@"lastBookingStatus"];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TryagainViewController * tryagain=[[TryagainViewController alloc]init];
    [self.navigationController pushViewController:tryagain animated:YES];
}
@end
