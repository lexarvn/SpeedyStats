//
//  SalesComparisonChartsViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartUIView.h"

#define rkTotalUnits @"totalUnits"
#define rkTotalRevenue @"totalRevenue"
#define rkBreakdown @"breakdown"
#define rkUnits @"units"
#define rkRevenue @"revenue"
#define rkName @"name"
#define rkColor @"color"
#define rkRed @"red"
#define rkGreen @"green"
#define rkBlue @"blue"

@interface SalesComparisonChartsViewController : UIViewController
{
    IBOutlet PieChartUIView *unitsChart;
    IBOutlet PieChartUIView *revenueChart;
    
    IBOutlet UIView *legendLeftHalf;
    IBOutlet UIView *legendRightHalf;
    
    NSDictionary *data;
    /*
     data structure
     {
         totalUnits => int,
         totalRevenue => float,
         breakdown => [index]
         {
             units => int,
             revenue => float,
             name => (NSString),
             color =>
             {
                 red => int,
                 green => int,
                 blue => int
             }
         }
     }
     */

}

-(void)setTitle:(NSString *)title;
-(void)setData:(NSDictionary *) inData;

@end
