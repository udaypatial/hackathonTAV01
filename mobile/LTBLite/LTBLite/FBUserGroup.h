//
//  FBUserGroup.h
//  LTBLite
//
//  Created by TAVANT on 6/4/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FBUserObject;

@interface FBUserGroup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *users;
@end

@interface FBUserGroup (CoreDataGeneratedAccessors)

- (void)addUsersObject:(FBUserObject *)value;
- (void)removeUsersObject:(FBUserObject *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
