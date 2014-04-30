//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Ali Houshmand on 4/30/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)toggle
{
    self.toggled = !self.toggled;
    
//    self.toggled = ![self isToggled];   2 ways of doing same as above
//    [self setToggled:![self isToggled]];
    
}

-(void)setToggled:(BOOL)toggled //setter
{
    _toggled = toggled;  // if we did not have this the toggle method would return nil
    
    self.alpha = 0.0; // usings this to fade the x and |||
    
    [self setNeedsDisplay];  // redraws this view by calling drawRect (i.e. the button)
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:nil];
    

}

-(void)drawRect:(CGRect)rect
{
    float pad = 1.0;
    float w = rect.size.width - pad;
    float h = rect.size.height - pad;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextClearRect(context, rect); //gets rid of the old button drawings
    
    [self.tintColor set];
    
    if([self isToggled])
    {
        if(self.toggledTintColor != nil) [self.toggledTintColor set];
        
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, h);
        
        CGContextMoveToPoint(context, w, pad);
        CGContextAddLineToPoint(context, pad, h);
    } else {
        
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, pad);
        
        CGContextMoveToPoint(context, pad, h/2);
        CGContextAddLineToPoint(context, w, h/2);
        
        CGContextMoveToPoint(context, pad, h);
        CGContextAddLineToPoint(context, w, h);
    }
        CGContextStrokePath(context);
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
