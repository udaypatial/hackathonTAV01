//
//  Preferences.h
//  LTBLite
//
//  Created by UDAY-MAC on 10/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject
+(NSDictionary*) getPlistDictionary;
+(void) setUDID:(NSString*) udidString;
+(NSString*) getudidString;
@end
