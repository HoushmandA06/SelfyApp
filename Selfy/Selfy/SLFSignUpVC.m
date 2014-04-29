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
    UIView *newForm;
    UITextField * nameField;
    UITextField * displayNameField;
    UITextField * pwField;
    UITextField * emailField;
    UIImageView * avatar;
    
    NSArray * fields;
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.view.backgroundColor = [UIColor whiteColor]; //put this in to make transition from login to sign up not show old view in animation
    }
    return self;
}



-(void)createForm
{
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(20,20,280,self.view.frame.size.height - 40)];
    [self.view addSubview:newForm];
    
    
    
    fields = @[@"Username", @"Password", @"Display Name", @"Email"];
    
    for (NSString * name in fields)
    {
        NSInteger index = [fields indexOfObject:name];
       
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(20,index * 50,240,40)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        textField.layer.cornerRadius = 10;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.placeholder = @"Enter username";
        textField.autocorrectionType = FALSE;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
        [textField resignFirstResponder]; //this is what makes keyboard go away
        [newForm addSubview:textField];
    }
        
    
    
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
    
    
    displayNameField = [[UITextField alloc] initWithFrame:CGRectMake(20,150,240,40)];
    displayNameField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    displayNameField.layer.cornerRadius = 10;
    displayNameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    displayNameField.leftViewMode = UITextFieldViewModeAlways;
    displayNameField.placeholder = @"Enter display name";
    displayNameField.autocorrectionType = FALSE;
    displayNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    [newForm addSubview:displayNameField];
    [displayNameField resignFirstResponder]; //this is what makes keyboard go away
    displayNameField.delegate = self;
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(20,200,240,40)];
    emailField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    emailField.layer.cornerRadius = 10;
    emailField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
    emailField.leftViewMode = UITextFieldViewModeAlways;
    emailField.placeholder = @"Enter email address";
    emailField.autocorrectionType = FALSE;
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [newForm addSubview:emailField];
    [emailField resignFirstResponder]; //this is what makes keyboard go away
    emailField.delegate = self;
    
    avatar = [[UIImageView alloc] initWithFrame:CGRectMake(115,250,50,50)]; // need to make it listen to touches
    avatar.layer.cornerRadius = 25;
    avatar.layer.masksToBounds = YES;
    avatar.contentMode = UIViewContentModeScaleToFill;
    avatar.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    avatar.image = [UIImage imageNamed:@"greenmonster"];
    [avatar.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [avatar.layer setBorderWidth: 2.0];
    [newForm addSubview:avatar];
    
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
    [emailField resignFirstResponder];
    [displayNameField resignFirstResponder];
    
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

-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createForm];
}

-(void)submitSignUp
{

   
///////// NEED PARSE CODE HERE
    
/*
    NSData * imageData = UIImagePNGRepresentation(avatarFrame.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData]; //file name on Parse, you set it
    PFObject * newSignUp = [PFObject objectWithClassName:@"user"];
    newSignUp[@"image"] = imageFile;  //creates a new row with column "image" and data "imageFile"
    
    newSignUp[@"name"] = nameField.text;
    newSignUp[@"password"] = pwField.text;
    newSignUp[@"display"] = displayName.text;
    newSignUp[@"email"] = email.text;
    newSignUp[@"parent"] = [PFUser currentUser];
    
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%u", succeeded);
        
    }];
*/
    
    
// ASK JO WHAT IS THE DIFFERENCE BETWEEN TWO TVC SWITCHING METHODS BELOW
   
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
    
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
        
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
