//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Ali Houshmand on 4/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell

{
    UIImageView *selfyView; // frame for the image
    UIImageView *selfyAvatar; // frame for the avatar
    UILabel *selfyUserId; // label for UserId
    UILabel *selfyCaption; // label for caption
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
//      self.backgroundColor = [UIColor blackColor];
        
        selfyView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
        selfyView.backgroundColor = [UIColor lightGrayColor];
        selfyView.layer.masksToBounds = YES;
        [self.contentView addSubview:selfyView];
        
        selfyAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(35, 320, 40, 40)];
        selfyAvatar.layer.cornerRadius = 20;
        selfyAvatar.backgroundColor = [UIColor lightGrayColor];
        selfyAvatar.layer.masksToBounds = YES;
        [self.contentView addSubview:selfyAvatar];
        
        selfyUserId = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 40, 40)];
        selfyUserId.textColor = [UIColor blackColor];
        selfyUserId.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:selfyUserId];

        selfyCaption = [[UILabel alloc] initWithFrame:CGRectMake(90, 320, 200, 40)];
        selfyCaption.textColor = [UIColor blueColor];
        selfyCaption.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:selfyCaption];
    }
    return self;
}

- (void)setProfileInfo:(PFObject *)profileInfo; // THIS IS A SETTER
{
    
    PFFile * imageFile = [profileInfo objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    UIImage * image = [UIImage imageWithData:data];
    selfyView.image = image;
    } progressBlock:^(int percentDone) {
      
        // do something 
    }];
    selfyView.contentMode = UIViewContentModeScaleAspectFit;
   
    
    // selfyCaption.text = profileInfo[@"caption"];  not using this anymore, now getting it from parse
    selfyCaption.text = [profileInfo objectForKey:@"caption"];

// this would be the code for the the tableviewcell to get avatar from parse (that was submitted via SLFSignUpVC)
/*
    PFFile * avatarFile = [profileInfo objectForKey:@"avatar"];
    [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage * avatar = [UIImage imageWithData:data];
        selfyAvatar.image = avatar;
    } progressBlock:^(int percentDone) {
    }];
    selfyAvatar.image = [profileInfo objectForKey:@"avatar"];
*/
    
    _profileInfo = profileInfo;
    
    

    
    ///////////// grabbing image from URL, no longer using it (getting from Parse)
    //    NSString *imageUrlString = profileInfo[@"image"];
    //    //  NSURL *imageURL = [[NSURL alloc] URLWithString:profileInfo[@"image"]];  this way combines line 55 above and line 57 below
    //    NSURL *imageUrl = [[NSURL alloc] initWithString:imageUrlString];
    //    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    //    UIImage *image = [UIImage imageWithData:imageData];
    
    //    NSString *avatarUrlString = profileInfo[@"avatar"];
    //    NSURL *avatarUrl = [[NSURL alloc] initWithString:avatarUrlString];
    //    NSData *avatarData = [NSData dataWithContentsOfURL:avatarUrl];
    //    UIImage *avatarImage = [UIImage imageWithData:avatarData];
    //    selfyAvatar.image = avatarImage;
    //    selfyAvatar.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
