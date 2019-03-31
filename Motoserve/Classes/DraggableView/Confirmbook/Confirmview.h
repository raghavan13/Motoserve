//
//  Confirmview.h
//  Motoserve
//
//  Created by Shyam on 31/03/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef void (^PickupCompleteBlock)(int);
@protocol OutletDelegate <NSObject>

- (void)afterconfirm;
@optional
/* Pickup Outlet get Delegate */


-(void)GetSelectedTag:(int)tag;
-(void)ClosePickupSelection;
-(void)MoveToLogin;

@end

@interface Confirmview : UIView
{
    AppDelegate *appDelegate ;
    UIView *pickupView;
}

@property (nonatomic, assign) id<OutletDelegate> OutletDelegate;

@property (nonatomic, strong) PickupCompleteBlock pickupBlock;

- (id)initWithFrame:(CGRect)frame delegate:(id<OutletDelegate>)delegate;
- (void)CreateOutletView:(NSArray*)selectedPatner;
- (void)RemoveSelectionView;
@end
