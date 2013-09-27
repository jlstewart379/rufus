//
//  RUViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 8/15/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "RUViewController.h"
#import "RufusPageViewController.h"

@interface RUViewController ()

@end

@implementation RUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toRufusPage:(id)sender {
    RufusPageViewController *rufusPageViewController = [[RufusPageViewController alloc] init];
    [[self navigationController] pushViewController:rufusPageViewController animated:YES]; 
}

- (IBAction)showAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rufus Alert" message:@"You've chosen to show the rufus alert" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView = nil;
    }
    else
    {
        [self toRufusPage:nil];
    }
    
}

@end
