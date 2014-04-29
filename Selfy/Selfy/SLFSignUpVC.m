//
//  SLFSignUpVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/28/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFSignUpVC.h"
#import "SLFTableViewController.h"
#import "SLFNewNavigationController.h"

@interface SLFSignUpVC ()

@end

@implementation SLFSignUpVC
{
    UITextField * nameField;
    UITextField * pwField;
    UITextField * displayName;
    UITextField * email;
    UIImageView * avatarFrame;
    
    UIView *newForm;
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




-(void)createForm
{
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(20,20,280,self.view.frame.size.height - 40)];
    [self.view addSubview:newForm];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20,50,240,40)];
    nameField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    nameField.layer.cornerRadius = 10;
    nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.placeholder = @"Enter username";
    nameField.autocorrectionType = FALSE;
    nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [newForm addSubview:nameField];
    [nameField resignFirstResponder]; //this is what makes keyboard go away
    nameField.delegate = self;
    
    
    pwField = [[UITextField alloc] initWithFrame:CGRectMake(20,100,240,40)];
    pwField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    pwField.layer.cornerRadius = 10;
    pwField.secureTextEntry = YES;
    pwField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    pwField.leftViewMode = UITextFieldViewModeAlways;
    pwField.placeholder = @"Enter password";
    
    [newForm addSubview:pwField];
    [pwField resignFirstResponder];
    pwField.delegate = self;
    
    
    displayName = [[UITextField alloc] initWithFrame:CGRectMake(20,150,240,40)];
    displayName.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    displayName.layer.cornerRadius = 10;
    displayName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    displayName.leftViewMode = UITextFieldViewModeAlways;
    displayName.placeholder = @"Enter display name";
    displayName.autocorrectionType = FALSE;
    displayName.autocapitalizationType = UITextAutocapitalizationTypeNone;

    [newForm addSubview:displayName];
    [displayName resignFirstResponder]; //this is what makes keyboard go away
    displayName.delegate = self;
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(20,200,240,40)];
    email.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    email.layer.cornerRadius = 10;
    email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    email.leftViewMode = UITextFieldViewModeAlways;
    email.placeholder = @"Enter email address";
    email.autocorrectionType = FALSE;
    email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [newForm addSubview:email];
    [email resignFirstResponder]; //this is what makes keyboard go away
    email.delegate = self;
    
    avatarFrame = [[UIImageView alloc] initWithFrame:CGRectMake(115,250,50,50)]; // need to make it listen to touches
    avatarFrame.layer.cornerRadius = 25;
    avatarFrame.layer.masksToBounds = YES;
    avatarFrame.contentMode = UIViewContentModeScaleToFill;
    avatarFrame.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    avatarFrame.image = [UIImage imageNamed:@"greenmonster"];
    [avatarFrame.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [avatarFrame.layer setBorderWidth: 2.0];
    [newForm addSubview:avatarFrame];
    
    UIButton * submitSignUp = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 240, 40)];
    submitSignUp.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [submitSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitSignUp setTitle:@"Submit" forState:UIControlStateNormal];
    submitSignUp.layer.cornerRadius = 6;
    [submitSignUp addTarget:self action:@selector(submitSignUp) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:submitSignUp];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)]; //added this to get rid of keyboard with a touch on frame outside of the above items
    [self.view addGestureRecognizer:tap];
    
}

-(void)moveNewFormToOriginalPosition
{
    newForm.frame = CGRectMake(20,20, 320, self.view.frame.size.height);
}

-(void)moveNewFormToCaterForVirtualKeyboard
{
    newForm.frame = CGRectMake(20,-50, 320, self.view.frame.size.height);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToCaterForVirtualKeyboard];
    }];
    return YES;
}

-(void)tapScreen // moves frame back down, removes keyboard
{
    [nameField resignFirstResponder];
    [pwField resignFirstResponder];
    [email resignFirstResponder];
    [displayName resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToOriginalPosition];
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField   //now any textField will allow resign keyboard
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToOriginalPosition];
    }];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * cancelSignUp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSignUp)];

    cancelSignUp.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignUp;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createForm];
}

-(void)submitSignUp
{

   
    ///////// NEED PARSE CODE HERE
    
    
    
    
    
    
    
    
//    SLFTableViewController * newTVC = [[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    
//    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newTVC];
//    
//    nc.navigationBar.barTintColor = BLUE_COLOR;
//    nc.navigationBar.translucent = NO;
//    
//    [self.navigationController presentViewController:nc animated:YES completion:^{
//        
//    }];
    
    // ASK JO WHAT IS THE DIFFERENCE BETWEEN ABOVE AND BELOW
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    
    
}

-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];

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
