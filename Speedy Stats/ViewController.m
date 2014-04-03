//
//  ViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(void)gotoMenu
{
    MenuViewController* vc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(IBAction)infoButtonPress
{
    [self dismissKeyboard];
    UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"About" message:@"This app was made as a companion to the faux shopping website afk.jfarb.com\n\n\n" delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 115, 40, 40)];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JF" ofType:@"png"]];
    [imageView setImage:image];
    [info addSubview:imageView];
    [info show];
}

-(IBAction)loginButtonPress
{
    [self dismissKeyboard];
    errorLabel.hidden = loginButton.hidden = YES;
    infoButton.enabled = usernameTextField.enabled = passwordTextField.enabled = NO;
    [activity startAnimating];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(login) userInfo:nil repeats:NO];
}

-(void)login
{
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfLogin,qkFunction,usernameTextField.text,qkUsername,passwordTextField.text,qkPassword, nil];
    
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];
    
    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
            [self gotoMenu];
        }
        else
        {
            if([[response objectForKey:rkErrorKey] isEqual:ekNotAdmin])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Permission Error" message:[response objectForKey:rkErrorMessage] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                errorLabel.text = [response objectForKey:rkErrorMessage];
                errorLabel.hidden = NO;
            }
        }
    }
    
    [activity stopAnimating];
    loginButton.hidden = NO;
    infoButton.enabled = usernameTextField.enabled = passwordTextField.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    usernameTextField.delegate = passwordTextField.delegate = self;
    [usernameTextField becomeFirstResponder];
    
    [self.view addGestureRecognizer:tap];
//#if (DEBUG)
//    usernameTextField.text = @"admin";
//    passwordTextField.text = @"teamafk";
//    [self loginButtonPress];
//#endif
}

-(BOOL)textFieldShouldReturn:(UITextField *)tf
{
    if(tf == usernameTextField)
    {
        [passwordTextField becomeFirstResponder];
    }
    else
    {
        [self loginButtonPress];
    }
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)tf
{
    [tf resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
