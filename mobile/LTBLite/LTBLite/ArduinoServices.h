//
//  ArduinoServices.h
//  LTBLite
//
//  Created by UDAY-MAC on 09/06/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPLayer.h"



@interface ArduinoServices : NSObject<HTTPDelegate>

@property(nonatomic, strong) NSString* requestType;

@end
