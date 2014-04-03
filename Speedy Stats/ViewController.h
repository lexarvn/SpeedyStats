//
//  ViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostJsonInteraction.h"
#import "MenuViewController.h"

#define qkUsername @"username"
#define qkPassword @"password"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UILabel *errorLabel;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *infoButton;
    IBOutlet UIActivityIndicatorView *activity;
    NSTimer *timer;
}

-(IBAction)loginButtonPress;
-(IBAction)infoButtonPress;
@end
