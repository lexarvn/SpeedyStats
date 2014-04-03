//
//  SalesComparisonSelectionsViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/21/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "SalesComparisonSelectionsViewController.h"

@implementation SalesComparisonSelectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                self.navigationItem.title = @"Comparison Selection";
                groupings = [[NSArray alloc] initWithObjects:@"Categories", @"Items", nil];
                selectedGrouping = rkCategories;
                [self getData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectionTable.delegate = self;
    selectionTable.dataSource = self;
    groupingPicker.delegate = self;
    groupingPicker.dataSource = self;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    startDate.minimumDate = [dateFormatter dateFromString: @"2012-10-01 00:00:00"];
    startDate.date = endDate.date = endDate.maximumDate = [NSDate date];
    [self setDateMinMax];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData
{
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetSalesComparisonSelections,qkFunction, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];

    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
            data = [response objectForKey:rkData];
        }
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[selectionTable indexPathsForSelectedRows] count] > 1)
    {
        goButton.enabled = YES;
    }
    else
    {
        goButton.enabled = NO;
    }
    
    if([[selectionTable indexPathsForSelectedRows] count] > 6)
    {
        [selectionTable deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[selectionTable indexPathsForSelectedRows] count] > 1)
    {
        goButton.enabled = YES;
    }
    else
    {
        goButton.enabled = NO;
    }
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return [[[data objectForKey:selectedGrouping] objectForKey:rkSectionTitles] count];
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return [[[[data objectForKey:selectedGrouping] objectForKey:rkSections] objectAtIndex:section] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[data objectForKey:selectedGrouping] objectForKey:rkSectionTitles] objectAtIndex:section];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *unused = @"UNUSED";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unused];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unused];
    NSDictionary *cellData = [[[[data objectForKey:selectedGrouping] objectForKey:rkSections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.textLabel.text = [cellData objectForKey:rkName];
    cell.detailTextLabel.text = nil;
    [cell.imageView setImage:nil];

    if([selectedGrouping isEqualToString:rkItems])
    {
        cell.detailTextLabel.text = [cellData objectForKey:rkDetails];
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://afk.jfarb.com/php/image.php?id=%d",[[cellData objectForKey:rkID] integerValue]]];
//        NSData *bin = [NSData dataWithContentsOfURL:url];
//        UIImage *img = [[UIImage alloc] initWithData:bin];
//        [cell.imageView setImage:img];
    }

    return cell;
}

- (IBAction)dateChanged
{
    presetsControl.selectedSegmentIndex = -1;
    [self setDateMinMax];
}

- (void)setDateMinMax
{
    startDate.maximumDate = endDate.date;
    endDate.minimumDate = startDate.date;
}

- (IBAction)presetChanged:(UISegmentedControl *)sender {
    endDate.date = [NSDate date];

    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:endDate.date];

    switch (sender.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            [components setDay:([components day] - ([components weekday] - 1))];
            break;
        case 2:
            [components setDay:([components day] - ([components day] - 1))];
            break;
        case 3:
            [components setDay:([components day] - ([components day] - 1))];
            [components setMonth:([components month] - ([components month] - 1))];
            break;
        default:
            break;
    }

    startDate.date = [cal dateFromComponents:components];
    [self setDateMinMax];
}

- (IBAction)goPressed {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSArray *indexPaths = [selectionTable indexPathsForSelectedRows];
    
    NSMutableString *ids = [[NSMutableString alloc] initWithString:@""];
    NSDictionary *cellData;
    
    for(NSIndexPath *path in indexPaths)
    {
        cellData = [[[[data objectForKey:selectedGrouping] objectForKey:rkSections] objectAtIndex:path.section] objectAtIndex:path.row];
        [ids appendFormat:@"%d,",[[cellData objectForKey:rkID] integerValue]];
    }
    
    [ids appendString:@"-1"];
    

    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetSalesComparison,qkFunction,ids,qkIDs,[cellData objectForKey:rkType],qkType,[formatter stringFromDate:startDate.date],qkStartDate,[formatter stringFromDate:endDate.date],qkEndDate, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];

    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
            SalesComparisonChartsViewController *vc = [[SalesComparisonChartsViewController alloc] initWithNibName:@"SalesComparisonChartsViewController" bundle:nil];
            [vc setData:[response objectForKey:rkData]];
            [vc setTitle:[NSString stringWithFormat:@"Comparison of %@",selectedGrouping]];
            [[self navigationController] pushViewController:vc animated:YES];
        }
    }

}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return groupings.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row == 0)
    {
        selectedGrouping = rkCategories;
    }
    else
    {
        selectedGrouping = rkItems;
    }
    NSArray *indexPaths = [selectionTable indexPathsForSelectedRows];
    
    for(NSIndexPath *path in indexPaths)
    {
        [selectionTable deselectRowAtIndexPath:path animated:NO];
    }

    [selectionTable reloadData];
    goButton.enabled = NO;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [groupings objectAtIndex:row];
}
@end
