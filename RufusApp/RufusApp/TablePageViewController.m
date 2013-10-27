//
//  TablePageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/20/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "TablePageViewController.h"
#import "LabelAPageViewController.h"

@interface TablePageViewController ()

@end

@implementation TablePageViewController
@synthesize ascending, descending, notSorted;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        labels = [self makeLabels];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ascending setAccessibilityLabel:@"ascending"];
    [descending setAccessibilityLabel:@"descending"];
    [notSorted setAccessibilityLabel:@"notSorted"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [labels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = nil;
    
    if ([[tableView accessibilityLabel] isEqualToString:[ascending accessibilityLabel]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Ascending"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ascending"];
        }
        UILabel *text = [labels objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[text text]];
    } else if ([[tableView accessibilityLabel] isEqualToString:[descending accessibilityLabel]])  {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Descending"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Descending"];
        }

        UILabel *text = [labels objectAtIndex:([labels count] - 1) - [indexPath row]];
        [[cell textLabel] setText:[text text]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Unsorted"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Unsorted"];
        }
        

        if ([indexPath row] % 2 == 0) {
            [[cell textLabel] setText:@"x"];
        } else {
            [[cell textLabel] setText:@"j"];
        }
       
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *label = [labels objectAtIndex:[indexPath row] - 1];
    NSLog(@"Index Path row %d", [indexPath row]);
    if ([[label text] isEqualToString:@"a"]) {
        LabelAPageViewController *labelAPageViewController = [[LabelAPageViewController alloc] init];
        [[self navigationController] pushViewController:labelAPageViewController animated:YES];
    }
}

-(NSArray *) makeLabels
{
    
    UILabel *one = [[UILabel alloc] init];
    [one setText:@"1"];
    UILabel *two = [[UILabel alloc] init];
    [two setText:@"2"];
    UILabel *three = [[UILabel alloc] init];
    [three setText:@"3"];

    UILabel *a = [[UILabel alloc] init];
    [a setText:@"a"];
    UILabel *b = [[UILabel alloc] init];
    [b setText:@"b"];
    UILabel *c = [[UILabel alloc] init];
    [c setText:@"c"];
    UILabel *d = [[UILabel alloc] init];
    [d setText:@"d"];
    UILabel *e = [[UILabel alloc] init];
    [e setText:@"e"];
    
    NSMutableArray *tableLabels = [[NSMutableArray alloc] init];
    [tableLabels addObject:one];
    [tableLabels addObject:two];
    [tableLabels addObject:three];
    [tableLabels addObject:a];
    [tableLabels addObject:b];
    [tableLabels addObject:c];
    [tableLabels addObject:d];
    [tableLabels addObject:e];
    
    return tableLabels;
    
}


- (IBAction)toButtonTables:(id)sender {
}
@end
