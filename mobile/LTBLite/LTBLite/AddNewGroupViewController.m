//
//  AddNewGroupViewController.m
//  LTBLite
//
//  Created by UDAY-MAC on 02/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "AddNewGroupViewController.h"
#import "FBFriendTableViewCell.h"

@interface AddNewGroupViewController ()

@end

@implementation AddNewGroupViewController
@synthesize tableview, selectedFriendsArray, selectedIndexPathArray, friendsMasterArray;

static NSString *CellIdentifier = @"CellIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndexPathArray = [[NSMutableArray alloc] init];
    self.selectedFriendsArray = [[NSMutableArray alloc] init];
    self.friends = [[NSMutableArray alloc] init];
    [self getFBFriendsFromDB];
    NSLog(@"friends is %@",self.friends);
    NSLog(@"friends CCOUNT is %i",[self.friends count]);
    self.friendsMasterArray = [[NSMutableArray alloc] initWithArray:self.friends];
    [self.tableview registerClass:[FBFriendTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    _groupNametextField.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveFBGroupToDB)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_groupNametextField resignFirstResponder];
    return NO;
}


- (void) saveFBGroupToDB
{
//    NSMutableSet *fbFriendsId = [[NSMutableSet alloc] init];
//    if([self.selectedFriendsArray count] > 0){
//        for (NSDictionary<FBGraphUser>* friend in self.selectedFriendsArray) {
//            NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
//            [fbFriendsId addObject:friend.id];
//        }
//    }
    
    if([_groupNametextField.text length]== 0){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Group name has not been entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
        return;
    }
    if([self.selectedFriendsArray count] == 0){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No friends were selected for the group" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
        return;
    }
    //[dbHandle.managedObjectContext save:nil];
    DBContextHandle *dbHandle = [DBContextHandle getHandle];

    
//    NSLog(@"Selected Indexpath Array: %@",self.selectedIndexPathArray);
//    NSLog(@"Selected Friends Array: %@",self.selectedFriendsArray);
    NSLog(@"Save the group to the local DB");
//    FBUserObject *newFBUser = [NSEntityDescription insertNewObjectForEntityForName:@"FBUserObject" inManagedObjectContext:dbHandle.managedObjectContext];
    FBUserGroup *newFBGroup = [NSEntityDescription insertNewObjectForEntityForName:@"FBUserGroup" inManagedObjectContext:dbHandle.managedObjectContext];
    newFBGroup.name = _groupNametextField.text;
    newFBGroup.users = [NSSet setWithArray:self.selectedFriendsArray];
    
   // newFBGroup.users = (NSSet*)fbFriendsId;
    
    for(FBUserObject* friend in self.selectedFriendsArray){
        //[friend.groups ]
        NSMutableArray *existingGroupArray = [[friend.groups allObjects]mutableCopy];
        [existingGroupArray addObject:newFBGroup];
        friend.groups = [NSSet setWithArray:existingGroupArray];
        NSLog(@"Group names %@",[friend.groups allObjects]);
        
    }
    
    [dbHandle.managedObjectContext save:nil];
    
    
    //testing....
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"FBUserGroup" inManagedObjectContext:dbHandle.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [dbHandle.managedObjectContext executeFetchRequest:request error:&error];
    
    for(FBUserGroup *group in results){
        NSLog(@"In the group with name %@ the friends added are %@",group.name,[group.users allObjects]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    FBUserObject* friend = [_friends objectAtIndex:indexPath.row];
    
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
    cell.profileImage.profileID = friend.fb_id;
    if ([selectedIndexPathArray containsObject:indexPath]) {
        cell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
    }
    else{
        cell.tag = 0;
    }
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
    
    FBFriendTableViewCell *fbListViewCustomCell = (FBFriendTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([selectedFriendsArray count] == 0 ) {
        
        [selectedFriendsArray addObject:[self.friends objectAtIndex:indexPath.row]];
        [selectedIndexPathArray addObject:indexPath];
        fbListViewCustomCell.tag = 1;
        fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
        //}
        
    }
    
    
    else{
        if (fbListViewCustomCell.tag == 1) {
            [selectedFriendsArray removeObject:[self.friends objectAtIndex:indexPath.row]];
            [selectedIndexPathArray removeObject:indexPath];
            fbListViewCustomCell.tag = 0;
            fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Default.png"];
        }
        else{
            [selectedFriendsArray addObject:[self.friends objectAtIndex:indexPath.row]];
            [selectedIndexPathArray addObject:indexPath];
            fbListViewCustomCell.tag = 1;
            fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
        }
    }
}



- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText{
    self.friends = [self filterFriends:searchText];
    [self.tableview reloadData];
}

-(NSArray *)filterFriends:(NSString *)filterParameter
{
    NSArray *filterFriends;// = [[NSArray alloc]init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name ==  %@", filterParameter];
    //NSLog(@"filter master %@",self.friendsMasterArray);
    filterFriends= [self.friendsMasterArray filteredArrayUsingPredicate:predicate];
    //NSLog(@"filtered friends are  %@",filterFriends);
    return filterFriends;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getFBFriendsFromDB
{    
    if(FBSession.activeSession.isOpen){
        NSArray *results = [self fetchFBUsersRequest];
        if([results count] == 0)
        {
            [self getFriendsFromFB];
        }else{
            self.friends = results;
            [self.tableview reloadData];
        }
        [self.tableview reloadData];
    }
}


-(void) getFriendsFromFB
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
            NSArray *results = [self fetchFBUsersRequest];
            self.friends = results;
            [self.tableview reloadData];
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

-(NSArray*) fetchFBUsersRequest
{
    DBContextHandle *dbHandle = [DBContextHandle getHandle];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"FBUserObject" inManagedObjectContext:dbHandle.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [dbHandle.managedObjectContext executeFetchRequest:request error:&error];
    return results;
}

@end
