//
//  FBFriendTableViewCell.m
//  LTBLite
//
//  Created by TAVANT on 5/24/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "FBFriendTableViewCell.h"


@implementation FBFriendTableViewCell
@synthesize profileImage;
@synthesize friendName;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //profileImage = [[FBProfilePictureView alloc] init];
        //friendName = [[UILabel alloc] init];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
