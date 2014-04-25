//
//  SLFNewSelfyVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/22/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFNewSelfyVC.h"
#import "SLFTableViewController.h"
#import <Parse/Parse.h>


@interface SLFNewSelfyVC ()

@end

@implementation SLFNewSelfyVC
{
    UITextView * newCaption;
    
    UIView *newForm;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    newForm = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:newForm];
    
    self.view.backgroundColor = [UIColor colorWithWhite:.95 alpha:1.0];
        
    newCaption = [[UITextView alloc] initWithFrame:CGRectMake(40,270,240,80)];
    newCaption.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    newCaption.layer.cornerRadius = 6;
    newCaption.delegate = self;
    newCaption.keyboardType = UIKeyboardTypeTwitter;
    [newCaption.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [newCaption.layer setBorderWidth: 2.0];
    [newForm addSubview:newCaption];
        
    //colorWithRed:0.137f green:0.682f blue:1.000f alpha:1.0f
    //colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0
        
    UIButton * submitNew = [[UIButton alloc] initWithFrame:CGRectMake(40, 360, 100, 40)];
    submitNew.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [submitNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitNew setTitle:@"Submit" forState:UIControlStateNormal];
    submitNew.layer.cornerRadius = 6;
    //[newImage addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:submitNew];
        
    UIButton * cancelNew = [[UIButton alloc] initWithFrame:CGRectMake(180, 360, 100, 40)];
    cancelNew.backgroundColor = [UIColor redColor];
    [cancelNew setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelNew.layer.cornerRadius = 6;
    //[newImage addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:cancelNew];
                
    UIImageView * newImageFrame = [[UIImageView alloc] initWithFrame:CGRectMake(60,60,200,200)];
    newImageFrame.layer.cornerRadius = 6;
    newImageFrame.contentMode = UIViewContentModeCenter;
    newImageFrame.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    newImageFrame.image = [UIImage imageNamed:@"image"];
    [newImageFrame.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [newImageFrame.layer setBorderWidth: 2.0];
    [newForm addSubview:newImageFrame];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)]; //added this to get rid of keyboard with a touch on frame outside of the above items
    [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)moveNewFormToOriginalPosition
{
    newForm.frame = CGRectMake(0,0, 320, self.view.frame.size.height);
}


-(void)moveNewFormToCaterForVirtualKeyboard
{
    newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToCaterForVirtualKeyboard];
    }];
    return YES;
}



-(void)tapScreen // moves frame back down, removes keyboard
{
    [newCaption resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToOriginalPosition];
    }];
}

-(void)newSelfy
{
   
    UIImage * image = [UIImage imageNamed:@"greenmonster"]; //local file name
    NSData * imageData = UIImagePNGRepresentation(image);
    PFFile * imageFile = [PFFile fileWithName:@"greenmonster.png" data:imageData]; //file name on Parse, you set it
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"caption"] = newCaption.text;
    newSelfy[@"image"] = imageFile;  //creates a new row with column "image" and data "imageFile"
    [newSelfy saveInBackground];

}


-(void)textViewDidBeginEditing:(UITextView *)textView  //moves new frame up as keyboard appears.
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);
        
    }];
    
}


//- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range   // had this to remove UITextView, are using dif way
//  replacementText: (NSString*) text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Do any additional setup after loading the view.
}

-(void)cancelNewSelfy
{
    SLFTableViewController * newSLFTVC = [[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:newSLFTVC];

    nc.navigationBar.barTintColor = BLUE_COLOR;
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
       
    self.navigationController.navigationBarHidden = NO;
        
        
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
   
  //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return UIStatusBarStyleLightContent;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
