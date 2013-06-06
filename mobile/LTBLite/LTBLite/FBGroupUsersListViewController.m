//
//  FBGroupUsersListViewController.m
//  LTBLite
//
//  Created by TAVANT on 6/5/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "FBGroupUsersListViewController.h"

@interface FBGroupUsersListViewController ()

@end

@implementation FBGroupUsersListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fbGroupObject: (FBUserGroup*) fbGroup
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fbGroup =  fbGroup;
        self.fbUsers = [fbGroup.users allObjects];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fbUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FBUserObject* friend = [self.fbUsers objectAtIndex:indexPath.row];
    
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
//    if ([self.fbUsers containsObject:indexPath]) {
//        cell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
//    }
//    else{
//        cell.tag = 0;
//    }
//    NSLog(@"Tag is: %i",cell.tag);

      cell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBFriendTableViewCell *fbListViewCustomCell = (FBFriendTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
//    if ([selectedFriendsArray count] == 0 ) {
//        
//        [selectedFriendsArray addObject:[self.friends objectAtIndex:indexPath.row]];
//        [selectedIndexPathArray addObject:indexPath];
//        fbListViewCustomCell.tag = 1;
//        fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
//        //}
//        
//    }else{
        if (fbListViewCustomCell.tag == 1) {
//            [selectedFriendsArray removeObject:[self.friends objectAtIndex:indexPath.row]];
//            [selectedIndexPathArray removeObject:indexPath];
            fbListViewCustomCell.tag = 0;
            fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Default.png"];
        }
        else{
//            [selectedFriendsArray addObject:[self.friends objectAtIndex:indexPath.row]];
//            [selectedIndexPathArray addObject:indexPath];
            fbListViewCustomCell.tag = 1;
            fbListViewCustomCell.checkBox.image = [UIImage imageNamed:@"Check_Box_Selected.png"];
        }
//    }
}

@end
