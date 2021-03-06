//
//  JSONObjectCreator.m
//  LTBLite
//
//  Created by UDAY-MAC on 09/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "JSONObjectCreator.h"
#import "JSON.h"
#import "SBJsonParser.h"
#import "Preferences.h"

@implementation JSONObjectCreator

+(NSString*)createRegisterJSON{
    
    
    
    NSString* fbID = [Preferences getFBID];
    NSString* fbUserName = [Preferences getFbUserName];
    NSString* udid = [Preferences getudidString];
    NSDictionary *registerJSONDictionary = [NSDictionary dictionaryWithObjectsAndKeys:fbID,@"fb_id",fbUserName,@"name",udid,@"udid", nil];
   // NSLog(@"sfdsfsdgsdg %@ %@",registerJSONDictionary,registerJSON);
    NSString *registerJSON = [registerJSONDictionary JSONRepresentation];
    
    return registerJSON;
}

+(NSString*)createAddGroupJSON: (NSMutableDictionary*) groupData{
    NSString* userID = [Preferences getUserID];
    [groupData setValue:userID forKey:@"id"];
    // NSLog(@"sfdsfsdgsdg %@ %@",registerJSONDictionary,registerJSON);
    NSString *addGroupJSON = [groupData JSONRepresentation];
    return addGroupJSON;
}

+(NSString*)createAddDeviceJSON{
    NSString* fbID = [Preferences getFBID];
    NSString* fbUserName = [Preferences getFbUserName];
    NSString* udid = [Preferences getudidString];
    NSDictionary *registerJSONDictionary = [NSDictionary dictionaryWithObjectsAndKeys:fbID,@"fb_id",fbUserName,@"name",udid,@"udid", nil];
    // NSLog(@"sfdsfsdgsdg %@ %@",registerJSONDictionary,registerJSON);
    NSString *registerJSON = [registerJSONDictionary JSONRepresentation];
    
    return registerJSON;
}

+(NSString*)createGetDevicesJSON{
    NSString* fbID = [Preferences getFBID];
    NSString* fbUserName = [Preferences getFbUserName];
    NSString* udid = [Preferences getudidString];
    NSDictionary *registerJSONDictionary = [NSDictionary dictionaryWithObjectsAndKeys:fbID,@"fb_id",fbUserName,@"name",udid,@"udid", nil];
    // NSLog(@"sfdsfsdgsdg %@ %@",registerJSONDictionary,registerJSON);
    NSString *registerJSON = [registerJSONDictionary JSONRepresentation];
    
    return registerJSON;
}
@end
