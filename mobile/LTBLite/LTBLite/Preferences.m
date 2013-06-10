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
    [[NSUserDefaults standardUserDefaults] setObject:udidString forKey:@"udid"];
}

+(NSString*) getudidString{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"udid"];
}

+(void) setFBID:(NSString*) fbID{
    [[NSUserDefaults standardUserDefaults] setObject:fbID forKey:@"fb_id"];
}

+(NSString*) getFBID{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"fb_id"];
}

+(void) setFbUserName:(NSString*) fbName{
    [[NSUserDefaults standardUserDefaults] setObject:fbName forKey:@"fbName"];
}

+(NSString*) getFbUserName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"fbName"];
}

+(void) setEmail:(NSString*) email{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
}

+(NSString*) getEmail{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
}

@end
