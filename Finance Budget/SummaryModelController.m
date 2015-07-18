//
//  SummaryModelController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 04/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SummaryModelController.h"
#import "SummaryDataViewController.h"

@interface SummaryModelController ()

@end

@implementation SummaryModelController

- (instancetype)init {
	self = [super init];
	return self;
}

- (SummaryDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
	// Return the data view controller for the given index.
	SummaryDataViewController *dataViewController;

	// Create a new view controller and pass suitable data.
	switch (index) {
		case 0:
			dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"SummaryViewController"];
			return dataViewController;
			break;

		case 1:
			dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"graphWeekController"];
			return dataViewController;
			break;

		case 2:
			dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"graphMonthController"];
			return dataViewController;
			break;

		default:
			return nil;
			break;
	}
}

- (NSUInteger)indexOfViewController:(SummaryDataViewController *)viewController {
	// Return the index of the given data view controller.
	// For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
	if ([viewController.restorationIdentifier isEqual: @"SummaryViewController"]) return 0;
	if ([viewController.restorationIdentifier isEqual: @"graphWeekController"]) return 1;
	if ([viewController.restorationIdentifier isEqual: @"graphMonthController"]) return 2;

	return NSNotFound;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	NSUInteger index = [self indexOfViewController:(SummaryDataViewController *)viewController];

	[self.pageControl setCurrentPage:index];

	switch (index) {
		case 0:
			self.pageControl.currentPageIndicatorTintColor = self.brandColor;
			break;

		case 1:
		case 2:
			self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
			break;
	}

	if ((index == 0) || (index == NSNotFound)) {
		return nil;
	}

	index--;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	NSUInteger index = [self indexOfViewController:(SummaryDataViewController *)viewController];

	[self.pageControl setCurrentPage:index];

	switch (index) {
		case 0:
			self.pageControl.currentPageIndicatorTintColor = self.brandColor;
			break;

		case 1:
		case 2:
			self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
			break;
	}

	if (index == NSNotFound) {
		return nil;
	}

	index++;
	if (index == 3) {
		return nil;
	}
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end