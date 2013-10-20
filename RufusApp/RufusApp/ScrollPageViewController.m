//
//  ScrollPageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/20/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "ScrollPageViewController.h"
#import "ScrollChildViewController.h"

@interface ScrollPageViewController ()

@end

@implementation ScrollPageViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView
{
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    
    [scrollView addSubview:[self getChildViewForIndex:1]];
    [scrollView addSubview:[self getChildViewForIndex:2]];
    [scrollView addSubview:[self getChildViewForIndex:3]];
    
    float childWidth = [self getChildViewForIndex:0].frame.size.width;
    float childHeight = [self getChildViewForIndex:0].frame.size.height;
    
    [scrollView setContentSize:CGSizeMake(childWidth * 3, childHeight)];
    
    [[self view] addSubview:scrollView];
}

-(UIView *)getChildViewForIndex:(int) index
{
    ScrollChildViewController *childViewController = [[ScrollChildViewController alloc] initWithNibName:@"ScrollChildViewController" bundle:nil];
    
    
    UIView *view = [childViewController view];
    
    switch (index) {
        case 1:
            [view setBackgroundColor:[UIColor blueColor]];
            [childViewController setIndexLabel:index];
            break;
        case 2:
        {
            [view setBackgroundColor:[UIColor redColor]];
            CGRect frame = CGRectMake([self view].frame.size.width, 0, [self view].frame.size.width, [self view].frame.size.height);
            [view setFrame:frame];
            [childViewController setIndexLabel:index];
            break;
        }
        case 3:
        {
            [view setBackgroundColor:[UIColor greenColor]];
            CGRect frame = CGRectMake([self view].frame.size.width * 2, 0, [self view].frame.size.width, [self view].frame.size.height);
            [view setFrame:frame];
            [childViewController setIndexLabel:index];
            break;
        }
        default:
            break;
    }
    return [childViewController view];
}

@end
