//
//  ScrollPageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/18/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "ScrollChildViewController.h"

@interface ScrollChildViewController ()

@end

@implementation ScrollChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self screenNumber] setText:[NSString stringWithFormat:@"Screen #%d", [self index]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
