//
//  DisplayedPageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/7/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "DisplayedPageViewController.h"

@interface DisplayedPageViewController ()

@end

@implementation DisplayedPageViewController
@synthesize mysteryLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self performSelector:@selector(showMysteryLabel) withObject:nil afterDelay:6];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMysteryLabel
{
    [mysteryLabel setHidden:NO]; 
}

@end
