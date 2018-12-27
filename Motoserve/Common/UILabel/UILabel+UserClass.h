//
//  UILabel+UserClass.h
//  MyPracticeProject
//
//  Created by Karthick Baskar on 17/08/16.
//  Copyright © 2016 Karthick Baskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UserClass)

- (void)autoHeight:(float )space;
- (void)autowidth:(float )space;
- (void)autoHeightOnly:(float )space;
- (void)centerVertically:(float )space forSuperview:(id)superView;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)height;
- (CGFloat)width;


@end
