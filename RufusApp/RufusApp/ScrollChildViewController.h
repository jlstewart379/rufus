//
//  ScrollPageViewController.h
//  RufusApp
//
//  Created by Jeremy Stewart on 10/18/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollChildViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *screenNumber;

-(void)setIndexLabel:(int) index; 

@end
