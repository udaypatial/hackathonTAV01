//
//  AppDelegate.h
//  LTBLite
//
//  Created by TAVANT on 5/22/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>		
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"

#import "ControlBoardController.h"

extern NSString  *const FBSessionStateChangeNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ViewController *viewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
-(BOOL) openSessionWithAllowLoginUI: (BOOL) allowLoginUI;
@end
