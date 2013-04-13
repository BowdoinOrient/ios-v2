//
//  OrientSectionView.m
//  orientapp
//
//  Created by Brian Jacobel on 4/13/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientSectionView.h"

@implementation OrientSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)swipe:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        NSLog(@"swipe city bitch");
        [self setNeedsDisplay];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
