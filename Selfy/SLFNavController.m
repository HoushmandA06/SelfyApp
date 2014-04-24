//
//  SLFNavController.m
//  Selfy
//
//  Created by Ali Houshmand on 4/24/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFNavController.h"

@interface SLFNavController ()

@end

@implementation SLFNavController
{
    //UIViewController * TVC;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar removeFromSuperview];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
