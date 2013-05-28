//
//  ViewController.h
//  LTBLite
//
//  Created by TAVANT on 5/22/13.
//  Copyright (c) 2013 com.tavant.ltblite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavViewController.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
- (IBAction)authButtonAction:(UIButton *)sender;
- (IBAction)test:(id)sender;

@end
