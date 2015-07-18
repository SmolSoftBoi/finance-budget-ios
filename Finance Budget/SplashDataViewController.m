//
//  SplashDataViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 01/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SplashDataViewController.h"

@interface SplashDataViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;
@property (weak, nonatomic) IBOutlet UIImageView *launchScreenIconImageView;

@end

@implementation SplashDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];
}

- (void)viewDidAppear:(BOOL)animated {
	[UIView animateWithDuration:2.0 animations:^{
		self.splashImageView.alpha = 1.0;
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];

	[self.settings setSplash:YES];
}

@end