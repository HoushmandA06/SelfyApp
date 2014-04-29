//
//  SLFSettingsViewController.m
//  Selfy
//
//  Created by Ali Houshmand on 4/29/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFSettingsViewController.h"

@interface SLFSettingsViewController ()

@end

@implementation SLFSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        UILabel * test = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
        test.text = @"TEST TEXT";
        test.font = [UIFont fontWithName:@"Chalkduster" size:10];
        test.textColor = BLUE_COLOR;
        [self.view addSubview:test];
        
    
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
