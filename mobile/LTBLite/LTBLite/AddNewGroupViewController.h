//
//  AddNewGroupViewController.h
//  LTBLite
//
//  Created by UDAY-MAC on 02/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FBUserObject.h"
#import "FBUserGroup.h"
#import <CoreData/CoreData.h>
#import "DBContextHandle.h"

@interface AddNewGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITextField *groupNametextField;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic, strong) NSMutableArray *selectedFriendsArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexPathArray;
@property (nonatomic, strong) NSArray * friendsMasterArray;

@end
