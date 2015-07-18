//
//  SplashModelController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 01/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashDataViewController;

@interface SplashModelController : NSObject <UIPageViewControllerDataSource>

- (SplashDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(SplashDataViewController *)viewController;

@end