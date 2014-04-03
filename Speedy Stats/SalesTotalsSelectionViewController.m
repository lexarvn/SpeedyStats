//
//  SalesTotalsSelectionViewController.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/18/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "SalesTotalsSelectionViewController.h"


@implementation SalesTotalsSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Sales Totals";
        [self getData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectionTable.delegate = self;
    selectionTable.dataSource = self;
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
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetSalesTotalsSelection,qkFunction, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];
    
    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
            data = [response objectForKey:rkData];
        }
    }

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selection = [[[data objectForKey:rkSections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    NSLog(@"%@",selection);
    
    goButton.enabled = YES;
    
    return indexPath;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return [[data objectForKey:rkSectionTitles] count];
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return [[[data objectForKey:rkSections] objectAtIndex:section] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[data objectForKey:rkSectionTitles] objectAtIndex:section];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *unused = @"UNUSED";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unused];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unused];
    NSDictionary *cellData = [[[data objectForKey:rkSections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [cellData objectForKey:rkName];
    cell.detailTextLabel.text = nil;
    [cell.imageView setImage:nil];
    
    if(indexPath.section > 1)
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

    
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:qfGetSalesTotals,qkFunction,[selection objectForKey:rkID],qkID,[selection objectForKey:rkType],qkType,[formatter stringFromDate:startDate.date],qkStartDate,[formatter stringFromDate:endDate.date],qkEndDate, nil];
    NSDictionary *response = [PostJsonInteraction queryWithDictionary:request];
    
    if(response)
    {
        if([[response objectForKey:rkSuccess] boolValue])
        {
                UIAlertView *totals = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Totals for %@",[selection objectForKey:rkName]] message:[response objectForKey:rkDetails] delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
            
            [totals show];
        }
    }
    
}

@end
