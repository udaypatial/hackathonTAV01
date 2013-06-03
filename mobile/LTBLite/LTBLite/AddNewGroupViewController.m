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
@synthesize friendTableView, selectedFriendsArray, selectedIndexPathArray, friendsMasterArray;

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
    self.friends = [self getFBFriends];
    NSLog(@"friends is %@",self.friends);
    self.friendsMasterArray = [[NSMutableArray alloc] initWithArray:self.friends];
    [self.friendTableView registerClass:[FBFriendTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // Do any additional setup after loading the view from its nib.
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

-(NSArray*) getFBFriends
{
    __block NSArray* friendlist = [[NSArray alloc] init];
    if(FBSession.activeSession.isOpen){
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      
                                                      NSDictionary* result,
                                                      
                                                      NSError *error) {
            
            NSArray* friends = [result objectForKey:@"data"];
            
            //NSLog(@"Found: friends %@", friends);
            
//            for (NSDictionary<FBGraphUser>* friend in friends) {
//                
//                //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
//                //[self dumpFBUserToDB:friend];
//                
//            }
            
            //friendlist = friends;
            self.friends = friends;
            [self.friendTableView reloadData];
        }];
    }
    //NSLog(@"Friend dump to DB Complete");
    return friendlist;
    
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText{
    self.friends = [self filterFriends:searchText];
    [self.friendTableView reloadData];
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

@end
