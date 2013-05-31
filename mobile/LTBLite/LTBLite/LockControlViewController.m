//
//  LockControlViewController.m
//  LTBLite
//
//  Created by TAVANT on 5/27/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "LockControlViewController.h"

@interface LockControlViewController ()

@end

@implementation LockControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization    
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Lock Control" image:[UIImage imageNamed:@"artist-tab.png"] tag:0];
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
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title=@"LOCK: Owned";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
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

@end
