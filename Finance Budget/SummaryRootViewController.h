//
//  SummaryRootViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryModelController.h"

@interface SummaryRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end