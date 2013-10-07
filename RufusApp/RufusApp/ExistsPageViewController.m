//
//  ExistsViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/6/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "ExistsPageViewController.h"

@interface ExistsPageViewController ()

@end

@implementation ExistsPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self performSelector:@selector(showAlert) withObject:nil afterDelay:5]; 
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

-(void) showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This Alert Exists" message:@"Once this alert exists, :active? can return true on the page object." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    [alert show];

}



@end
