//
//  SplashModelController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 01/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SplashModelController.h"
#import "SplashDataViewController.h"

@interface SplashModelController ()

@end

@implementation SplashModelController

- (instancetype)init {
	self = [super init];
	return self;
}

- (SplashDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
	// Return the data view controller for the given index.
	SplashDataViewController *dataViewController;

	// Create a new view controller and pass suitable data.
	switch (index) {
		case 0:
			dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"SplashIntroViewController"];
			return dataViewController;
			break;

		default:
			return nil;
			break;
	}
}

- (NSUInteger)indexOfViewController:(SplashDataViewController *)viewController {
	// Return the index of the given data view controller.
	// For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
	if ([viewController.restorationIdentifier isEqual: @"SplashIntroViewController"]) return 0;

	return NSNotFound;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	NSUInteger index = [self indexOfViewController:(SplashDataViewController *)viewController];
	if ((index == 0) || (index == NSNotFound)) {
		return nil;
	}

	index--;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	NSUInteger index = [self indexOfViewController:(SplashDataViewController *)viewController];
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