//
//  RUViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 8/15/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "RUViewController.h"
#import "RufusPageViewController.h"
#import "ExistsPageViewController.h"
#import "DisplayedPageViewController.h"
#import "EnabledPageViewController.h"
#import "ScrollPageViewController.h"
#import "TablePageViewController.h"
#import "LabeledPageViewController.h"


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

- (IBAction)toExistsPage:(id)sender {
    
    ExistsPageViewController *existsPageViewController = [[ExistsPageViewController alloc] init];
    [[self navigationController] pushViewController:existsPageViewController animated:YES];
}

-(void)toEnabledPage:(id)sender
{
    EnabledPageViewController *enabledPageViewController = [[EnabledPageViewController alloc] init];
    [[self navigationController] pushViewController:enabledPageViewController animated:YES];
}

- (IBAction)toDisplayedPage:(id)sender {
    DisplayedPageViewController *displayedPageViewController = [[DisplayedPageViewController alloc] init];
    [[self navigationController] pushViewController:displayedPageViewController animated:YES];
}

- (IBAction)toSwipePage:(id)sender {
    ScrollPageViewController *scrollPageViewController = [[ScrollPageViewController alloc] init];
    [[self navigationController] pushViewController:scrollPageViewController animated:YES];
}

- (IBAction)toTablePage:(id)sender {
    TablePageViewController *tablePageViewController = [[TablePageViewController alloc] init];
    [[self navigationController] pushViewController:tablePageViewController animated:YES];
}

- (IBAction)toLabeledViewsPage:(id)sender {
    LabeledPageViewController *labeledPageViewController = [[LabeledPageViewController alloc] init];
    [[self navigationController] pushViewController:labeledPageViewController animated:YES]; 
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
