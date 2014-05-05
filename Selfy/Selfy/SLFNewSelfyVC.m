//
//  SLFNewSelfyVC.m
//  Selfy
//
//  Created by Ali Houshmand on 4/22/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFNewSelfyVC.h"
#import "SLFFilterController.h"
#import <Parse/Parse.h>


@interface SLFNewSelfyVC () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, SLFFilterControllerDelegate>

@property (nonatomic) UIImage * originalImage;  // here so we can put setter / getter



@end

@implementation SLFNewSelfyVC
{
    UITextView * newCaption;
    
    UIView *newForm;
    
    UIImageView * newImageFrame;
    
    UIImagePickerController * imagePicker;
    
    SLFFilterController * filterVC;
    
    BOOL created;

    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    self.view.backgroundColor = [UIColor blackColor];

    //added this to get rid of keyboard with a touch on frame outside of the above items
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    }
    return self;
}

-(void)createForm
{
    NSLog(@"create");
    newForm = [[UIView alloc] initWithFrame:CGRectMake(20,20,280,self.view.frame.size.height - 40)];
    [self.view addSubview:newForm];
    
    newCaption = [[UITextView alloc] initWithFrame:CGRectMake(40,240,200,self.view.frame.size.height-380)];
    newCaption.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    newCaption.layer.cornerRadius = 6;
    newCaption.delegate = self;
    newCaption.keyboardType = UIKeyboardTypeTwitter;
    [newCaption.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [newCaption.layer setBorderWidth: 2.0];
    [newForm addSubview:newCaption];
    
    UIButton * submitNew = [[UIButton alloc] initWithFrame:CGRectMake(40, 290, 200, 35)];
    submitNew.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [submitNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitNew setTitle:@"Submit" forState:UIControlStateNormal];
    submitNew.layer.cornerRadius = 6;
    [submitNew addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    [newForm addSubview:submitNew];
    
    newImageFrame = [[UIImageView alloc] initWithFrame:CGRectMake(40,30,200,200)];
    newImageFrame.layer.cornerRadius = 6;
    newImageFrame.layer.masksToBounds = YES;
    newImageFrame.contentMode = UIViewContentModeScaleToFill;
    // newImageFrame.contentMode = UIViewContentModeCenter;
    newImageFrame.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
   // newImageFrame.image = [UIImage imageNamed:@"boss"];
    [newImageFrame.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [newImageFrame.layer setBorderWidth: 2.0];
    [newForm addSubview:newImageFrame];
    
    filterVC = [[SLFFilterController alloc] initWithNibName:nil bundle:nil];
    filterVC.delegate = self;
    filterVC.view.frame = CGRectMake(0, 360, SCREEN_WIDTH, 55);
    [self.view addSubview:filterVC.view];
    
    created = YES;
    
}

#pragma FORM & KEYBOARD ANIMATION
-(void)moveNewFormToOriginalPosition
{
    newForm.frame = CGRectMake(20,20, 320, self.view.frame.size.height);
}

-(void)moveNewFormToCaterForVirtualKeyboard
{
    newForm.frame = CGRectMake(20,-KB_HEIGHT, 320, self.view.frame.size.height);
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToCaterForVirtualKeyboard];
    }];
    return YES;
}

-(void)tapScreen // moves frame back down, removes keyboard NOT WORKING
{
    [newCaption resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self moveNewFormToOriginalPosition];
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView  //moves new frame up as keyboard appears.
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20,-KB_HEIGHT, 280, self.view.frame.size.height);
    }];
    
}


-(void)newSelfy
{
    NSData * imageData = UIImagePNGRepresentation(newImageFrame.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData]; //file name on Parse, you set it
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"image"] = imageFile;  //creates a new row with column "image" and data "imageFile"
    
    newSelfy[@"caption"] = newCaption.text;
    newSelfy[@"parent"] = [PFUser currentUser];
    
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%u", succeeded);
        [self cancelNewSelfy];
    }];
}


- (void)viewWillLayoutSubviews
{
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addNewSelfy)];
    addNewSelfyButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = addNewSelfyButton;

    //add bool to only create once
    
    if (created == NO) {[self createForm];}

}


-(void)cancelNewSelfy
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)addNewSelfy
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES; // gives you preview of chosen photo
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

//    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
    
    [self presentViewController:imagePicker animated:NO completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // delegate method of UIImagePickerController
    // using this method to change self.originalImage to the photo chosen in the library
    
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    
//    NSLog(@"%@",self.originalImage);
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)setOriginalImage:(UIImage *)originalImage   //setter method
{
    
    _originalImage = originalImage;
    
    newImageFrame.image = originalImage;
    
    newImageFrame.contentMode = UIViewContentModeScaleToFill;
    
    filterVC.imageToFilter = originalImage;

    NSLog(@"%@",newImageFrame.image);
}

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image  //updates image in the frame with latest filter selection
{
    newImageFrame.image = image;
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
