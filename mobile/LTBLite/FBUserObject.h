//
//  FBUserObject.h
//  LTBLite
//
//  Created by TAVANT on 6/4/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FBUserGroup;

@interface FBUserObject : NSManagedObject

@property (nonatomic, retain) NSString * fb_id;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *groups;
@end

@interface FBUserObject (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(FBUserGroup *)value;
- (void)removeGroupsObject:(FBUserGroup *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

@end
