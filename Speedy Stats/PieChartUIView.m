//
//  PieChartUIView.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "PieChartUIView.h"

@implementation PieChartUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setDataToDraw:(NSDictionary*) data totalKey:(NSString*) tk partsKey:(NSString*) pk
{
    dataToDraw = data;
    totalKey = tk;
    partsKey = pk;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"%@",dataToDraw);
    
    float total = [[dataToDraw objectForKey:totalKey] floatValue];
    float cummulativePercent = 0.0;
    
    if(total != 0)
    {
        for(NSDictionary* entry in [dataToDraw objectForKey:rkBreakdown])
        {
            CGPoint origin = CGPointMake(236, 200);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(ctx, 1.0);
            
            NSDictionary *dataColor = [entry objectForKey:rkColor];
            
            [[UIColor colorWithRed:[[dataColor objectForKey:rkRed] floatValue] green:[[dataColor objectForKey:rkGreen] floatValue] blue:[[dataColor objectForKey:rkBlue] floatValue] alpha:1] set];
            
            float startAngle = cummulativePercent*2*M_PI;
            cummulativePercent += [[entry objectForKey:partsKey] floatValue]/total;
            float endAngle = cummulativePercent*2*M_PI;
            
            float midAngle = (startAngle + endAngle)/2.0;
            
            CGPoint labelOrigin = CGPointMake(206+cos(midAngle)*185, 175+sin(midAngle)*185);
            
            CGRect labelRect = CGRectMake(labelOrigin.x, labelOrigin.y, 60, 50);
            
            UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
            
            label.text = [NSString stringWithFormat:@"%.1f%%",([[entry objectForKey:partsKey] floatValue]/total)*100];
            
            label.textColor = [UIColor colorWithWhite:1 alpha:1];
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            
            [self addSubview:label];
            
            CGContextMoveToPoint(ctx, origin.x, origin.y );
            
            CGContextAddArc(ctx, origin.x, origin.y, 150, startAngle, endAngle, NO);
            
            CGContextClosePath(ctx);
    //        CGContextStrokePath(ctx);
            CGContextFillPath(ctx);
            
        }
    }
}


@end
