//
//  SummaryModelController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 04/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SummaryDataViewController;

@interface SummaryModelController : NSObject <UIPageViewControllerDataSource>

- (SummaryDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(SummaryDataViewController *)viewController;

@property (weak, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIColor *brandColor;

@end