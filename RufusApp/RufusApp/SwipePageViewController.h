//
//  SwipePageViewController.h
//  RufusApp
//
//  Created by Jeremy Stewart on 10/18/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipePageViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController; 

@end
