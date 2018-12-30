//
//  AddvechicleViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 17/10/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "AddvechicleViewController.h"
#import "AppDelegate.h"
#import "CPMetaFile.h"
#import <AWSCore.h>
#import <AWSS3TransferManager.h>

@interface AddvechicleViewController ()<SSPopupDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIView * contentView,*navHeader;
    AppDelegate * appDelegate;
    UIButton *  twowheelBtn,* fourwheelBtn,* tubetyreBtn,* tubelessBtn,*petrolBtn,* dieselBtn,* submitBtn,* brandBtn,* modelBtn,* imgBtn,*lpgBtn;
    NSInteger selectedtag;
    int ypos;
    BOOL iscar;
    UIScrollView * addvechScroll;
    UIView * carView;
    UIImageView * bikeradioImg,* bikeavatharImg,* carradioImg,* caravatharImg,* tubeImg,* tubelessImg,* petrolImg,* dieselImg,* yesImg,* noImg,* no1Img,* yes1Img,* camImg,*lpgImg;
    NSMutableArray * vechicleArray,*vechiclesubArray;
    NSDictionary *json;
    SSPopup* selection;
    NSDictionary * vechiclemodeldic;
    UITextField * vechilenoTxtfld;
    NSString * brandStr,*modelStr,*tyreStr,*engineStr,*jockeyStr,*typeStr,*secondaryStr;
    NSString * urlpath,*filePath;
    NSURL* fileUrl;
    UIView * senderView ;
}
@end

@implementation AddvechicleViewController

-(void)loadView
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, appDelegate.wVal,appDelegate.hVal)];
    contentView.backgroundColor =Singlecolor(whiteColor);
    self.view = contentView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    navHeader=[Utils CreateHeaderBarWithSearch:contentView HeaderTitle:@"Add Vehicle" IsText:YES Menu:NO IsCart:NO LeftClass:self LeftSelector:@selector(backAction) RightClass:self RightSelector:nil WithCartCount:@"1" SearchClass:self SearchSelector:nil ShowSearch:NO HeaderTap:nil TapAction:nil];
    vechicleArray=[[NSMutableArray alloc]init];
    vechiclesubArray=[[NSMutableArray alloc]init];
    // Retrieve local JSON file called example.json
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    // Load the file into an NSData object called JSONData
    
    NSError *error = nil;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    NSLog(@"bike %@",[json valueForKey:@"bikeBrands"]);
    vechicleArray = [[json valueForKey:@"bikeBrands"]valueForKey:@"name"];
    //vechicleidArray=[[json valueForKey:@"bikeBrands"]valueForKey:@"id"];
    [self createDesign];
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
                                                                                                    identityPoolId:@"us-east-1:4d04a84f-44c4-4672-b4b8-bb0c95f2eecb"];

    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
                                                                         credentialsProvider:credentialsProvider];

    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
    urlpath=@"";
}


- (void)createDesign
{
    jockeyStr=@"0";
    engineStr=@"P";
    secondaryStr=@"0";
    tyreStr=@"";
    addvechScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IS_IPHONEX?90:70, contentView.frame.size.width, contentView.frame.size.height-(IS_IPHONEX?90:70))];
    //addvechScroll.backgroundColor=Singlecolor(grayColor);
    addvechScroll.showsHorizontalScrollIndicator=NO;
    addvechScroll.showsVerticalScrollIndicator=NO;
    [contentView addSubview:addvechScroll];
    
    twowheelBtn=[[UIButton alloc]initWithFrame:CGRectMake(80,30, contentView.frame.size.width/4, contentView.frame.size.width/4)];
    twowheelBtn.tag=1;
    [twowheelBtn addTarget:self action:@selector(vechicleAction:) forControlEvents:UIControlEventTouchUpInside];
    [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
    [addvechScroll addSubview:twowheelBtn];
    typeStr=@"T";
    
    fourwheelBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(twowheelBtn.frame)+40,twowheelBtn.frame.origin.y, twowheelBtn.frame.size.width, twowheelBtn.frame.size.width)];
    fourwheelBtn.tag=2;
    [fourwheelBtn addTarget:self action:@selector(vechicleAction:) forControlEvents:UIControlEventTouchUpInside];
    [fourwheelBtn setBackgroundImage:image(@"car_unselect") forState:UIControlStateNormal];
    [addvechScroll addSubview:fourwheelBtn];
    
    vechilenoTxtfld=[[UITextField alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(fourwheelBtn.frame)+10, addvechScroll.frame.size.width-160, 40)];
vechilenoTxtfld.backgroundColor=RGB(217, 217, 217);
    vechilenoTxtfld.textAlignment=NSTextAlignmentCenter;
    vechilenoTxtfld.placeholder=@"Enter Vehicle Number";
    [vechilenoTxtfld  setValue:Singlecolor(blackColor)
                    forKeyPath:@"_placeholderLabel.textColor"];
    vechilenoTxtfld.font=RalewayRegular(appDelegate.font-2);
    vechilenoTxtfld.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    vechilenoTxtfld.textColor=Singlecolor(blackColor);
    [addvechScroll addSubview:vechilenoTxtfld];
    
    
//    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(vechilenoTxtfld.frame.origin.x, CGRectGetMaxY(vechilenoTxtfld.frame)-5, vechilenoTxtfld.frame.size.width, 0.5)];
//    lineView.backgroundColor=RGB(224, 224, 224);
//    [addvechScroll addSubview:lineView];
    
    UIView *vechnoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    vechilenoTxtfld.leftView = vechnoView;
    vechilenoTxtfld.leftViewMode = UITextFieldViewModeAlways;
    
    brandBtn=[[UIButton alloc]initWithFrame:CGRectMake(vechilenoTxtfld.frame.origin.x, CGRectGetMaxY(vechilenoTxtfld.frame)+10, vechilenoTxtfld.frame.size.width, 40)];
    brandBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [brandBtn setTitle:@"Brand" forState:UIControlStateNormal];
    [brandBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [brandBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,20)];
    [brandBtn setImageEdgeInsets:UIEdgeInsetsMake(0,brandBtn.frame.size.width-20,0,0)];
    [brandBtn setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
    brandBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    brandBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    brandBtn.layer.borderWidth = 0.5;
    brandBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    brandBtn.layer.cornerRadius = 5;
    brandBtn.layer.masksToBounds = true;
    [brandBtn addTarget:self action:@selector(brandAction:) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll addSubview:brandBtn];
    
    
    modelBtn=[[UIButton alloc]initWithFrame:CGRectMake(vechilenoTxtfld.frame.origin.x, CGRectGetMaxY(brandBtn.frame)+10, vechilenoTxtfld.frame.size.width, 40)];
    modelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [modelBtn setTitle:@"Model" forState:UIControlStateNormal];
    [modelBtn setTitleColor:Singlecolor(blackColor) forState:UIControlStateNormal];
    [modelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,20)];
    [modelBtn setImageEdgeInsets:UIEdgeInsetsMake(0,modelBtn.frame.size.width-20,0,0)];
    [modelBtn setImage:[UIImage imageNamed:@"dropdown"] forState:UIControlStateNormal];
    modelBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    modelBtn.titleLabel.font=RalewayRegular(appDelegate.font);
    modelBtn.layer.cornerRadius = 5;
    modelBtn.layer.masksToBounds = true;
    modelBtn.layer.borderWidth = 0.5;
    modelBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [modelBtn addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll addSubview:modelBtn];
    
    UILabel * tyreLbl=[[UILabel alloc]initWithFrame:CGRectMake(vechilenoTxtfld.frame.origin.x, CGRectGetMaxY(modelBtn.frame)+10, vechilenoTxtfld.frame.size.width, 21)];
    tyreLbl.text=@"Tyre Type";
    tyreLbl.textColor=RGB(17, 90, 42);
    tyreLbl.textAlignment=NSTextAlignmentLeft;
    tyreLbl.font=RalewayRegular(appDelegate.font-2);
    [addvechScroll addSubview:tyreLbl];
    
    
    
    tubeImg=[[UIImageView alloc]initWithFrame:CGRectMake(tyreLbl.frame.origin.x+20, CGRectGetMaxY(tyreLbl.frame)+10, 20, 20)];
    tubeImg.image=image(@"radiouncheck");
    [addvechScroll addSubview:tubeImg];
    
    UILabel * tubeLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tubeImg.frame)+10, CGRectGetMaxY(tyreLbl.frame)+10, 100, 21)];
    tubeLbl.text=@"Tube";
    tubeLbl.font=RalewayRegular(appDelegate.font-2);
    [addvechScroll addSubview:tubeLbl];
    
    tubetyreBtn=[[UIButton alloc]initWithFrame:CGRectMake(tyreLbl.frame.origin.x+20,CGRectGetMaxY(tyreLbl.frame)+10, contentView.frame.size.width/3.5, 21)];
    tubetyreBtn.tag=1;
    [tubetyreBtn addTarget:self action:@selector(tyretypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll addSubview:tubetyreBtn];
    
    
    
    tubelessImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tubetyreBtn.frame), CGRectGetMaxY(tyreLbl.frame)+10, 20, 20)];
    tubelessImg.image=image(@"radiouncheck");
    [addvechScroll addSubview:tubelessImg];
    
    UILabel * tubelessLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tubelessImg.frame)+10, CGRectGetMaxY(tyreLbl.frame)+10, 100, 21)];
    tubelessLbl.text=@"Tubeless";
    tubelessLbl.font=RalewayRegular(appDelegate.font-2);
    [addvechScroll addSubview:tubelessLbl];
    
    tubelessBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tubetyreBtn.frame),tubetyreBtn.frame.origin.y, tubetyreBtn.frame.size.width, 21)];
    tubelessBtn.tag=2;
    [tubelessBtn addTarget:self action:@selector(tyretypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll addSubview:tubelessBtn];
    
    
    submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, CGRectGetMaxY(tubelessBtn.frame)+40, 100, 30)];
    [submitBtn setBackgroundColor:Singlecolor(clearColor)];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.titleLabel.font=RalewayRegular(appDelegate.font-2);
    [submitBtn setTitleColor:RGB(17, 90, 42) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.borderWidth = 0.5;
    submitBtn.layer.masksToBounds = true;
    submitBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [addvechScroll addSubview:submitBtn];
}

- (void)brandAction:(id)sender
{
    
    selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view.window  addSubview:selection];
    
    [selection CreateTableview:vechicleArray withSender:sender  withTitle:@"Please select Brand" setCompletionBlock:^(int tag){
        [self->brandBtn setTitle:[self->vechicleArray objectAtIndex:tag] forState:UIControlStateNormal];
        self->brandStr=[self->vechicleArray objectAtIndex:tag];
        if (self->iscar) {
            self->vechiclemodeldic=[self->json valueForKey:@"carModels"];
        }
        else
        {
            self->vechiclemodeldic=[self->json valueForKey:@"bikeModels"];
        }
        self->vechiclesubArray=[[NSMutableArray alloc]init];
        self->vechiclesubArray=[[self->vechiclemodeldic valueForKey:[self->vechicleArray objectAtIndex:tag]]valueForKey:@"name"];
    }];
}


- (void)modelAction:(id)sender
{
    selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view.window  addSubview:selection];
    
    [selection CreateTableview:vechiclesubArray withSender:sender  withTitle:@"Please select Model" setCompletionBlock:^(int tag){
        [self->modelBtn setTitle:[self->vechiclesubArray objectAtIndex:tag] forState:UIControlStateNormal];
        self->modelStr=[self->vechiclesubArray objectAtIndex:tag];
    }];
}
- (void)vechicleAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    vechicleArray=[[NSMutableArray alloc]init];
    [brandBtn setTitle:@"Brand" forState:UIControlStateNormal];
    [modelBtn setTitle:@"Model" forState:UIControlStateNormal];
    vechilenoTxtfld.text=@"";
    if (selectedtag==2) {
        [fourwheelBtn setBackgroundImage:image(@"car_select") forState:UIControlStateNormal];
        [twowheelBtn setBackgroundImage:image(@"bike_unselect") forState:UIControlStateNormal];
        vechicleArray=[[json valueForKey:@"carBrands"]valueForKey:@"name"];
        iscar=YES;
        typeStr=@"C";
    }
    else
    {
        [fourwheelBtn setBackgroundImage:image(@"car_unselect") forState:UIControlStateNormal];
        [twowheelBtn setBackgroundImage:image(@"bike_select") forState:UIControlStateNormal];
        vechicleArray=[[json valueForKey:@"bikeBrands"]valueForKey:@"name"];
        ypos=CGRectGetMaxY(tubelessBtn.frame)+20;
        iscar=NO;
        typeStr=@"T";
    }
    [self framechange];
}

- (void)tyretypeAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        tubelessImg.image=image(@"radiocheck");
        tubeImg.image=image(@"radiouncheck");
        tyreStr=@"TL";
    }
    else
    {
        tubeImg.image=image(@"radiocheck");
        tubelessImg.image=image(@"radiouncheck");
        tyreStr=@"T";
    }
}

- (void)vechicletypeAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        dieselImg.image=image(@"radiocheck");
        petrolImg.image=image(@"radiouncheck");
        lpgImg.image=image(@"radiouncheck");
        engineStr=@"D";
    }
    else if (selectedtag==3)
    {
        lpgImg.image=image(@"radiocheck");
        dieselImg.image=image(@"radiouncheck");
        petrolImg.image=image(@"radiouncheck");
        engineStr=@"L";
    }
    else
    {
        petrolImg.image=image(@"radiocheck");
        dieselImg.image=image(@"radiouncheck");
        lpgImg.image=image(@"radiouncheck");
        engineStr=@"P";
    }
}

- (void)vechiclejockeyAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        noImg.image=image(@"radiocheck");
        yesImg.image=image(@"radiouncheck");
        jockeyStr=@"0";
    }
    else
    {
        yesImg.image=image(@"radiocheck");
        noImg.image=image(@"radiouncheck");
        jockeyStr=@"1";
    }
}

- (void)framechange
{
    [carView removeFromSuperview];
    if (iscar) {
        
        carView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tubetyreBtn.frame)+20, addvechScroll.frame.size.width, 50)];
        carView.backgroundColor=Singlecolor(clearColor);
        [addvechScroll addSubview:carView];
        
        
        UILabel * engineLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, addvechScroll.frame.size.width-160, 21)];
        engineLbl.text=@"Engine Type";
        engineLbl.textColor=RGB(17, 90, 42);
        engineLbl.textAlignment=NSTextAlignmentLeft;
        engineLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:engineLbl];
        
        
        petrolImg=[[UIImageView alloc]initWithFrame:CGRectMake(engineLbl.frame.origin.x+20, CGRectGetMaxY(engineLbl.frame)+10, 20, 20)];
        petrolImg.image=image(@"radiouncheck");
        [carView addSubview:petrolImg];
        
        UILabel * petrolLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(petrolImg.frame)+5, CGRectGetMaxY(engineLbl.frame)+10, 100, 21)];
        petrolLbl.text=@"Petrol";
        petrolLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:petrolLbl];
        
        
        petrolBtn=[[UIButton alloc]initWithFrame:CGRectMake(engineLbl.frame.origin.x,CGRectGetMaxY(engineLbl.frame)+10, contentView.frame.size.width/3.6, 21)];
        petrolBtn.tag=1;
        [petrolBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
       // [petrolBtn setBackgroundColor:Singlecolor(lightGrayColor)];
        [carView addSubview:petrolBtn];
        
        
        dieselImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(petrolBtn.frame),petrolBtn.frame.origin.y, 20, 20)];
        dieselImg.image=image(@"radiouncheck");
        [carView addSubview:dieselImg];
        
        UILabel * dieselLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dieselImg.frame)+5, CGRectGetMaxY(engineLbl.frame)+10, 100, 21)];
        dieselLbl.text=@"Diesel";
        dieselLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:dieselLbl];
        
        
        dieselBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(petrolBtn.frame),petrolBtn.frame.origin.y, petrolBtn.frame.size.width, 21)];
        dieselBtn.tag=2;
        [dieselBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:dieselBtn];
        
       ////////
        lpgImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dieselBtn.frame),petrolBtn.frame.origin.y, 20, 20)];
        lpgImg.image=image(@"radiouncheck");
        [carView addSubview:lpgImg];
        
        UILabel * lpgLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lpgImg.frame)+5, CGRectGetMaxY(engineLbl.frame)+10, 100, 21)];
        lpgLbl.text=@"Lpg";
        lpgLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:lpgLbl];
        
        
        lpgBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dieselBtn.frame),petrolBtn.frame.origin.y, petrolBtn.frame.size.width, 21)];
        lpgBtn.tag=3;
        [lpgBtn addTarget:self action:@selector(vechicletypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:lpgBtn];
        

        
        UILabel * jockeyLbl=[[UILabel alloc]initWithFrame:CGRectMake(engineLbl.frame.origin.x, CGRectGetMaxY(petrolBtn.frame)+20, petrolBtn.frame.size.width, 30)];
        jockeyLbl.text=@"Jockey Available";
        jockeyLbl.textColor=RGB(17, 90, 42);
        jockeyLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:jockeyLbl];
        
        
        yesImg=[[UIImageView alloc]initWithFrame:CGRectMake(jockeyLbl.frame.origin.x+20, CGRectGetMaxY(jockeyLbl.frame)+10, 20, 20)];
        yesImg.image=image(@"radiouncheck");
        [carView addSubview:yesImg];
        
        UILabel * yesLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yesImg.frame)+10, CGRectGetMaxY(jockeyLbl.frame)+10, 100, 21)];
        yesLbl.text=@"Yes";
        yesLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:yesLbl];
        
        
       UIButton *  yesBtn=[[UIButton alloc]initWithFrame:CGRectMake(jockeyLbl.frame.origin.x+20,CGRectGetMaxY(jockeyLbl.frame)+10, contentView.frame.size.width/3.5, 21)];
        yesBtn.tag=1;
        [yesBtn addTarget:self action:@selector(vechiclejockeyAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:yesBtn];
        
        
        noImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yesBtn.frame),yesBtn.frame.origin.y, 20, 20)];
        noImg.image=image(@"radiouncheck");
        [carView addSubview:noImg];
        
        UILabel * noLbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noImg.frame)+10, CGRectGetMaxY(jockeyLbl.frame)+10, 100, 21)];
        noLbl.text=@"No";
        noLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:noLbl];
        
        
        UIButton * noBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yesBtn.frame),yesBtn.frame.origin.y, yesBtn.frame.size.width, 21)];
        noBtn.tag=2;
        [noBtn addTarget:self action:@selector(vechiclejockeyAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:noBtn];
        
        
        
        UILabel * secondaryLbl=[[UILabel alloc]initWithFrame:CGRectMake(engineLbl.frame.origin.x, CGRectGetMaxY(noBtn.frame)+20, petrolBtn.frame.size.width+20, 30)];
        secondaryLbl.text=@"Spare Tyre";
        secondaryLbl.textColor=RGB(17, 90, 42);
        secondaryLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:secondaryLbl];
        
        
        yes1Img=[[UIImageView alloc]initWithFrame:CGRectMake(secondaryLbl.frame.origin.x+20, CGRectGetMaxY(secondaryLbl.frame)+10, 20, 20)];
        yes1Img.image=image(@"radiouncheck");
        [carView addSubview:yes1Img];
        
        UILabel * yes1Lbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yes1Img.frame)+10, CGRectGetMaxY(secondaryLbl.frame)+10, 100, 21)];
        yes1Lbl.text=@"Yes";
        yes1Lbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:yes1Lbl];
        
        
        UIButton *  yes1Btn=[[UIButton alloc]initWithFrame:CGRectMake(secondaryLbl.frame.origin.x+20,CGRectGetMaxY(secondaryLbl.frame)+10, contentView.frame.size.width/3.5, 21)];
        yes1Btn.tag=1;
        [yes1Btn addTarget:self action:@selector(vechiclesecondaryAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:yes1Btn];
        
        
        no1Img=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yes1Btn.frame),yes1Btn.frame.origin.y, 20, 20)];
        no1Img.image=image(@"radiouncheck");
        [carView addSubview:no1Img];
        
        UILabel * no1Lbl=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(no1Img.frame)+10, CGRectGetMaxY(secondaryLbl.frame)+10, 100, 21)];
        no1Lbl.text=@"No";
        no1Lbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:no1Lbl];
        
        
        UIButton * no1Btn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yes1Btn.frame),yes1Btn.frame.origin.y, yes1Btn.frame.size.width, 21)];
        no1Btn.tag=2;
        [no1Btn addTarget:self action:@selector(vechiclesecondaryAction:) forControlEvents:UIControlEventTouchUpInside];
        [carView addSubview:no1Btn];
        
        imgBtn=[[UIButton alloc]initWithFrame:CGRectMake(engineLbl.frame.origin.x, CGRectGetMaxY(no1Btn.frame)+20, petrolBtn.frame.size.width, 50)];
        [imgBtn addTarget:self action:@selector(uploadicon) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.layer.cornerRadius = 5;
        imgBtn.layer.borderWidth = 0.5;
        imgBtn.layer.masksToBounds = true;
        imgBtn.layer.borderColor = [Singlecolor(lightGrayColor) CGColor];
        [carView addSubview:imgBtn];
        
        
        
        camImg=[[UIImageView alloc]initWithFrame:CGRectMake(imgBtn.frame.size.width/2-12.5, imgBtn.frame.size.height/2-10, 25, 20)];
        camImg.image=image(@"camera");
        [imgBtn addSubview:camImg];
        
        UILabel * uploadLbl=[[UILabel alloc]initWithFrame:CGRectMake(no1Btn.frame.origin.x, CGRectGetMaxY(no1Btn.frame)+25, no1Btn.frame.size.width, 25)];
        uploadLbl.text=@"Upload Image";
        uploadLbl.font=RalewayRegular(appDelegate.font-2);
        [carView addSubview:uploadLbl];
        
        
        
        
        carView.frame=[Utils normalResize:carView.frame expectedFrame:CGRectGetMaxY(imgBtn.frame) withSpace:0];
       // carView.backgroundColor=Singlecolor(grayColor);
        ypos=CGRectGetMaxY(carView.frame)+20;
    }
    submitBtn.frame=CGRectMake(SCREEN_WIDTH/2.0-50, ypos, 100, 30);
    addvechScroll.contentSize=CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(submitBtn.frame)+20);
}

- (void)uploadicon
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Gallery",  nil];
    actionSheet.delegate = self;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}
#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [imgBtn setBackgroundImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    camImg.hidden=YES;
    NSDate * date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hhmm"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    urlpath=[NSString stringWithFormat:@"img_%@.png",stringFromDate];
    
    //convert uiimage to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",urlpath]];
    UIImage * selectedImg=[info objectForKey:UIImagePickerControllerOriginalImage];
    [UIImagePNGRepresentation(selectedImg) writeToFile:filePath atomically:YES];
    fileUrl = [NSURL fileURLWithPath:filePath];
}


#pragma mark - Action sheet delegates

- (void)actionSheet:(UIActionSheet *)popup didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex)
    {
        case 0:
            [self takePicture];
            break;
        case 1:
            [self cameraRoll];
            break;
            
        default:
            break;
    }
}
- (void) takePicture
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"",@"")  message:NSLocalizedString(@"Sorry you dont have camera",@"")  delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"")  otherButtonTitles:nil];
        [altView show];
        return;
    }
    else
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
- (void) cameraRoll
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker =
    [[UIImagePickerController alloc] init];
    //NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    //picker.mediaTypes = mediaTypes;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:NO completion:nil];
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)vechiclesecondaryAction:(id)sender
{
    senderView = sender;
    selectedtag=[senderView tag];
    if (selectedtag==2) {
        no1Img.image=image(@"radiocheck");
        yes1Img.image=image(@"radiouncheck");
        secondaryStr=@"0";
    }
    else
    {
        yes1Img.image=image(@"radiocheck");
        no1Img.image=image(@"radiouncheck");
        secondaryStr=@"1";
    }
}
- (void)submitAction
{
    if ([self isValidEntry])
    {
        [appDelegate startProgressView:self.view];
        NSString *url =[UrlGenerator PostAddVehicle];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
         NSDictionary * login= [Utils NSKeyedUnarchiver:@"logindetails"];
        NSDictionary * dic = @{
                                      @"brand":brandStr,@"model":modelStr,@"userId":[login valueForKey:@"_id"],@"vehicleType":typeStr,@"tyreType":tyreStr,@"vehicleNumber":vechilenoTxtfld.text,@"manufactureYear":@"2018",@"carJockey":jockeyStr,@"engineType":engineStr,@"secondaryTyre":secondaryStr
                                      };
        NSMutableDictionary * parameters=[[NSMutableDictionary alloc]init];
        [parameters setObject:dic forKey:@"data"];
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"response data %@",responseObject);
             
             if ([[responseObject objectForKey:@"status"]integerValue]==0) {
                 NSLog(@"0");
                 [self->appDelegate stopProgressView];
                 [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
             }
             else
             {
                 NSLog(@"1");
                 if (![self->urlpath isEqualToString:@""]) {
                     AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
                     uploadRequest.body = self->fileUrl;
                     uploadRequest.bucket = @"motoserve/MotoServe/Vehicle";
                     uploadRequest.key = self->urlpath;
                     //uploadRequest.contentType = @"image/png";
                     uploadRequest.ACL = AWSS3BucketCannedACLPublicRead;

                     AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];

                     [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                        withBlock:^id(AWSTask *task) {
                                                                            if (task.error != nil) {
                                                                                NSLog(@"%s %@","Error uploading :", uploadRequest.key);
                                                                            }else { NSLog(@"Upload completed"); }
                                                                            return nil;
                                                                        }];
                 }
                 [Utils showErrorAlert:[responseObject objectForKey:@"message"] delegate:nil];
                 [self->appDelegate stopProgressView];
                 HomeViewController * home=[[HomeViewController alloc]init];
                 [self.navigationController pushViewController:home animated:YES];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             [Utils showErrorAlert:@"Check Your Inertnet Connection" delegate:nil];
             [self->appDelegate stopProgressView];
         }];
    }
}

- (BOOL)isValidEntry
{
    if ([vechilenoTxtfld.text length]==0) {
        [Utils showErrorAlert:@"Please Enter Vehicle Number" delegate:nil];
        return NO;
    }
    if ([brandBtn.titleLabel.text isEqualToString:@"Brand"]) {
        [Utils showErrorAlert:@"Please Select Brand" delegate:nil];
        return NO;
    }
    if ([modelBtn.titleLabel.text isEqualToString:@"Model"]) {
        [Utils showErrorAlert:@"Please Select Model" delegate:nil];
        return NO;
    }
    if ([tyreStr isEqualToString:@""]) {
        [Utils showErrorAlert:@"Please Select Tyre type" delegate:nil];
        return NO;
    }
    return YES;
}

@end
