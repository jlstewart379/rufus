//
//  SwipePageViewController.m
//  RufusApp
//
//  Created by Jeremy Stewart on 10/18/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import "SwipePageViewController.h"
#import "ScrollChildViewController.h"

@interface SwipePageViewController ()

@end

@implementation SwipePageViewController

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
	
    [self setPageController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]];
    
    [[self pageController] setDataSource:self];
    
    [[[self pageController] view] setFrame:[[self view] bounds]];
    
    ScrollChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [[self pageController] setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil] ;
    
    [self addChildViewController:[self pageController]];
//    [[self view] addSubview:[[self pageController] view]];
    [[self pageController] didMoveToParentViewController:self];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGSize parentSize = self.pageController.view.frame.size;
    [scrollView setContentSize: CGSizeMake(initialViewController.view.frame.size.width * 3, parentSize.height)];
    [scrollView addSubview:[[self pageController] view]];
    [[self view] addSubview:scrollView];
    
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ScrollChildViewController *) viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ScrollChildViewController *)viewController index];
    
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (ScrollChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    ScrollChildViewController *childViewController = [[ScrollChildViewController alloc] initWithNibName:@"ScrollChildViewController" bundle:nil];
    [childViewController setIndex:index];
    
    return childViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


@end
