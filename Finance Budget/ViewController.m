//
//  ViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 20/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	// Load the settings
	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];

	// Set the tab bar's tint color to white since this does not work using the
	// Interface Builder
	self.tabBar.tintColor = [UIColor whiteColor];

	// Set the tab bar items' selected images since this does not work using the
	// Interface Builder
	self.tabBar.items[0].selectedImage = [UIImage imageNamed:@"summarySelected"];
	self.tabBar.items[1].selectedImage = [UIImage imageNamed:@"expensesSelected"];
	self.tabBar.items[2].selectedImage = [UIImage imageNamed:@"incomeSelected"];
	self.tabBar.items[3].selectedImage = [UIImage imageNamed:@"calculatorSelected"];
	self.tabBar.items[4].selectedImage = [UIImage imageNamed:@"settingsSelected"];
}

- (void)viewDidAppear:(BOOL)animated {
	// Load the splash view if necessary
	if (self.settings.getSplash == NO) [self presentViewController:[[UIStoryboard storyboardWithName:@"Splash" bundle:nil] instantiateInitialViewController] animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end