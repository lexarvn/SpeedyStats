//
//  MenuViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Menu";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetUserInfo,qkFunction, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];
    welcomeLabel.text = [NSString stringWithFormat:@"Logged in as: %@",[response objectForKey:rkFullName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)salesTotalsButtonPress
{
    SalesTotalsSelectionViewController *vc = [[SalesTotalsSelectionViewController alloc] initWithNibName:@"SalesTotalsSelectionViewController" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)salesCompButtonPress
{
    SalesComparisonSelectionsViewController *vc = [[SalesComparisonSelectionsViewController alloc] initWithNibName:@"SalesComparisonSelectionsViewController" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)shippingStatsButtonPress
{
    
}

- (IBAction)topSalesButtonPress
{
    TopSalesViewController *vc = [[TopSalesViewController alloc] initWithNibName:@"TopSalesViewController" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
