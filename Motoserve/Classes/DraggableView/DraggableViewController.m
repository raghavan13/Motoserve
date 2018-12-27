//
//  DraggableViewController.m
//  Motoserve
//
//  Created by Karthik Baskaran on 26/12/18.
//  Copyright © 2018 Shyam. All rights reserved.
//

#import "DraggableViewController.h"
#import "CPMetaFile.h"
@interface DraggableViewController ()

@end

@implementation DraggableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDesign];
}

- (void)createDesign
{
    UIView * swipeView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3.0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT/3.0)];
    swipeView.backgroundColor=Singlecolor(whiteColor);
    [self.view addSubview:swipeView];
    
    
    UIButton * dragBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    dragBtn.backgroundColor=Singlecolor(whiteColor);
    dragBtn.layer.borderWidth = 1.0f;
    [dragBtn addTarget:self action:@selector(gestureHandlerMethod) forControlEvents:UIControlEventTouchUpInside];
    dragBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [swipeView addSubview:dragBtn];
    
     UIScrollView *  statusScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dragBtn.frame), swipeView.frame.size.width, swipeView.frame.size.height-CGRectGetMaxY(dragBtn.frame))];
    [swipeView addSubview:statusScroll];
    statusScroll.contentSize=CGSizeMake(320, 2000);
    statusScroll.backgroundColor=Singlecolor(redColor);
}
- (void)gestureHandlerMethod
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
