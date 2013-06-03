//
//  DBHandle.h
//  IRetrospec
//
//  Created by tavant on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBContextHandle : NSObject<NSFetchedResultsControllerDelegate> {
	NSManagedObjectContext *managedObjectContext;
    
    //NSManagedObjectContext *transactionManagedObjectContext;
    
}
+(id)getHandle;

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

//@property(nonatomic, retain) NSManagedObjectContext *transactionManagedObjectContext;

@end
