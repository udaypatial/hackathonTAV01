//
//  FBGroup.h
//  LTBLite
//
//  Created by TAVANT on 5/30/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBGroup : NSObject
{
    NSInteger fbGroupID;
    NSString *fbGroupName;
    BOOL isCoOwned;
    NSMutableArray *groupMembers;
}

@property NSInteger fbGroupID;
@property (nonatomic,retain) NSString *fbGroupName;
@property BOOL isCoOwned;
@property (nonatomic,retain) NSMutableArray *groupMembers;

@end
