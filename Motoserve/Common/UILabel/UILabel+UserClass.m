//
//  UILabel+UserClass.m
//  MyPracticeProject
//
//  Created by Karthick Baskar on 17/08/16.
//  Copyright © 2016 Karthick Baskar. All rights reserved.
//

#import "UILabel+UserClass.h"

@implementation UILabel (UserClass)


- (void)autoHeight:(float )space {
    CGRect frame = self.frame;

    
    CGSize constraint = CGSizeMake(frame.size.width,NSUIntegerMax);
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font };
    
    CGRect rect = [self.text boundingRectWithSize:constraint
                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                    attributes:attributes
                                       context:nil];
    
    if (rect.size.height>frame.size.height) {
        
        frame.size.height = rect.size.height;
        
        [self setFrame:frame];
    }
    
    
}


- (void)autowidth:(float )space {
    CGRect frame = self.frame;
    
    
    CGSize constraint = CGSizeMake(frame.size.width,NSUIntegerMax);
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font };
    
    CGRect rect = [self.text boundingRectWithSize:constraint
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                       attributes:attributes
                                          context:nil];

        
        frame.size.width = rect.size.width;
        
        [self setFrame:frame];
   
    
    
}

- (void)autoHeightOnly:(float )space {
    CGRect frame = self.frame;
    
    
    CGSize constraint = CGSizeMake(frame.size.width,NSUIntegerMax);
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font };
    
    CGRect rect = [self.text boundingRectWithSize:constraint
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                       attributes:attributes
                                          context:nil];
    
    frame.size.height = rect.size.height;
    
    [self setFrame:frame];
    
    
}
- (void)centerVertically:(float )space forSuperview:(id)superView {
   
   UIView *mySuperView  = (UIView *)superView;
   
   CGRect frame = self.frame;
   
   frame.origin.y = mySuperView.frame.size.height/2-frame.size.height/2;
   
   [self setFrame:frame];
   
   
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}


@end
