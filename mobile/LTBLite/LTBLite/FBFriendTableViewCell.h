//
//  FBFriendTableViewCell.h
//  LTBLite
//
//  Created by TAVANT on 5/24/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FBFriendTableViewCell : UITableViewCell
@property (nonatomic,assign) int fbId;
@property (retain, nonatomic) IBOutlet FBProfilePictureView *profileImage;
@property (retain, nonatomic) IBOutlet UILabel *friendName;



@end
