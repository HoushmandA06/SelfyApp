//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Ali Houshmand on 4/29/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.lines = [@[] mutableCopy];
        self.lineWidth = 2.0;  // default width
        self.lineColor = BLUE_COLOR;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
 
//    CGContextRef context = UIGraphicsGetCurrentContext();  //addellipseinrect, fill path ---> play with CGContext Reference
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGContextSetLineWidth(context, self.lineWidth);
//    
//    CGContextMoveToPoint(context, 50, 50);
//    CGContextAddCurveToPoint(context, 270, 50, 270, 400, 50, 400);
//    CGContextStrokePath(context);
//    
//    CGContextMoveToPoint(context, 100, 100);
//    CGContextFillEllipseInRect(context, CGRectMake(75, 75, 50, 50)); //makes a filled circle
//    CGContextStrokePath(context);
//    CGContextFillRect (context, CGRectMake (50, 150, 100, 200));
    
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
