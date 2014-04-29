//
//  SLFSettingsButton.h
//  Selfy
//
//  Created by Ali Houshmand on 4/29/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFSettingsButton : UIButton

@property (nonatomic, getter = isSettingsButtonSelected) BOOL settingsButtonSelected;

@property (nonatomic) float lineWidth;

@property (nonatomic) UIColor * lineColor;

@property (nonatomic) NSMutableArray * lines;


@end
