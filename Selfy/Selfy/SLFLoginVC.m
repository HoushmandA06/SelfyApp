//
//  SLFLoginVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/22/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFLoginVC.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"

@interface SLFLoginVC ()

@end

@implementation SLFLoginVC
{
    UITextField * nameField;
    UITextField * pwField;

    UIView * loginForm;

    UITableViewController * SLF;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.view.backgroundColor = [UIColor colorWithRed:0.318f green:0.659f blue:1.000f alpha:1.0f];
        
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
    [user saveInBackground];
    
    NSLog(@"clicking");
    NSLog(@"%@ : %@",nameField.text,pwField.text);
    
    [nameField resignFirstResponder];
    [pwField resignFirstResponder];
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


@end
