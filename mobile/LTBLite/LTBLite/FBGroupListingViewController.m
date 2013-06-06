//
//  FBGroupListingViewController.m
//  LTBLite
//
//  Created by TAVANT on 6/5/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "FBGroupListingViewController.h"

@interface FBGroupListingViewController ()

@end

@implementation FBGroupListingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"FB Groups" image:[UIImage imageNamed:@"artist-tab.png"] tag:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    // Do any additional setup after loading the view from its nib.
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"LOCK: FB Groups";
    self.addNewGroupButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openAddNewGroupView)];
    self.tabBarController.navigationItem.rightBarButtonItem = self.addNewGroupButton;
    [self getandSetGroups];
    NSLog(@"COUNT OF GROUPS: %i", [self.FBGroupsArray count]);
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.FBGroupsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    FBUserGroup *fbGroup = [self.FBGroupsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = fbGroup.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBUserGroup *fbGroup = [self.FBGroupsArray objectAtIndex:indexPath.row];
    FBGroupUsersListViewController* fbGroupUsersListViewController = [[FBGroupUsersListViewController alloc] initWithNibName:@"FBGroupUsersListViewController" bundle:nil fbGroupObject:fbGroup];
    [self.navigationController pushViewController:fbGroupUsersListViewController animated:YES];
}

-(void) openAddNewGroupView
{
    AddNewGroupViewController *addNewGroupViewController = [[AddNewGroupViewController alloc] initWithNibName:@"AddNewGroupViewController" bundle:nil];
    [self.navigationController pushViewController:addNewGroupViewController animated:YES];
}

-(void) getandSetGroups{
    DBContextHandle *dbHandle = [DBContextHandle getHandle];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"FBUserGroup" inManagedObjectContext:dbHandle.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [dbHandle.managedObjectContext executeFetchRequest:request error:&error];
    
    self.FBGroupsArray = results;
    [self.tableview reloadData];
}



@end
