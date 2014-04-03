//
//  SalesComparisonSelectionsViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostJsonInteraction.h"
#import "SalesComparisonChartsViewController.h"

#define qfGetSalesComparisonSelections @"getSalesComparisonSelections"
#define qfGetSalesComparison @"getSalesComparison"

#define qkIDs @"ids"
#define qkType @"type"
#define qkStartDate @"startDate"
#define qkEndDate @"endDate"

#define rkData @"data"
#define rkCategories @"categories"
#define rkItems @"items"
#define rkSectionTitles @"sectionTitles"
#define rkSections @"sections"
#define rkType @"type"
#define rkName @"name"
#define rkID @"id"
#define rkDetails @"details"

@interface SalesComparisonSelectionsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UITableView *selectionTable;
    NSDictionary *data;

    IBOutlet UIDatePicker *startDate;
    IBOutlet UIDatePicker *endDate;
    IBOutlet UIButton *goButton;
    IBOutlet UISegmentedControl *presetsControl;

    IBOutlet UIPickerView *groupingPicker;
    NSArray *groupings;
    NSString *selectedGrouping;
    /*
     data structure
     {
         rkCategories => {
             rkSectionTitles => [sectionIndex](NSString*),
             rkSections => [sectionIndex][rowIndex]
             {
                 rkName => (NSString*),
                 rkType => int,
                 rkID => int,
                 rkDetails => (NSString*)
             }
         }
         rkItems => {
             rkSectionTitles => [sectionIndex](NSString*),
             rkSections => [sectionIndex][rowIndex]
             {
                 rkName => (NSString*),
                 rkType => int,
                 rkID => int,
                 rkDetails => (NSString*)
             }
         }
     }
     */
}
- (IBAction)dateChanged;

- (IBAction)presetChanged:(UISegmentedControl *)sender;

- (IBAction)goPressed;


@end
