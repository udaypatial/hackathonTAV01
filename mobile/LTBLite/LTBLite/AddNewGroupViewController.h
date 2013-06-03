//
//  AddNewGroupViewController.h
//  LTBLite
//
//  Created by UDAY-MAC on 02/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AddNewGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *friendTableView;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic, strong) NSMutableArray *selectedFriendsArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexPathArray;
@property (nonatomic, strong) NSArray * friendsMasterArray;

@end
