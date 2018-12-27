//
//  NSObject+SS.m
//  EarthWeather
//
//  Created by SebastianSha on 25/06/17.
//  Copyright © 2017 SebastianSha. All rights reserved.
//

#import "NSObject+FL.h"

@implementation NSObject (FL)

+ (BOOL)isCheckNotNULL:(id)parameter
{
    if (![parameter isKindOfClass:[NSNull class]] && parameter != nil && parameter != NULL)
    {
        if ([parameter isKindOfClass:[NSString class]])
        {
            if (![parameter isEqualToString:@""] && ![parameter isEqualToString:@"(null)"] && ![parameter isEqualToString:@"<null>"])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else if ([parameter isKindOfClass:[NSArray class]] || [parameter isKindOfClass:[NSDictionary class]])
        {
            if ([parameter count])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return NO;
    }
}


+ (id)viewControllerForSubView:(UIView *)subView
{
    return [UIView commonFindSuperViewOfView:subView destinationClass:[UIViewController class] withIsSuperClass:YES];
}


+ (id)findSuperViewOfView:(UIView *)subView superViewClass:(Class)superViewClass
{
    return [UIView commonFindSuperViewOfView:subView destinationClass:superViewClass withIsSuperClass:NO];
}


+ (id)findSuperViewOfView:(UIView *)subView superViewSuperClass:(Class)superViewSuperClass
{
    return [UIView commonFindSuperViewOfView:subView destinationClass:superViewSuperClass withIsSuperClass:YES];
}


+ (id)commonFindSuperViewOfView:(UIView *)subView destinationClass:(Class)destinationClass withIsSuperClass:(BOOL)isSuperClassBool
{
    UIResponder * nextResponder = subView;
    
    do
    {
        nextResponder = [nextResponder nextResponder];
        
        BOOL isSuccess = NO;
        
        if (isSuperClassBool)
            isSuccess = ([[nextResponder class] isSubclassOfClass:destinationClass]);
        else
            isSuccess = ([nextResponder isKindOfClass:destinationClass]);
            
        if (isSuccess)
            return nextResponder;
        
    } while (nextResponder != nil);
    
    return nil;
}


+ (void)removeAllSubViewsInView:(UIView *)view
{
    for (UIView * subview in view.subviews)
    {
        [subview removeFromSuperview];
    }
}


+ (CALayer *)findLayerWithTag:(int)layerTag superLayer:(CALayer *)superLayer
{
    for (CALayer * layer in superLayer.sublayers)
    {
        if ([layer.name intValue] == layerTag)
        {
            return layer;
        }
    }
    
    return nil;
}


+ (void)customSelectorWithSelector:(id)selector withTarget:(id)target
{
    SEL selectorInner;
    
    if ([selector isKindOfClass:[NSString class]])
    {
        selectorInner = NSSelectorFromString(selector);
    }
    else if (selector)
    {
        selectorInner = [selector selector];
    }
    else
    {
        return;
    }
    
    if (selectorInner && [target respondsToSelector:selectorInner])
    {
        IMP imp = [target methodForSelector:selectorInner];
        
        id (*func)(id, SEL) = (void *)imp;
        
        func(target, selectorInner);
    }
}

@end
