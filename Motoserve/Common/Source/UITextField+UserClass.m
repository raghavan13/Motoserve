//
//  UITextField+UserClass.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 20/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "UITextField+UserClass.h"

@implementation UITextField (UserClass)

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
