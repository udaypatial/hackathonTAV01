//
//  FriendListViewController.h
//  LTBLite
//
//  Created by TAVANT on 5/24/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FBFriendTableViewCell.h"

@interface FriendListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{

    IBOutlet UITableView *friendTableView;
}
@property (nonatomic,strong) IBOutlet UITableView *friendTableView;
@property (nonatomic,strong) UIBarButtonItem *addButton;
@property (nonatomic,strong) NSArray *friends;

-(NSArray*) getFBFriends;
@end
