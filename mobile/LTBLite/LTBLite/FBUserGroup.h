//
//  FBUserGroup.h
//  LTBLite
//
//  Created by UDAY-MAC on 02/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FBUserGroup : NSManagedObject

@property (nonatomic, retain) NSSet *users;
@end

@interface FBUserGroup (CoreDataGeneratedAccessors)

- (void)addUsersObject:(NSManagedObject *)value;
- (void)removeUsersObject:(NSManagedObject *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
