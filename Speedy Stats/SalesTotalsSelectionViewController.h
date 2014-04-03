//
//  SalesTotalsSelectionViewController.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/18/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostJsonInteraction.h"

#define qfGetSalesTotalsSelection @"getSalesTotalsSelection"
#define qfGetSalesTotals @"getSalesTotals"

#define qkID @"id"
#define qkType @"type"
#define qkStartDate @"startDate"
#define qkEndDate @"endDate"

#define rkData @"data"
#define rkSectionTitles @"sectionTitles"
#define rkSections @"sections"
#define rkType @"type"
#define rkName @"name"
#define rkID @"id"
#define rkDetails @"details"

@interface SalesTotalsSelectionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *selectionTable;
    NSDictionary *data;
    NSDictionary *selection;
    
    IBOutlet UIDatePicker *startDate;
    IBOutlet UIDatePicker *endDate;
    IBOutlet UIButton *goButton;
    IBOutlet UISegmentedControl *presetsControl;
    /*
    data structure
    {
        rkSectionTitles => [sectionIndex](NSString*),
        rkSections => [sectionIndex][rowIndex]
        {
            rkName => (NSString*),
            rkType => int,
            rkID => int,
            rkDetails => (NSString*)
        }
    }
    */
}
- (IBAction)dateChanged;

- (IBAction)presetChanged:(UISegmentedControl *)sender;

- (IBAction)goPressed;

@end
