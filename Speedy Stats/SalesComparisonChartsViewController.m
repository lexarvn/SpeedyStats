//
//  SalesComparisonChartsViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "SalesComparisonChartsViewController.h"

@implementation SalesComparisonChartsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

-(void)setData:(NSDictionary *) inData
{
    data = inData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *transparent = [UIColor colorWithWhite:0 alpha:0];
    unitsChart.backgroundColor = revenueChart.backgroundColor = legendLeftHalf.backgroundColor = legendRightHalf.backgroundColor = transparent;
    
    NSArray *breakdown = [data objectForKey:rkBreakdown];
    
    int totalUnits = [[data objectForKey:rkTotalUnits] integerValue];
    float totalRevenue = [[data objectForKey:rkTotalRevenue] floatValue];

    [unitsChart setDataToDraw:data totalKey:rkTotalUnits partsKey:rkUnits];
    [revenueChart setDataToDraw:data totalKey:rkTotalRevenue partsKey:rkRevenue];
    
    [unitsChart setNeedsDisplay];
    [revenueChart setNeedsDisplay];
    
    UILabel *unitChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 420, 400, 50)];
    unitChartLabel.text = [NSString stringWithFormat:@"Total items sold: %d",totalUnits];
    unitChartLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    unitChartLabel.backgroundColor = transparent;
    unitChartLabel.textAlignment = NSTextAlignmentCenter;
    [unitsChart addSubview:unitChartLabel];
    
    UILabel *revenueChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 420, 400, 50)];
    revenueChartLabel.text = [NSString stringWithFormat:@"Total Revenue from sales: $%.2f", totalRevenue];
    revenueChartLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    revenueChartLabel.backgroundColor = transparent;
    revenueChartLabel.textAlignment = NSTextAlignmentCenter;
    [revenueChart addSubview:revenueChartLabel];
    
    for(int i=0; i < breakdown.count; i++)
    {
        int xOffset = 64;
        int yOffset = 0;
        UIView *legend = legendLeftHalf;
        if(i%2)
        {
            legend = legendRightHalf;
        }
        yOffset += 50*(i/2);
        
        UIView *colorIndicator = [[UIView alloc] initWithFrame:CGRectMake(xOffset, yOffset, 44, 44)];
        [colorIndicator setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        UIView *color = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        NSDictionary *dataColor = [breakdown[i] objectForKey:rkColor];
        [color setBackgroundColor:[UIColor colorWithRed:[[dataColor objectForKey:rkRed] floatValue] green:[[dataColor objectForKey:rkGreen] floatValue] blue:[[dataColor objectForKey:rkBlue] floatValue] alpha:1]];
        [colorIndicator addSubview:color];
        [legend addSubview:colorIndicator];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset+60, yOffset, 300, 50)];
        label.text = [breakdown[i] objectForKey:rkName];
        label.textColor = [UIColor colorWithWhite:1 alpha:1];
        label.backgroundColor = transparent;
        [legend addSubview:label];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
