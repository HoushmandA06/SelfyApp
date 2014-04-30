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
#import <Parse/Parse.h>



@interface SLFSignUpVC ()

@end

@implementation SLFSignUpVC
{
    UIView *newForm;
    
//    UITextField * nameField;
//    UITextField * displayNameField;
//    UITextField * pwField;
//    UITextField * emailField;
    
    UIImageView * avatar;
    
    NSArray * fieldNames;
    NSMutableArray * fields;

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
    
    
    
    fieldNames = @[@"Username", @"Password", @"Display Name", @"Email"];
    
    fields = [@[]mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
       
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(20,(index * 50)+50,240,40)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        textField.layer.cornerRadius = 10;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,30)]; // puts the cursor a set amt right of the textfield
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.placeholder = name;
        textField.autocorrectionType = FALSE;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
        [textField resignFirstResponder]; //this is what makes keyboard go away
        
        [fields addObject:textField];
        
        [newForm addSubview:textField];
        
    }
    
    //// replaced below with a for loop above
    /*
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
    */
    
    avatar = [[UIImageView alloc] initWithFrame:CGRectMake(115,250,50,50)]; // need to make it listen to touches
    avatar.layer.cornerRadius = 25;
    avatar.layer.masksToBounds = YES;
    avatar.contentMode = UIViewContentModeScaleToFill;
    avatar.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    avatar.image = [UIImage imageNamed:@"greenmonster"];
    [avatar.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [avatar.layer setBorderWidth: 2.0];
    [newForm addSubview:avatar];
    
    UIButton * submitSignUp = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 240, 40)];  //[fieldNames count] * 50
    submitSignUp.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [submitSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitSignUp setTitle:@"Submit" forState:UIControlStateNormal];
    submitSignUp.layer.cornerRadius = 6;
    [submitSignUp addTarget:self action:@selector(submitSignUp) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:submitSignUp];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]; //added this to get rid of keyboard with a touch on frame outside of the above items
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

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField  // method to force user to fill out fields sequentially
//{
//    
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex = [fields count];
//    
//    for (UITextField * textFieldItem in fields)
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//        
//        if(emptyIndex == [fields count])
//        {
//            if([textFieldItem.text isEqualToString:@""])
//            {
//             emptyIndex = fieldIndex;
//            }
//        }
//    }
//    
//    NSLog(@"textFieldIndex: %d",(int)index);
//    NSLog(@"emptyIndex : %d",(int)emptyIndex);
//    
//    if(index <= emptyIndex) return YES;
//    return NO;
//}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
//    NSLog(@"%.00f",self.view.frame.size.height);
//    
//    int extraSlide = 0;
//    
//    if(self.view.frame.size.height > 500)  // 504h for 4"
//    {
//        extraSlide = 107;
//    } else {                               // 416 h for 3.5"
//        
//        NSInteger index = [fields indexOfObject:textField];
//        extraSlide = index * 25 + 65;
//    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToCaterForVirtualKeyboard];
    }];
    
    //   newForm.frame = CGRectMake(20,-50, 320, self.view.frame.size.height)  or  [self moveNewFormToCaterForVirtualKeyboard];

}

-(void)hideKeyBoard // moves frame back down, removes keyboard
{
    
    for (UITextField * textFieldItem in fields)
    {
        [textFieldItem resignFirstResponder];
    }

    [UIView animateWithDuration:0.3 animations:^{
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

-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)submitSignUp
{


    PFUser * user = [PFUser user];
    
    //UIImage * avatar = [UIImage imageNamed:@"greenmonster"];  // i dont need this because i have UIImage in frame above
    
    NSData * imageData = UIImagePNGRepresentation(avatar.image);
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data: imageData];
    user[@"avatar"] = imageFile;

    // PFUser is a class, has properties, hence why user can do dot notation with username, password, email
    user.username = ((UITextField *)fields[0]).text;
    user.password = ((UITextField *)fields[1]).text;
    user.email = ((UITextField *)fields[3]).text;

    // displayName is a custome field, not a propertyof PFUser, hence the use of @""
    user[@"displayName"] = ((UITextField *) fields[2]).text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            // show tableview
            
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationBarHidden = NO;
            pnc.navigationBar.translucent = NO;
            pnc.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            [self cancelSignUp];

            
        } else {
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another USername" otherButtonTitles:nil];
            [alertView show];
        }
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
