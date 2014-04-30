//
//  SLFTableViewController.m
//  Selfy
//
//  Created by Ali Houshmand on 4/21/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "SLFTableViewController.h"
#import "SLFTableViewCell.h"
#import "SLFNewNavigationController.h"
#import "SLFNewSelfyVC.h"
#import "SLFSettingsVC.h"
#import "SLFSettingsButton.h"


#import <Parse/Parse.h>

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    NSArray * listItems;
    
    SLFSettingsButton * settingsButtonView;
    SLFSettingsVC * settingsVC;
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        [self refreshSelfies];
        self.tableView.backgroundColor = [UIColor clearColor];
        
        
//////////// USING A BARBUTTONITEM AND NAVBAR, SO I DONT NEED THE BELOW:
        
//        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,60)];
//        header.backgroundColor = [UIColor lightGrayColor];
//        self.tableView.tableHeaderView = header;
//        
//        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(135,0,100,95)];
//        titleHeader.text = @"Selfy";
//        titleHeader.textColor = [UIColor blackColor];
//        titleHeader.font =[UIFont fontWithName:@"Helvetica" size:(20)];
//        [header addSubview:titleHeader];
//        
//        UIButton * submit = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
//        [submit setImage:[UIImage imageNamed:@"newuser.png"] forState:UIControlStateNormal];
//        submit.backgroundColor = [UIColor clearColor];
//        submit.layer.cornerRadius = 15;
//        //[submit addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
//        [header addSubview:submit];
//        
//        UIButton * settings = [[UIButton alloc] initWithFrame:CGRectMake(280, 30, 30, 30)];
//        [settings setImage:[UIImage imageNamed:@"gear.png"] forState:UIControlStateNormal];
//        settings.backgroundColor = [UIColor clearColor];
//        settings.layer.cornerRadius = 15;
//        //[settings addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
//        [header addSubview:settings];
        
/////////////
        
        self.tableView.rowHeight = self.tableView.frame.size.width+60;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openNewSelfy)];
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    addNewSelfyButton.tintColor = BLUE_COLOR;
    
//    NSLog(@"%@",(UIView *)[addNewSelfyButton valueForKey:@"view"]); will work in viewwillappear(bool)
    
    settingsButtonView = [[SLFSettingsButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    settingsButtonView.tintColor = BLUE_COLOR;
    settingsButtonView.toggledTintColor = [UIColor redColor];
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButtonView];  // still 2 different entities, but settingsButton gets a view inside it of the type SLFSettingsButton
    self.navigationItem.leftBarButtonItem = settingsButton;
    settingsButton.tintColor = BLUE_COLOR;
    [settingsButtonView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)openSettings
{
    [settingsButtonView toggle];
    
//    settingsButtonView.toggled = ![settingsButtonView isToggled]; above line does this
    
    int X = [settingsButtonView isToggled] ? SCREEN_WIDTH - 52 : 0; // X gets 270 if true (i.e. toggled), 0 if not
    
    NSLog(@"%d", X);
    
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.navigationController.view.frame = CGRectMake(X, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    } completion:^(BOOL finished) {
        
        if(![settingsButtonView isToggled])
        {
            [settingsVC.view removeFromSuperview];
        }
        
    }];
    
    
    if([settingsButtonView isToggled])
    {
        settingsVC = [[SLFSettingsVC alloc] initWithNibName:nil bundle:nil];
        
        settingsVC.view.frame = CGRectMake(52 - SCREEN_WIDTH, 0, SCREEN_WIDTH - 52, SCREEN_HEIGHT);
        
        [self.navigationController.view addSubview:settingsVC.view];
    }
        
        
        
        
    
}




- (void)viewWillAppear:(BOOL)animated //happens right after viewDidLoad
{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self refreshSelfies];

}


-(void)openNewSelfy
{
    SLFNewSelfyVC * newSelfyVC = [[SLFNewSelfyVC alloc] initWithNibName:nil bundle:nil];
    
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newSelfyVC];
    
    nc.navigationBar.barTintColor = BLUE_COLOR;
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    }];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [listItems count];
}

-(void)refreshSelfies
{
    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
    
    [query orderByDescending:@"createdAt"];
    
    // filter only your user's selfies
    [query whereKey:@"parent" equalTo:[PFUser currentUser]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        
    listItems = objects;
    
    [self.tableView reloadData];
}];
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"]; //this is a memory mgmt tool
    
    if (cell == nil)
    {
        cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]; //creates new cell if dequeued cell not available
    }
    
//    cell.profileInfo = [self getListItem:indexPath.row]; // will require setter method in tableviewcell
    // cell.profileInfo = listItems[indexPath.row]; same as above, but above uses method for reverse row

    cell.profileInfo = listItems[indexPath.row];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    // Configure the cell...
    
    return cell;
}


//- (NSDictionary *)getListItem:(NSInteger)row   // this wont work now that we are using PFObject for profile info
//{
//    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
//    return reverseArray[row];
//}








/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
