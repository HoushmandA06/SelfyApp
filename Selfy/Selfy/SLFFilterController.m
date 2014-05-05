//
//  PPLFilterController.m
//  PullPicLibrary
//
//  Created by Ali Houshmand on 5/1/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFFilterController.h"

@interface SLFFilterController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation SLFFilterController
{

    UIScrollView * scrollview;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    float wh;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
            filterButtons = [@[] mutableCopy];
            filterNames = @[
                            @"CIColorInvert",
                            @"CIColorMonochrome",
                            @"CIColorPosterize",
                            @"CIFalseColor",
                            @"CIMaximumComponent",
                            @"CIMinimumComponent",
                            @"CIPhotoEffectChrome",
                            @"CIPhotoEffectFade",
                            @"CIPhotoEffectInstant",
                            @"CIPhotoEffectMono",
                            @"CIPhotoEffectNoir",
                            @"CIPhotoEffectProcess",
                            @"CIPhotoEffectTonal",
                            @"CIPhotoEffectTransfer",
                            @"CISepiaTone",
                            @"CIVignette"
                            ];
        
        scrollview = [[UIScrollView alloc] init];
        [self.view addSubview:scrollview];
        
    }
    return self;
}


- (void)viewWillLayoutSubviews
{    
     wh = self.view.frame.size.height - 20;
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10) * i + 10;
        
        UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(x,10,wh,wh)];
        filterButton.layer.cornerRadius = wh/8;
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        [filterButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        filterButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
        [filterButton setTitle:filterName forState:UIControlStateNormal];
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        [filterButtons addObject:filterButton];
        
        [scrollview addSubview:filterButton];
    }
    
     scrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     scrollview.backgroundColor = [UIColor darkGrayColor];
     scrollview.contentSize = CGSizeMake((wh+10)*[filterNames count] + 10, self.view.frame.size.height);
     [self.view addSubview:scrollview];
    
    
 }


-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName  //takes an image, filters it, and spits it out
{
    
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];  //need a CIImage to work with filters, convert UIImage to CI
    
    CIFilter * filter = [CIFilter filterWithName:filterName];  // get filter from array
    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];  // apply filter to ciImage
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];  // create ciContext for optimization, rendering of CGImage from CI
    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];  // get the result of the filtered image

    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];  // convert back into UIImage
}



-(void)switchFilter:(UIButton *)filterButton  // will update selected pic in ImageView to selected filter button's image
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
    
}


-(void)setImageToFilter:(UIImage *)imageToFilter  //sets the image of the all the filterbuttons to a "filtered" view
{
    
    _imageToFilter = imageToFilter;
    
    for (UIButton * filterButton in filterButtons)
    {
        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,(unsigned long)NULL), ^{
        
        UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh];
        UIImage * image = [self filterImage:smallImage filterName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [filterButton setImage:image forState:UIControlStateNormal];
            filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            filterButton.imageView.layer.cornerRadius = wh/8;
            
        });
            
        });

    }
}

-(UIImage *)shrinkImage:(UIImage *)image maxWH:(int)widthHeight
{
    CGSize size = CGSizeMake(widthHeight, widthHeight / image.size.width * image.size.height);
    
    if(image.size.height < image.size.width)
        size = CGSizeMake(widthHeight / image.size.height * image.size.width, widthHeight);
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return destImage;
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
