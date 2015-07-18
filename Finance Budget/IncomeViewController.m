//
//  IncomeViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 13/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "IncomeViewController.h"
#import "ExpensesIncomeMasterViewController.h"
#import "ExpensesIncomeDetailViewController.h"
#import "AddExpenseIncomeViewController.h"

@interface IncomeViewController () <UISplitViewControllerDelegate>

@end

@implementation IncomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];

	UINavigationController *navigationController = [self.viewControllers lastObject];
	navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem;
	self.delegate = self;

	UINavigationController *masterNavigationController = self.viewControllers[0];
	ExpensesIncomeMasterViewController *controller = (ExpensesIncomeMasterViewController *)masterNavigationController.topViewController;
	controller.managedObjectContext = self.managedObjectContext;

	Tab *tab = [Tab alloc];

	tab.tab = FBTabIncome;

	controller.tab = tab;

	controller.title = tab.masterTitle;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Split View

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
	if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[ExpensesIncomeDetailViewController class]] && ([(ExpensesIncomeDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
		// Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
		return YES;
	} else {
		return NO;
	}
}

@end