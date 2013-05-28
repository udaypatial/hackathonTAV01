//
//  ControlBoardController.h
//  LTBLite
//
//  Created by TAVANT on 5/23/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListViewController.h"
#import "LockControlViewController.h"

@interface ControlBoardController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *lockAccessButton;

- (IBAction)accessLockControlScreen:(id)sender;
@end
