//
//  DBHandle.m
//  IRetrospec
//
//  Created by tavant on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBContextHandle.h"
static DBContextHandle *getMyHandle = nil;


@implementation DBContextHandle
@synthesize managedObjectContext;

- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] >0) ? [paths objectAtIndex:0] : nil;
    NSURL *storeUrl = [NSURL fileURLWithPath: [basePath stringByAppendingPathComponent:@"ArduinoDBModel.sqlite"]];
    NSError *error;
    
   
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator* persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                                                initWithManagedObjectModel:managedObjectModel];
    if(![persistentStoreCoordinator addPersistentStoreWithType : NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]){
        NSLog(@"error loading persistent store");
    }
    managedObjectContext = [[NSManagedObjectContext alloc]init];
    NSUndoManager *anUndoManager = [[NSUndoManager  alloc] init];
    [managedObjectContext setUndoManager:anUndoManager];
    //[anUndoManager release];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    //[persistentStoreCoordinator release];
	
	return managedObjectContext;
}




- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


#pragma mark DBHandle Methods
+ (id)getHandle {
    @synchronized(self) {
        if(getMyHandle == nil)
            getMyHandle = [[super allocWithZone:NULL] init];
    }
    return getMyHandle;
}
//+ (id)allocWithZone:(NSZone *)zone {
//    return [[self getHandle] retain];
//}
//- (id)copyWithZone:(NSZone *)zone {
//    return self;
//}
//- (id)retain {
//    return self;
//}
//- (unsigned)retainCount {
//    return UINT_MAX; //denotes an object that cannot be released
//}
//
//- (id)autorelease {
//    return self;
//}
- (id)init {
	
    if (self == [super init]) {
		//flagForMap=[[NSInteger alloc]init];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    //[super dealloc];
}


@end
