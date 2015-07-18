//
//  SplashRootViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 01/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashModelController.h"

@interface SplashRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end