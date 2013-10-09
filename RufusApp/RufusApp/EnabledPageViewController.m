//
//  EnabledPageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/7/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "EnabledPageViewController.h"

@interface EnabledPageViewController ()

@end

@implementation EnabledPageViewController
@synthesize enabledTextField, notEnabledTextField;



-(void)viewDidLoad
{
    [enabledTextField setEnabled:NO];
    [notEnabledTextField setEnabled:NO];
    [self performSelector:@selector(enableTheTextField) withObject:nil afterDelay:5];
}

-(void)enableTheTextField
{
    [enabledTextField setEnabled:YES];
}



@end
