//
//  RUViewController.h
//  RufusApp
//
//  Created by Jeremy Stewart on 8/15/13.
//  Copyright (c) 2013 Northwoods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *displayedPageButton;

@property (weak, nonatomic) IBOutlet UIButton *existsPageButton;
@property (weak, nonatomic) IBOutlet UIButton *showAlertButton;
@property (weak, nonatomic) IBOutlet UIButton *rufusButton;
@property (weak, nonatomic) IBOutlet UIButton *enabledPageButton;
@property (weak, nonatomic) IBOutlet UIButton *scrollPageButton;
@property (weak, nonatomic) IBOutlet UIButton *tablePageButton;
@property (weak, nonatomic) IBOutlet UIButton *labeledButton;

- (IBAction)toEnabledPage:(id)sender;
- (IBAction)toRufusPage:(id)sender;
- (IBAction)showAlert:(id)sender;
- (IBAction)toExistsPage:(id)sender;
- (IBAction)toDisplayedPage:(id)sender;
- (IBAction)toSwipePage:(id)sender;
- (IBAction)toTablePage:(id)sender;
- (IBAction)toLabeledViewsPage:(id)sender;

@end
