//
//  SLFLoginVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/22/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFTableViewController.h"
#import "SLFLoginVC.h"
#import <Parse/Parse.h>


@interface SLFLoginVC ()

@end

@implementation SLFLoginVC
{
    UITextField * nameField;
    UITextField * pwField;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.view.backgroundColor = [UIColor orangeColor];
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(40,100,240,40)];
        nameField.backgroundColor = [UIColor lightGrayColor];
        nameField.layer.cornerRadius = 10;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        nameField.leftViewMode = UITextFieldViewModeAlways;
        nameField.placeholder = @"Enter username";
        
        [self.view addSubview:nameField];
        [nameField resignFirstResponder]; //this is what makes keyboard go away
        nameField.delegate = self;
        
        pwField = [[UITextField alloc] initWithFrame:CGRectMake(40,160,240,40)];
        pwField.backgroundColor = [UIColor lightGrayColor];
        pwField.layer.cornerRadius = 10;
        pwField.secureTextEntry = YES;
        pwField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        pwField.leftViewMode = UITextFieldViewModeAlways;
        pwField.placeholder = @"Enter password";
        
        [self.view addSubview:pwField];
        [pwField resignFirstResponder];
        pwField.delegate = self;
        
        //will need to resign first reponder for keyboard to go away, DO THIS LATER
        
        UIButton * submit = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-40, 210, 80, 80)];
        [submit setImage:[UIImage imageNamed:@"newuser.png"] forState:UIControlStateNormal];
        submit.backgroundColor = [UIColor clearColor];
        submit.layer.cornerRadius = 40;
        [submit addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submit];
  
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)]; //added this to get rid of keyboard with a touch on frame outside of the above items
        [self.view addGestureRecognizer:tap];

    
        
    }
    return self;
}

- (void)newUser // this will collect info from button
{
    
    PFUser * user = [PFUser currentUser];
    user.username = nameField.text;
    user.password = pwField.text;
    
    nameField.text = nil;
    pwField.text = nil;
    
        
    [nameField resignFirstResponder];
    [pwField resignFirstResponder];
    
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    ai.center = self.view.center;
    ai.color = [UIColor blueColor];
    ai.frame = CGRectMake(160, 200, 75.0, 75.0);
    [ai startAnimating];
    [self.view addSubview:ai];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      
    if (error == nil)
      {
          self.navigationController.navigationBarHidden = NO;
          self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
          
          
          
      } else {
        
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"User error" message:@"Unable to Add User" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
          [alertView show];
          
          [ai removeFromSuperview];
          
          // error.userInfo[@"error"]
      }
          
      }];

    NSLog(@"clicking");
    NSLog(@"%@ : %@",nameField.text,pwField.text);

}


-(void)tapScreen // removes keyboard when clicking outside of fields or buttons
{
    [pwField resignFirstResponder];
    [nameField resignFirstResponder];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        newForm.frame = CGRectMake(0,0, 320, self.view.frame.size.height);
//        
//    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
    return YES;
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
