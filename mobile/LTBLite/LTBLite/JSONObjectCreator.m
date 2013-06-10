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

@implementation JSONObjectCreator

+(NSString*)createRegisterJSON{
    
    
    NSString *ltbConfig = [[NSBundle mainBundle]pathForResource:@"LTBConfig" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:ltbConfig];
    NSString* fbID = [dict valueForKey:@"fb_id"];
    NSString* fbUserName = [dict valueForKey:@"fb_name"];
    NSString* udid = [dict valueForKey:@"udid"];
    NSDictionary *registerJSONDictionary = [NSDictionary dictionaryWithObjectsAndKeys:fbID,@"fb_id",fbUserName,@"name",udid,@"udid", nil];
   // NSLog(@"sfdsfsdgsdg %@ %@",registerJSONDictionary,registerJSON);
    NSString *registerJSON = [registerJSONDictionary JSONRepresentation];
    
    
    return registerJSON;
}

@end
