//
//  ViewController.m
//  LTBLite
//
//  Created by TAVANT on 5/22/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ControlBoardController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(FBSession.activeSession.isOpen ? @"YES" :@"NO");
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    if(FBSession.activeSession.isOpen){
        ControlBoardController *controlBoardController = [[ControlBoardController alloc] initWithNibName:@"ControlBoardController" bundle:nil];
        UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:controlBoardController];
        [self presentViewController:navViewController animated:YES completion:NULL];
    }else{
        [self.fbLoginButton setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authButtonAction:(UIButton *)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //the person using the app has initiated a login, so call the openSession method and show the login UX if necessary
    [appDelegate openSessionWithAllowLoginUI:YES];
}

- (IBAction)test:(id)sender {
    [self populateUserDetails];
}

- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 //self.userNameLabel.text = user.name;
//                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 NSLog(@"The user profile id is %@",[user objectForKey:@"id"]);
             }
         }];
    }
}

@end
