//
//  FBGroupUsersListViewController.h
//  LTBLite
//
//  Created by TAVANT on 6/5/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBUserGroup.h"
#import "FBUserObject.h"
#import "FBFriendTableViewCell.h"

@interface FBGroupUsersListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabelview;
@property FBUserGroup *fbGroup;
@property NSArray *fbUsers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fbGroupObject: (FBUserGroup*) fbGroup;
@end
