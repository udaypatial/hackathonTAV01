//
//  HTTPLayer.h
//  ACT
//
//  Created by Tavant on 01/02/13.
//  Copyright (c) 2013 Tavant. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPDelegate <NSObject>

-(void) errorCallback:(NSString*) errorCode;
//-(void) didReceivePassportToken:(NSString*) result;
-(void) successCallBack:(NSData*) responseData;

@end

@interface HTTPLayer : NSObject<NSURLConnectionDataDelegate> {
    BOOL hasRequestFailed;
}

@property (nonatomic, strong) id<HTTPDelegate> httpDelegate;
@property (nonatomic, retain) NSMutableURLRequest *asycRequest;
@property (nonatomic, retain) NSURLConnection *nsurlConnection;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isFinished;

//@property (strong, nonatomic) NSURLConnection *nsurlConnection;

- (id) initWithDelegate:(id<HTTPDelegate>) theDelegate;
- (NSData*)post:(NSString*)url:(NSMutableDictionary *)headers:(NSString*)content;
-(void) executeRequest:(NSString*)url:(NSMutableDictionary *)headers:(NSString*)content;

@end
