//
//  ControlBoardController.m
//  LTBLite
//
//  Created by TAVANT on 5/23/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "ControlBoardController.h"
#import "Preferences.h"

@interface ControlBoardController ()

@end

@implementation ControlBoardController

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
    [self populateUserDetails];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 //self.userNameLabel.text = user.name;
                 //                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 //NSLog(@"user is %@",user);
                 //NSLog(@"The user profile id is %@",[user objectForKey:@"id"]);
                 [Preferences setFBID:[user objectForKey:@"id"]];
                 [Preferences setFbUserName:[user objectForKey:@"username"]];
                 [Preferences setEmail:[user objectForKey:@"email"]];
             }
         }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidAppear:animated];
}

- (IBAction)accessLockControlScreen:(id)sender {
    NSLog(@"Going to the lock screen");
//    FriendListViewController* friendListViewController = [[FriendListViewController alloc] initWithNibName:@"FriendListViewController" bundle:nil];
    FBGroupListingViewController *fbGroupListingController = [[FBGroupListingViewController alloc] initWithNibName:@"FBGroupListingViewController" bundle:nil];
    LockControlViewController* lockControlViewController = [[LockControlViewController alloc] initWithNibName:@"LockControlViewController" bundle:nil];
    CoOwnLockViewController* coOwnLockViewController = [[CoOwnLockViewController alloc] initWithNibName:@"CoOwnLockViewController" bundle:nil]; 
    
//    NSArray *tabs = [[NSArray alloc] initWithObjects: lockControlViewController,coOwnLockViewController , friendListViewController, nil];
    NSArray *tabs = [[NSArray alloc] initWithObjects: lockControlViewController,coOwnLockViewController , fbGroupListingController, nil];
    
    UITabBarController* lockTabBarController =[[UITabBarController alloc] init];
    [lockTabBarController setViewControllers:tabs animated:YES];
    
    [self.navigationController pushViewController:lockTabBarController animated:YES];
}
@end
