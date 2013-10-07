//
//  RUViewController.h
//  RufusApp
//
//  Created by Jeremy Stewart on 8/15/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *existsPageButton;
@property (weak, nonatomic) IBOutlet UIButton *showAlertButton;
@property (weak, nonatomic) IBOutlet UIButton *rufusButton;
- (IBAction)toRufusPage:(id)sender;
- (IBAction)showAlert:(id)sender;
- (IBAction)toExistsPage:(id)sender;


@end
