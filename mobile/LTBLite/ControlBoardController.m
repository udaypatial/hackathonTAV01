//
//  ControlBoardController.m
//  LTBLite
//
//  Created by TAVANT on 5/23/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "ControlBoardController.h"
#import "NavViewController.h"

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
    // Do any additional setup after loading the view from its nib.
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
    FriendListViewController* friendListViewController = [[FriendListViewController alloc] initWithNibName:@"FriendListViewController" bundle:nil];
    LockControlViewController* lockControlViewController = [[LockControlViewController alloc] initWithNibName:@"LockControlViewController" bundle:nil];
    
    NSArray *tabs = [[NSArray alloc] initWithObjects: lockControlViewController, friendListViewController, nil];
    
    UITabBarController* lockTabBarController =[[UITabBarController alloc] init];
    [lockTabBarController setViewControllers:tabs animated:YES];
    
    [self.navigationController pushViewController:lockTabBarController animated:YES];
}
@end
