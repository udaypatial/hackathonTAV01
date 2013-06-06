//
//  FBGroupListingViewController.h
//  LTBLite
//
//  Created by TAVANT on 6/5/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewGroupViewController.h"
#import "FriendListViewController.h"
#import "FBGroupUsersListViewController.h"


@interface FBGroupListingViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property NSArray *FBGroupsArray;
@property (nonatomic,retain) UIBarButtonItem *addNewGroupButton;

@end
