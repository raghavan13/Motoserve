//
// RTSpinKitUtils.m
// SpinKit
//
// Copyright (c) 2014 Ramon Torres
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "RTSpinKitUtils.h"

// Animations
#import "RTSpinKitChasingDotsAnimation.h"
#import "RTSpinKitFadingCircleAltAnimation.h"

CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                        CGFloat angle,
                                                        CGFloat x,
                                                        CGFloat y,
                                                        CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

NSObject<RTSpinKitAnimating>* RTSpinKitAnimationFromStyle(RTSpinKitViewStyle style)
{
    switch (style) {
        case RTSpinKitViewStylePlane:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleCircleFlip:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleBounce:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleWave:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleWanderingCubes:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStylePulse:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleChasingDots:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleThreeBounce:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleCircle:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyle9CubeGrid:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleWordPress:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleFadingCircle:
            return [[RTSpinKitChasingDotsAnimation alloc] init];

        case RTSpinKitViewStyleFadingCircleAlt:
            return [[RTSpinKitFadingCircleAltAnimation alloc] init];

        case RTSpinKitViewStyleArc:
            return [[RTSpinKitChasingDotsAnimation alloc] init];
			
		case RTSpinKitViewStyleArcAlt:
			return [[RTSpinKitChasingDotsAnimation alloc] init];

            
        default:
            NSCAssert(NO, @"Unicorns exist");
    }
}
