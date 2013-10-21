//
//  TablePageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/20/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "TablePageViewController.h"

@interface TablePageViewController ()

@end

@implementation TablePageViewController
@synthesize table, unsortedTable;

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
    [table setAccessibilityLabel:@"table"];
    [unsortedTable setAccessibilityLabel:@"unsorted"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSLog(@"%@", [tableView accessibilityLabel]);
    
    if ([[tableView accessibilityLabel] isEqualToString:[table accessibilityLabel]]) {
        UILabel *text = [labels objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[text text]];
    } else {
        UILabel *text = [labels objectAtIndex:([labels count] - 1) - [indexPath row]];
        [[cell textLabel] setText:[text text]];
    }
    
    return cell;
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


@end
