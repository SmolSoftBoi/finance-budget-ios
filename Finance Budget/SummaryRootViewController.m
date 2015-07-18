//
//  SummaryRootViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SummaryRootViewController.h"
#import "SummaryDataViewController.h"

@interface SummaryRootViewController ()

@property (readonly, strong, nonatomic) SummaryModelController *modelController;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation SummaryRootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	// Configure the page view controller and add it as a child view controller.
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
	self.pageViewController.delegate = self;

	SummaryDataViewController *summaryViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
	NSArray *viewControllers = @[summaryViewController];
	[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

	self.pageViewController.dataSource = self.modelController;

	// Insert the subview between the background and page control
	[self addChildViewController:self.pageViewController];
	[self.view insertSubview:self.pageViewController.view atIndex:1];

	[self.pageViewController didMoveToParentViewController:self];

	// Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
	self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)viewDidLayoutSubviews {
	// Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
	CGRect pageViewRect = CGRectMake(0.0, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height);
	pageViewRect = CGRectInset(pageViewRect, 0.0, 0.0);
	self.pageViewController.view.frame = pageViewRect;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (SummaryModelController *)modelController {
	// Return the model controller object, creating it if necessary.
	// In more complex implementations, the model controller may be passed to the view controller.
	if (!_modelController) {
		_modelController = [[SummaryModelController alloc] init];

		_modelController.pageControl = self.pageControl;
		_modelController.brandColor = self.pageControl.currentPageIndicatorTintColor;
	}
	return _modelController;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
	if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
		// In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.

		UIViewController *currentViewController = self.pageViewController.viewControllers[0];
		NSArray *viewControllers = @[currentViewController];
		[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

		self.pageViewController.doubleSided = NO;
		return UIPageViewControllerSpineLocationMin;
	}

	// In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
	SummaryDataViewController *currentViewController = self.pageViewController.viewControllers[0];
	NSArray *viewControllers = nil;

	NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
	if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
		UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
		viewControllers = @[currentViewController, nextViewController];
	} else {
		UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
		viewControllers = @[previousViewController, currentViewController];
	}
	[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];


	return UIPageViewControllerSpineLocationMid;
}

@end