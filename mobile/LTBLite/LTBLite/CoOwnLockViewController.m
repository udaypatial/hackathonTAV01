//
//  CoOwnLockViewController.m
//  LTBLite
//
//  Created by TAVANT on 5/30/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "CoOwnLockViewController.h"

@interface CoOwnLockViewController ()

@end

@implementation CoOwnLockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Co Owned Locks" image:[UIImage imageNamed:@"artist-tab.png"] tag:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title=@"LOCK: Co Owned";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
