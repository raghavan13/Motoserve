//
//  DEMOMenuViewController.h
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
@interface DEMOLeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *appDelegate;
}
@property (nonatomic, strong) UIScrollView        * abtScroll;
@end
