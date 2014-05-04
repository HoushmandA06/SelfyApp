//
//  SLFLoginVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/22/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFTableViewController.h"
#import "SLFNewNavigationController.h"
#import "SLFSignUpVC.h"
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

        self.view.backgroundColor = BLUE_COLOR;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 240, 40)];
        titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:24];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"Selfy 1.0";
        [self.view addSubview:titleLabel];
        
        // animate up the login form
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(40,100,240,40)];
        nameField.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
        nameField.layer.cornerRadius = 10;
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        nameField.leftViewMode = UITextFieldViewModeAlways;
        nameField.placeholder = @"Enter username";
        nameField.autocorrectionType = FALSE;
        nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [nameField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [nameField.layer setBorderWidth: 2.0];
        [self.view addSubview:nameField];
        
        [nameField resignFirstResponder]; //this is what makes keyboard go away
        nameField.delegate = self;
        
        pwField = [[UITextField alloc] initWithFrame:CGRectMake(40,160,240,40)];
        pwField.backgroundColor = [UIColor colorWithWhite:.90 alpha:1.0];
        pwField.layer.cornerRadius = 10;
        pwField.secureTextEntry = YES;
        pwField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        pwField.leftViewMode = UITextFieldViewModeAlways;
        [pwField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [pwField.layer setBorderWidth: 2.0];
        pwField.placeholder = @"Enter password";
        
        [self.view addSubview:pwField];
        [pwField resignFirstResponder];
        pwField.delegate = self;
        
        UIButton * current = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-40, 210, 80, 80)];
        [current setImage:[UIImage imageNamed:@"currentuser.png"] forState:UIControlStateNormal];
        current.backgroundColor = [UIColor clearColor];
        current.layer.cornerRadius = 40;
        [current addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:current];
  
        UILabel * newUserQuery = [[UILabel alloc] initWithFrame:CGRectMake(60, 310, 240, 20)];
        newUserQuery.text = @"Don't have an account? Click below:";
        newUserQuery.font = [UIFont fontWithName:@"Chalkduster" size:10];
        newUserQuery.textColor = [UIColor whiteColor];
        [self.view addSubview:newUserQuery];
        
        UIButton * newUser = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-40, 340, 80, 80)];
        [newUser setImage:[UIImage imageNamed:@"newuser.png"] forState:UIControlStateNormal];
        newUser.backgroundColor = [UIColor clearColor];
        newUser.layer.cornerRadius = 40;
        [newUser addTarget:self action:@selector(newUserSignUp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:newUser];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)]; //added this to get rid of keyboard with a touch on frame outside of the above items
        [self.view addGestureRecognizer:tap];
    }
    return self;
}


-(void)newUserSignUp
{
    
    SLFSignUpVC * newUserSignUp = [[SLFSignUpVC alloc] initWithNibName:nil bundle:nil];
    
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newUserSignUp];

    nc.navigationBar.barTintColor = BLUE_COLOR;
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    }];
    
    // will switch views
    
}


- (void)signIn // this will collect info from button -- THIS WILL NEED TO BE EXISTING USER SIGN IN
{
    
//    PFUser * user = [PFUser currentUser];
//    user.username = nameField.text;
//    user.password = pwField.text;
//    
//    nameField.text = nil;
//    pwField.text = nil;
    
    [nameField resignFirstResponder];
    [pwField resignFirstResponder];
    
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    ai.color = [UIColor whiteColor];
    ai.frame = CGRectMake(160, 200, 75.0, 75.0);
    [ai startAnimating];
    [self.view addSubview:ai];   // can set to center by adding it to self.view.frame
    
    [PFUser  logInWithUsernameInBackground:nameField.text password:pwField.text block:^(PFUser *user, NSError *error)
     
    {
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
        } else {
            
            pwField.text = nil;
            
            [ai removeFromSuperview];
            NSString * errorDescription = error.userInfo[@"error"];
    
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];  //need to customize per the specific error message
            [alertView show];
            
        }
        
    }];

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
