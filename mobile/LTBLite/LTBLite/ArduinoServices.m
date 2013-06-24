//
//  ArduinoServices.m
//  LTBLite
//
//  Created by UDAY-MAC on 09/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import "ArduinoServices.h"
#import "Preferences.h"
#import "HTTPLayer.h"
#import "JSONObjectCreator.h"

@implementation ArduinoServices
@synthesize requestType;

-(void) registerwithArduino{
    
    NSString *registerURL = [[Preferences getPlistDictionary] valueForKey:@"registerURL"];
    NSString *content = [JSONObjectCreator createRegisterJSON];
    HTTPLayer *http = [[HTTPLayer alloc] initWithDelegate:self];
    self.requestType = @"registerDevice";
    //Pass the header dictionary and content.
    [http executeRequest:registerURL :nil :content];
}

-(void) addGroup: (NSDictionary*) groupData {
    NSString *addGroupURL = [[Preferences getPlistDictionary] valueForKey:@"addGroup"];
    NSString *content = [JSONObjectCreator createAddGroupJSON: groupData];
    HTTPLayer *http = [[HTTPLayer alloc] initWithDelegate:self];
    self.requestType = @"getGroup";
    //Pass the header dictionary and content.
    [http executeRequest:addGroupURL :nil :content];
}

//HTTP Layer delegate methods for success/failure.
-(void) errorCallback:(NSString*) errorCode{
    NSLog(@"error with %@",errorCode);
}

-(void) successCallBack:(NSData*) responseData{
    NSString *authResponseBody = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"response data is %@",authResponseBody);
    
}

@end
