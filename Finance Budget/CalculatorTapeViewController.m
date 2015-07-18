//
//  CalculatorTapeViewController.m
//  Calculator
//
//  Created by Kristian Matthews on 19/02/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "CalculatorTapeViewController.h"

@interface CalculatorTapeViewController ()

// Displays
@property (weak, nonatomic) IBOutlet UITextView *tapeDisplay;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation CalculatorTapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tapeDisplay.text = self.tape;

    if (self.allCleared) {
        [self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
    } else {
        [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end