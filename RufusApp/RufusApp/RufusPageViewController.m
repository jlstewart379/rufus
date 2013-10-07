//
//  RufusPageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 8/15/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "RufusPageViewController.h"
#import "RUViewController.h"

@interface RufusPageViewController ()

@end

@implementation RufusPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self performSelector:@selector(addLabelToScreen) withObject:nil afterDelay:3]; 
        
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

- (IBAction)goToHomePage:(id)sender {
    
    RUViewController *ruViewController = [[RUViewController alloc] init];
    [[self navigationController] pushViewController:ruViewController animated:YES];
}


@end
