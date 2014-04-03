//
//  PieChartUIView.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#define rkBreakdown @"breakdown"
#define rkColor @"color"
#define rkRed @"red"
#define rkGreen @"green"
#define rkBlue @"blue"

@interface PieChartUIView : UIView
{
    NSDictionary *dataToDraw;
    NSString *totalKey, *partsKey;
}

-(void)setDataToDraw:(NSDictionary*)data totalKey:(NSString*) tk partsKey:(NSString*) pk;

@end
