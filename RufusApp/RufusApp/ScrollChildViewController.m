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
@synthesize screenNumber; 


-(void)setIndexLabel:(int) index
{
     [[self screenNumber] setText:[NSString stringWithFormat:@"Screen #%d", index]];
}

@end
