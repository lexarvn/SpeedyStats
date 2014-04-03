//
//  TopSalesViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "TopSalesViewController.h"

@interface TopSalesViewController ()

@end

@implementation TopSalesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Top Stats";
        [self getData];
    }
    return self;
}

- (void) getData
{
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetTopStats,qkFunction, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];
    
    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
            topItemsSoldString = [response objectForKey:rkTopItemsSold];
            topRevenueItemsString = [response objectForKey:rkTopRevenueItems];
            topSellingCategoryString = [response objectForKey:rkTopSellingCategory];
            topRevenueCategoryString = [response objectForKey:rkTopRevenueCategory];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    topItemsSold.text = topItemsSoldString;
    topRevenueItems.text = topRevenueItemsString;
    topSellingCategory.text = topSellingCategoryString;
    topRevenueCategory.text = topRevenueCategoryString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
