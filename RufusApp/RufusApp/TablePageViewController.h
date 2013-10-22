//
//  TablePageViewController.h
//  RufusApp
//
//  Created by Jeremy Stewart on 10/20/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TablePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *labels;
    NSArray *unsorted;
}

@property (weak, nonatomic) IBOutlet UITableView *ascending;
@property (weak, nonatomic) IBOutlet UITableView *descending;
@property (weak, nonatomic) IBOutlet UILabel *sortedLabel;
@property (weak, nonatomic) IBOutlet UILabel *unsortedLabel;
@property (weak, nonatomic) IBOutlet UITableView *notSorted;

@end
