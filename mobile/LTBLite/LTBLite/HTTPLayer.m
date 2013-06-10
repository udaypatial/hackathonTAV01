//
//  HTTPLayer.m
//  ACT
//
//  Created by Tavant on 01/02/13.
//  Copyright (c) 2013 Tavant. All rights reserved.
//

#import "HTTPLayer.h"

@implementation HTTPLayer
@synthesize httpDelegate, asycRequest, nsurlConnection;
@synthesize responseData, isFinished;

- (id) initWithDelegate:(id<HTTPDelegate>) theDelegate{
    if ((self = [super init])) {
		self.httpDelegate = theDelegate;
        responseData = [[NSMutableData alloc] init];
        hasRequestFailed = NO;
	}
		
	return self;
}

-(void) executeRequest:(NSString*)url:(NSMutableDictionary *)headers:(NSString*)content{
    NSURL* requestURL = [NSURL URLWithString:url];
    asycRequest = [NSMutableURLRequest requestWithURL: requestURL];
	[asycRequest setHTTPMethod:@"POST"];
    
    NSArray *headerKeyArray = [headers allKeys];
    
    for(NSString *headerKey in headerKeyArray){
        [asycRequest addValue:[headers valueForKey:headerKey] forHTTPHeaderField:headerKey];
    }
    
    [asycRequest setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
    self.nsurlConnection = [[NSURLConnection alloc] initWithRequest:asycRequest delegate:self];
    while(!isFinished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


// ------------------------------------------------------------------------------------------------------------------------
#pragma mark NSURLConnection Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   	if ([response respondsToSelector:@selector(statusCode)]) {
		int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        NSLog(@"status code is %d",statusCode);
		if (statusCode >= 400) {
			hasRequestFailed = YES;
		}
        [self.responseData setLength:0];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    connection = nil;
    responseData = nil;
    NSLog(@"Please try again later (error: %@).", [error localizedDescription]);
    [httpDelegate
     errorCallback:[NSString stringWithFormat: @"Please try again later (error: %@).", [error localizedDescription]]];
        
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    isFinished = YES;
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding] ;
    NSLog(@"response string is %@",responseString);
    
    if(!hasRequestFailed){
        [httpDelegate successCallBack:responseData];
    }else{
        NSString* errorMsg = [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding];
        
        NSLog(@" Server failure message: %@", errorMsg);
        
        if (httpDelegate != nil) {
            [httpDelegate errorCallback:errorMsg];
        }
        
    }
    
    responseString = nil;
    
    connection = nil;
    responseData = nil;
    
}



@end
