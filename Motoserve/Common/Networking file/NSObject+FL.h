//
//  NSObject+SS.h
//  EarthWeather
//
//  Created by SebastianSha on 25/06/17.
//  Copyright © 2017 SebastianSha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (FL)

//Check for NULL
+ (BOOL)isCheckNotNULL:(id)parameter;

//ViewController For SubView
+ (id)viewControllerForSubView:(UIView *)subView;

//Find SuperView with Kind Of Class
+ (id)findSuperViewOfView:(UIView *)subView superViewClass:(Class)superViewClass;

//Find SuperView with Super Class
+ (id)findSuperViewOfView:(UIView *)subView superViewSuperClass:(Class)superViewSuperClass;

//Support Method For FInd SuperView with Class
+ (id)commonFindSuperViewOfView:(UIView *)subView destinationClass:(Class)destinationClass withIsSuperClass:(BOOL)isSuperClassBool;

//Remove All Subviews in a View
+ (void)removeAllSubViewsInView:(UIView *)view;

//Find Layer With tag
+ (CALayer *)findLayerWithTag:(int)layerTag superLayer:(CALayer *)superLayer;

//CustomSelector
+ (void)customSelectorWithSelector:(id)selector withTarget:(id)target;

@end
