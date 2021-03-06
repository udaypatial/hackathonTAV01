//
//  FriendListViewController.m
//  LTBLite
//
//  Created by TAVANT on 5/24/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "FriendListViewController.h"
#import "FBUserObject.h"
#import <CoreData/CoreData.h>
#import "DBContextHandle.h"
#import "AddNewGroupViewController.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController
@synthesize friendTableView;

static NSString *CellIdentifier = @"CellIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.friends = [[NSArray alloc] init];
        [self getFBFriends];
        //NSLog(@"friends array %@",self.friends);
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Friend List" image:[UIImage imageNamed:@"artist-tab.png"] tag:1];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendTableView.delegate = self;
    self.friendTableView.dataSource = self;
    [self.friendTableView registerClass:[FBFriendTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showFBFriendsList)];

    //self.navigationItem.rightBarButtonItem = _addButton;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title=@"LOCK: FB Groups";
    self.tabBarController.navigationItem.rightBarButtonItem = _addButton;
}

//-(void) viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [super viewWillDisappear:animated];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"The count is %i",[self.friends count]);
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSDictionary<FBGraphUser>* friend = [_friends objectAtIndex:indexPath.row];
    
    FBFriendTableViewCell *cell = (FBFriendTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FBFriendTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell...
//    for(id key in friend){
        //NSLog(@"key: %@, value: %@ \n",key, [friend objectForKey:key]);
//    }
//    NSLog(@"The name label is %@",cell.friendName);
    
    cell.friendName.text = friend.name;
    cell.profileImage.profileID = friend.id;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void) getFBFriends
{
    if(FBSession.activeSession.isOpen){
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];        
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      
                                                      NSDictionary* result,
                                                      
                                                      NSError *error) {
            
            NSArray* friends = [result objectForKey:@"data"];
            
            //NSLog(@"Found: friends %@", friends);
            
            for (NSDictionary<FBGraphUser>* friend in friends) {
                
                NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
                [self dumpFBUserToDB:friend];
                
            }

            //friendlist = friends;
            self.friends = friends;  // the friends details array used by the tableview
            [self.friendTableView reloadData];
        }];
    }
    NSLog(@"Friend dump to DB Complete");
    
}

-(void) dumpFBUserToDB:(NSDictionary<FBGraphUser>*)friend{
    DBContextHandle *dbHandle = [DBContextHandle getHandle];
    FBUserObject *newFBUser = [NSEntityDescription insertNewObjectForEntityForName:@"FBUserObject" inManagedObjectContext:dbHandle.managedObjectContext];
    newFBUser.fb_id = friend.id;
    newFBUser.first_name = friend.first_name;
    newFBUser.last_name = friend.last_name;
    newFBUser.name = friend.name;
    newFBUser.username = friend.username;
    [dbHandle.managedObjectContext save:nil];
    
}

-(void) showFBFriendsList
{
    AddNewGroupViewController *addNewGroupViewController = [[AddNewGroupViewController alloc] initWithNibName:@"AddNewGroupViewController" bundle:nil];
    [self.navigationController pushViewController:addNewGroupViewController animated:YES];
    //NSLog(@"Show the FB Friends List");
}

@end
