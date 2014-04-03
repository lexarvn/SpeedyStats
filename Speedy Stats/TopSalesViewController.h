//
//  TopSalesViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostJsonInteraction.h"

#define qfGetTopStats @"getTopStats"

#define rkTopItemsSold @"topItemsSold"
#define rkTopRevenueItems @"topRevenueItems"
#define rkTopSellingCategory @"topSellingCategory"
#define rkTopRevenueCategory @"topRevenueCategory"

@interface TopSalesViewController : UIViewController
{
    IBOutlet UILabel *topItemsSold;
    IBOutlet UILabel *topRevenueItems;
    IBOutlet UILabel *topSellingCategory;
    IBOutlet UILabel *topRevenueCategory;
    NSString *topItemsSoldString, *topRevenueItemsString, *topSellingCategoryString, *topRevenueCategoryString;
}
@end
