//
//  MenuViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostJsonInteraction.h"
#import "SalesTotalsSelectionViewController.h"
#import "SalesComparisonSelectionsViewController.h"
#import "TopSalesViewController.h"

#define rkFullName @"fullName"
#define rkIsLoggedIn @"isLoggedIn"

@interface MenuViewController : UIViewController
{
    IBOutlet UILabel *welcomeLabel;
}

- (IBAction)salesTotalsButtonPress;
- (IBAction)salesCompButtonPress;
- (IBAction)shippingStatsButtonPress;
- (IBAction)topSalesButtonPress;

@end
