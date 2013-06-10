//
//  Preferences.m
//  LTBLite
//
//  Created by UDAY-MAC on 10/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

+(NSDictionary*) getPlistDictionary{
    NSString *ltbConfig = [[NSBundle mainBundle]pathForResource:@"LTBConfig" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:ltbConfig];
    
    return dict;
}

+(void) setUDID:(NSString*) udidString{
    NSString *ltbConfig = [[NSBundle mainBundle]pathForResource:@"LTBConfig" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:ltbConfig];
    [dict setValue:udidString forKey:@"udid"];
}

+(NSString*) getudidString{
    NSString *ltbConfig = [[NSBundle mainBundle]pathForResource:@"LTBConfig" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:ltbConfig];
    return [dict valueForKey:@"udid"];
}

@end
