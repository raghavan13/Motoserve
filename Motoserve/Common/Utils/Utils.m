//
//  Utils.m
//  CIty Spot
//
//  Created by Karthik Baskaran on 19/12/15.
//  Copyright © 2015 K2B Solutions. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"

@implementation Utils

/* Save and retrieve string */
+ (void) saveStringData:(NSString *)stringData key:(NSString *)key
{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:stringData forKey:key];
    [userDef synchronize];
}

+ (NSString *) retrieveSavedStringData:(NSString *)key
{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    return [userDef objectForKey:key];
}

+ (void)removeSavedStringData:(NSString *)key
{
    NSUserDefaults * removeUD = [NSUserDefaults standardUserDefaults];
    [removeUD removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize ];
}

+ (void) archieveRootObject:(NSDictionary *)userData forkey:(NSString *)key
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData];
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:data forKey:key];
    [userDef synchronize];
}

+ (NSDictionary *)NSKeyedUnarchiver:(NSString *)key
{
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSDictionary *getUserDetails = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    return getUserDetails;
}



#pragma mark - Resizeable Font

//My Own Method

+ (UIFont *)getResizeableFont:(UIFont *)currentFont {
    
    CGFloat sizeScale = 1;
    
    if ([self getCurrentDevice]==iPhone6Plus )
    {
        sizeScale = 1.6;
    }
    else if ([self getCurrentDevice]==iPhone6 )
    {
        sizeScale = 1.2;
    }
    else
    {
        sizeScale = 1.4;
    }
    return [currentFont fontWithSize:(currentFont.pointSize * sizeScale)];
}


#pragma mark - Check not null

+ (BOOL)isCheckNotNULL:(id)parameter
{
    if (![parameter isKindOfClass:[NSNull class]] && parameter != NULL && parameter != nil) {
        if ([parameter isKindOfClass:[NSString class]]) {
            if (![parameter isEqualToString:@""] && ![parameter isEqualToString:@"(null)"]) {
                return YES;
            }
        }
        else
            return YES;
    }
    return NO;
}

#pragma mark - Get Current Device Info

+ (currentDevice)getCurrentDevice
{
    if (([[UIScreen mainScreen] bounds].size.height == 480 && [[UIScreen mainScreen] bounds].size.width == 320) || ([[UIScreen mainScreen] bounds].size.width == 480 && [[UIScreen mainScreen] bounds].size.height == 320)) {
        return iPhone4;
    }
    else if (([[UIScreen mainScreen] bounds].size.height == 568 && [[UIScreen mainScreen] bounds].size.width == 320) || ([[UIScreen mainScreen] bounds].size.width == 568 && [[UIScreen mainScreen] bounds].size.height == 320))
        return iPhone5;
    else if (([[UIScreen mainScreen] bounds].size.height == 667 && [[UIScreen mainScreen] bounds].size.width == 375) || ([[UIScreen mainScreen] bounds].size.width == 667 && [[UIScreen mainScreen] bounds].size.height == 375))
        return iPhone6;
    else if (([[UIScreen mainScreen] bounds].size.height == 736 && [[UIScreen mainScreen] bounds].size.width == 414) || ([[UIScreen mainScreen] bounds].size.width == 736 && [[UIScreen mainScreen] bounds].size.height == 414))
        return iPhone6Plus;
    else if (([[UIScreen mainScreen] bounds].size.height == 768 && [[UIScreen mainScreen] bounds].size.width == 1024) || ([[UIScreen mainScreen] bounds].size.width == 1024 && [[UIScreen mainScreen] bounds].size.height == 768))
        return iPad;
    
    return 0;
}

//My Own Method

+ (CGRect )getSizeofFont:(NSString *)forValue theFrame:(CGRect )frame withSpace:(float)space

{
    
    CGSize labelSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width-40,CGFLOAT_MAX);
    
    CGSize textSizeForLabel =GetresizeFont(labelSize, forValue);
    
    float labelHeight =ceilf(textSizeForLabel.height);
    
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =labelHeight+space;
    newDescLblFrame.origin.y=frame.origin.y;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}


+ (float )getHeightForText:(NSString *)forValue withFont:(UIFont *)font withSpace:(float)space

{
    
    CGSize labelSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width-40,CGFLOAT_MAX);
    
    CGSize textSizeForLabel =getHeightForFont(labelSize, forValue, font);
    
    float labelHeight =ceilf(textSizeForLabel.height);
    
    return labelHeight+space;
}


+ (CGRect )getSizeofAttributeFont:(NSAttributedString *)forValue theFrame:(CGRect )frame
{
    
    CGRect paragraphRect =
    [forValue boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                           context:nil];
    
    float labelHeight =ceilf(paragraphRect.size.height);
    
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =labelHeight+10;
    newDescLblFrame.origin.y=frame.origin.y;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

+ (CGRect )getSizeofWidth:(CGRect )forValue theFrame:(CGRect )frame WithSpace:(float )Space
{
    
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =frame.size.height;
    newDescLblFrame.origin.y=frame.origin.y;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=forValue.size.width+Space;
    
    return newDescLblFrame;
}


+ (CGRect )normalResize:(CGRect )frame expectedFrame:(float )expectFrame withSpace:(float)extraSpace
{
    
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =expectFrame+extraSpace;
    newDescLblFrame.origin.y=frame.origin.y;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

+ (CGRect )OrderAlign:(CGRect )frame expectedFrame:(float )expectFrame withSpace:(float)extraSpace
{
    
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =frame.size.height;
    newDescLblFrame.origin.y=expectFrame+extraSpace;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

+ (CGRect )AlignResize:(CGRect )frame expectedFrame:(CGRect )expectFrame withSpace:(float)extraSpace
{
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =frame.size.height;
    newDescLblFrame.origin.y=expectFrame.origin.y+expectFrame.size.height+extraSpace;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

+ (CGRect )getEqualHeight:(CGRect )frame expectedFrame:(CGRect )expectFrame withExtraSpace:(float)space
{
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =expectFrame.size.height+space;
    newDescLblFrame.origin.y=expectFrame.origin.y;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

//SHOW AND HIDE FOOTER BUTTON ANIMATIONS

+(void)ShowFooterBtn:(UIView *)theView theBtn:(UIView *)menusView transView:(UIView *)transview{
    
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         CGRect deliveryFrame=theView.frame;
                         
                         deliveryFrame.origin.y-=menusView.frame.size.height;
                         theView.frame=deliveryFrame;
                         
                         CGRect orderFrame=menusView.frame;
                         orderFrame.origin.y=theView.frame.origin.y+theView.frame.size.height;
                         menusView.frame=orderFrame;
                         
                         [theView setAlpha:0.0f];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [transview setAlpha:1.0f];
                     }
     ];
    
}

+(void)HideFooterBtn:(UIView *)theView theBtn:(UIView *)menusView transView:(UIView *)transview{
    
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         CGRect deliveryFrame=theView.frame;
                         
                         deliveryFrame.origin.y+=menusView.frame.size.height;
                         theView.frame=deliveryFrame;
                         
                         CGRect orderFrame=menusView.frame;
                         orderFrame.origin.y=theView.frame.origin.y+theView.frame.size.height;
                         menusView.frame=orderFrame;
                         
                         [theView setAlpha:1.0f];
                         [transview setAlpha:0.0f];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [transview removeFromSuperview];
                     }
     ];
}


#pragma mark FoodPriceDetailsView Page Animation


+(void)ShowBounceAnimationBtn:(UIView *)theView{
    
    theView.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{theView.alpha = 1.0;}];
    
    theView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.5],
                              [NSNumber numberWithFloat:1.2],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = kAnimateInDuration;
    bounceAnimation.removedOnCompletion = NO;
    [theView.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    theView.layer.transform = CATransform3DIdentity;
    
}

+(void)RemoveBounceAnimationBtn:(UIView *)theView superView:(UIView *)superView{
    
    
    [UIView animateWithDuration:kAnimateOutDuration animations:^{
        
        theView.alpha = 0.0;
        superView.alpha = 0.0;
        
    } completion:^(BOOL finished){
        [superView removeFromSuperview];
    }];
    
    theView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:1.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.5],
                              [NSNumber numberWithFloat:0.0], nil];
    bounceAnimation.duration = kAnimateOutDuration;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.delegate = self;
    [theView.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    theView.layer.transform = CATransform3DIdentity;
}

+(void)ShakeandBlink:(id)sender{
    
    UITextField *textField=(UITextField *)sender;
    
    CALayer *lbl = [textField layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.1];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
    
    
    textField.layer.borderWidth = 2.0;
    CABasicAnimation *width = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    width.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    width.toValue = (__bridge id _Nullable)[UIColor redColor].CGColor;
    width.duration = 0.5;
    width.autoreverses = true;
    textField.layer.borderColor = [UIColor clearColor].CGColor;
    [textField.layer addAnimation:width forKey:@""];
}


+(NSString*)GlobalDateConvert:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat
{
    NSString *dateString = dateValue;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:inputFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:outputFormat];
    NSString *newDateString = [dateFormatter stringFromDate:date];
    
    //    NSLog(@"GlobalDateConvert-->%@",newDateString);
    return newDateString;
}

+(NSString*)UpcomingDateConvert:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat
{
    NSString *dateString = dateValue;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:inputFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:outputFormat];
    NSString *newDateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"MM"];
    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *upcomingDateString = [dateFormatter stringFromDate:date];
    
    
    //    NSLog(@"string-->%@",string);
    //    NSLog(@"GlobalDateConvert-->%@",upcomingDateString);
    
    if ([upcomingDateString intValue]>[string intValue]) {
        
        //        NSLog(@"get upcoming-->%@",[NSString stringWithFormat:@"%@/%@",newDateString,upcomingDateString]);
        return [NSString stringWithFormat:@"%@/%@",newDateString,upcomingDateString];
    }
    return newDateString;
}

+(NSDate*)CalenderDateConverter:(NSString*)dateValue inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat
{
    NSString *dateString = dateValue;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:inputFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:outputFormat];
    NSString *newDateString = [dateFormatter stringFromDate:date];
    
    NSDate *calenderDate = [dateFormatter dateFromString:newDateString];
    
    //    NSLog(@"CalenderDateConverter-->%@",calenderDate);
    return calenderDate;
}

+(NSAttributedString *)getSpacingforString:(NSString *)theString withSpace:(float)space{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:theString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:space];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [theString length])];
    
    return attributedString;
    
}

+(NSArray *)removeNullfromArray:(NSArray *)myArray
{
    NSMutableArray *NullCheck=[[NSMutableArray alloc]init];
    
    for (int i=0;i<myArray.count;i++) {
        
        NSLog(@"NullCheck--->%@",[myArray objectAtIndex:i]);
        
        if ([Utils isCheckNotNULL:[myArray objectAtIndex:i]]) {
            
            [NullCheck addObject:[myArray objectAtIndex:i]];
        }
    }
    return NullCheck;
}

+(NSArray *)sortArrayValue:(NSString *)forKey withSort:(BOOL)sorting ArrayData:(NSArray*)myData{
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:forKey ascending:sorting selector:@selector(caseInsensitiveCompare:)];
    
    return [myData sortedArrayUsingDescriptors:@[sortDescriptor]];
}

+(NSString *)CapitalizeString:(NSString *)str{
    
    NSArray *arr = [str componentsSeparatedByString:@","];
    
    NSMutableArray *mutArr=[[NSMutableArray alloc]init];
    
    for (NSString * myString in arr) {
        
        NSString *capitalizedString = [myString capitalizedString];
        
        [mutArr addObject:capitalizedString];
    }
    
    return [mutArr componentsJoinedByString:@","];
}

+(NSString *)EncodeArray:(NSArray *)myArray{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myArray
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+(NSAttributedString *)CartAttribute:(NSString *)StringData
{
    NSString *theString1=[Utils CapitalizeString:StringData];
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:theString1];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.alignment = NSTextAlignmentLeft;
    [paragraphStyle1 setLineSpacing:.5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [theString1 length])];
    
    return attributedString1;
}

+ (CGRect )getCenterofScreen:(CGRect )frame expectedFrame:(CGRect )expectFrame withSpace:(float)extraSpace
{
    CGRect newDescLblFrame;
    
    newDescLblFrame.size.height =frame.size.height;
    newDescLblFrame.origin.y=expectFrame.size.height/2-frame.size.height/2;
    newDescLblFrame.origin.x=frame.origin.x;
    newDescLblFrame.size.width=frame.size.width;
    
    return newDescLblFrame;
}

+ (float )getwidthofText:(NSString *)forValue withFont:(UIFont *)font withSpace:(float)space

{
    
    CGSize labelSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width-40,CGFLOAT_MAX);
    
    CGSize textSizeForLabel =getHeightForFont(labelSize, forValue, font);
    
    float labelHeight =ceilf(textSizeForLabel.width);
    
    return labelHeight+space;
}

+(NSMutableAttributedString *)MakeFontAttributeString:(NSString *)data font:(UIFont *)font withAppend:(NSString *)append{
    
    if ([Utils isCheckNotNULL:append]) {
        
        data=[NSString stringWithFormat:@"%@ %@",append,data];
        
    }
    
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:data attributes: arialDict];
    
    return aAttrString;
    
}

//+ (BOOL)validateEmailWithString:(NSString*)email
//{
//    NSString *emailRegex = @"^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}
+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//+ (void) SaveCurrentPrinter:(Printer *)Printer key:(NSString *)key
//{
//    NSMutableArray *pArray=[[NSMutableArray alloc] init];
//    [pArray addObject:Printer];
//    NSLog(@"pArray=%@",pArray);
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pArray];
//    NSLog(@"data=%@",data);
//    
//    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
//    [userDef setObject:data forKey:key];
//    NSLog(@"userDef=%@",key);
//    [userDef synchronize];
//    
//}
//+ (Printer *) retrieveCurrentPrinter:(NSString *)key
//{
//
//    NSData *PrinterData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//
//    if (PrinterData !=nil) {
//
//        NSArray   *PrinterArrays = [NSKeyedUnarchiver unarchiveObjectWithData:PrinterData];
//
//        NSLog(@"PrinterArrays=%@",PrinterArrays);
//
//        Printer *getPrinter =(Printer*) [PrinterArrays objectAtIndex:0];
//        return getPrinter;
//    }
//
//    return nil;
//
//}

+(NSString *)ConvertHtml:(NSString *)string{
    
    NSString * htmlString = string;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    NSArray  *ErrArray=[[NSArray alloc]initWithArray:[[attrStr string] componentsSeparatedByString:@"\n"]];
    
    
    NSString *errMsg;
    
    if ([ErrArray count]>0) {
        
        errMsg=[ErrArray objectAtIndex:0];
        
    }else{
        
        errMsg=@"Unknown error Occured";
    }
    
    return errMsg;
    
}
+ (BOOL)isIpad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? YES : NO;
}

+(UIView *)CreateHeaderBarWithSearch:(UIView *)InView HeaderTitle:(NSString *)HeaderTitle  IsText:(BOOL)IsTitle Menu:(BOOL)IsMenu IsCart:(BOOL)IsCart LeftClass:(id)LeftClass LeftSelector:(SEL)LeftSelector  RightClass:(id)RightClass RightSelector:(SEL)RightSelector WithCartCount:(NSString *)CartCount  SearchClass:(id)SearchClass SearchSelector:(SEL)SearchSelector ShowSearch:(BOOL)ShowSearch HeaderTap:(id)HeaderTap TapAction:(SEL)TapAction{
    UIView * navHeader=[[UIView alloc]init];//WithFrame:CGRectMake(0,0, InView.frame.size.width, IS_IPHONEX?90:70)];
    navHeader.backgroundColor=RGB(0, 89, 42);
    navHeader.userInteractionEnabled=YES;
    [InView addSubview:navHeader];
    
    
    navHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [navHeader.topAnchor constraintEqualToAnchor:InView.topAnchor constant:0].active=YES;
    [navHeader.leftAnchor constraintEqualToAnchor:InView.leftAnchor constant:0].active=YES;
    [navHeader.rightAnchor constraintEqualToAnchor:InView.rightAnchor constant:0].active=YES;
    [navHeader.heightAnchor constraintEqualToConstant:IS_IPHONEX?90:70].active=YES;
    
    AppDelegate *  appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UILabel* headerLbl;
    if (IsTitle) {
        headerLbl = [[UILabel alloc]init];
        headerLbl.text = HeaderTitle ;
        [navHeader addSubview:headerLbl];
//        if ([headerLbl.text isEqualToString:@"Motosserve"]) {
//            //headerLbl.frame=CGRectMake((appDelegate.wVal/5)+10, IS_IPHONEX?40:20, appDelegate.wVal-(appDelegate.wVal/4.5)*2, 50);
//            headerLbl.translatesAutoresizingMaskIntoConstraints = NO;
//            [headerLbl.topAnchor constraintEqualToAnchor:InView.topAnchor constant:IS_IPHONEX?40:20].active=YES;
//            [headerLbl.leftAnchor constraintEqualToAnchor:InView.leftAnchor constant:(appDelegate.wVal/5)+10].active=YES;
//            [headerLbl.widthAnchor constraintEqualToConstant:(appDelegate.wVal/4.5)*2].active=YES;
//            [headerLbl.heightAnchor constraintEqualToConstant:50].active=YES;
//            headerLbl.textAlignment = NSTextAlignmentLeft;
//        }
//        else
//        {
           // headerLbl.frame=CGRectMake((appDelegate.wVal/5), IS_IPHONEX?40:20, appDelegate.wVal-(appDelegate.wVal/4.5)*2, 50);
            headerLbl.translatesAutoresizingMaskIntoConstraints = NO;
            [headerLbl.topAnchor constraintEqualToAnchor:InView.topAnchor constant:IS_IPHONEX?30:20].active=YES;
            [headerLbl.centerXAnchor constraintEqualToAnchor:navHeader.centerXAnchor constant:0].active=YES;
            [headerLbl.widthAnchor constraintEqualToConstant:(appDelegate.wVal/4.5)*2].active=YES;
            [headerLbl.heightAnchor constraintEqualToAnchor:navHeader.heightAnchor constant:-20].active=YES;
            
            
            headerLbl.textAlignment = NSTextAlignmentCenter;
       // }
        headerLbl.textColor =  Singlecolor(whiteColor);
        headerLbl.layer.masksToBounds = YES;
        headerLbl.backgroundColor =Singlecolor(clearColor);
        
        
        headerLbl.font=RalewayLight(appDelegate.font+2);
    }
    UIButton *MenuBtn = [[UIButton alloc]init];
    [navHeader addSubview:MenuBtn];
   // MenuBtn.frame = CGRectMake(0,IS_IPHONEX?30:20,appDelegate.wVal/7,navHeader.frame.size.height-20);
    MenuBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [MenuBtn.topAnchor constraintEqualToAnchor:InView.topAnchor constant:IS_IPHONEX?30:20].active=YES;
    [MenuBtn.leftAnchor constraintEqualToAnchor:InView.leftAnchor constant:0].active=YES;
    [MenuBtn.widthAnchor constraintEqualToConstant:appDelegate.wVal/7].active=YES;
    [MenuBtn.heightAnchor constraintEqualToAnchor:navHeader.heightAnchor constant:-20].active=YES;
    
    MenuBtn.backgroundColor=Singlecolor(clearColor);
    
    UIImageView *menuImg=[[UIImageView alloc]init];
    [MenuBtn addSubview:menuImg];
        if ([headerLbl.text isEqualToString:@"Motosserve"]) {
            menuImg.image=image(@"nav_logo");
           // menuImg.frame=CGRectMake(10, navHeader.frame.size.height/2-25, 75,32);

            menuImg.translatesAutoresizingMaskIntoConstraints = NO;
            [menuImg.centerYAnchor constraintEqualToAnchor:MenuBtn.centerYAnchor constant:0].active=YES;
            [menuImg.leftAnchor constraintEqualToAnchor:MenuBtn.leftAnchor constant:10].active=YES;
            [menuImg.widthAnchor constraintEqualToConstant:75].active=YES;
            [menuImg.heightAnchor constraintEqualToConstant:32].active=YES;
        }
        else
        {
            menuImg.image=image(@"back");
           // menuImg.frame=CGRectMake(10, navHeader.frame.size.height/2-22, 22,17);
            menuImg.translatesAutoresizingMaskIntoConstraints = NO;
            [menuImg.centerYAnchor constraintEqualToAnchor:MenuBtn.centerYAnchor constant:0].active=YES;
            [menuImg.leftAnchor constraintEqualToAnchor:MenuBtn.leftAnchor constant:10].active=YES;
            [menuImg.widthAnchor constraintEqualToConstant:22].active=YES;
            [menuImg.heightAnchor constraintEqualToConstant:17].active=YES;
        }
        [MenuBtn addTarget:LeftClass action:LeftSelector forControlEvents:UIControlEventTouchUpInside];

    if (IsCart) {
        UIButton *CartBtn = [[UIButton alloc]init];
        [navHeader addSubview:CartBtn];
        //CartBtn.frame = CGRectMake(appDelegate.wVal-35,navHeader.frame.size.height/2,25,15);
        CartBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [CartBtn.topAnchor constraintEqualToAnchor:InView.topAnchor constant:IS_IPHONEX?60:35].active=YES;
        [CartBtn.leftAnchor constraintEqualToAnchor:navHeader.leftAnchor constant:appDelegate.wVal-35].active=YES;
        [CartBtn.widthAnchor constraintEqualToConstant:25].active=YES;
        [CartBtn.heightAnchor constraintEqualToConstant:15].active=YES;
        CartBtn.backgroundColor=Singlecolor(clearColor);
        //[CartBtn addTarget:RightClass action:RightSelector forControlEvents:UIControlEventTouchUpInside];
        CartBtn.tag=1000;
        [CartBtn setImage:image(@"menu") forState:UIControlStateNormal];
        [CartBtn addTarget:[DEMOLeftMenuViewController alloc] action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return navHeader;
}

+ (void) showErrorAlert:(NSString *)strMessage delegate:(id)_delegate {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
                                                         message:strMessage
                                                        delegate:_delegate
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil,nil];
    [errorAlert show];
}

@end
