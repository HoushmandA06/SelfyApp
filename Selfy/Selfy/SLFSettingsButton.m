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
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
 
    CGContextRef context = UIGraphicsGetCurrentContext();  //addellipseinrect, fill path ---> play with CGContext Reference
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.tintColor set];
 
    
////// Three Lines "Settings"
    
//    CGContextMoveToPoint(context, 1, 1);
//    CGContextAddLineToPoint(context, 19, 1);
//    
//    CGContextMoveToPoint(context, 1, 10);
//    CGContextAddLineToPoint(context, 19, 10);
//
//    CGContextMoveToPoint(context, 1, 19);
//    CGContextAddLineToPoint(context, 19, 19);
//    
//    CGContextStrokePath(context);
    
  
////// X "Cancel"
    
    CGContextMoveToPoint(context, 1, 1);
    CGContextAddLineToPoint(context, 19, 19);
    
    CGContextMoveToPoint(context, 1, 19);
    CGContextAddLineToPoint(context, 19, 1);

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
