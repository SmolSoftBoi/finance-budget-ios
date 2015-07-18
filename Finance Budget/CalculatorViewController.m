//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Kristian Matthews on 02/02/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorTapeViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

// Labels
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *radDisplay;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *radianButton;
@property (weak, nonatomic) IBOutlet UIButton *shiftButton;
@property (weak, nonatomic) IBOutlet UIButton *sinButton;
@property (weak, nonatomic) IBOutlet UIButton *cosButton;
@property (weak, nonatomic) IBOutlet UIButton *tanButton;

@property (nonatomic) BOOL allCleared;
@property (nonatomic) BOOL enteringNumber;
@property (nonatomic) BOOL enteredDecimal;
@property (nonatomic) BOOL enteredNegative;
@property (nonatomic) BOOL enteredOperation;
@property (nonatomic) BOOL radian;
@property (nonatomic) BOOL shift;

// The brain
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

// Initialise the brain
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
	if ( ! _brain) _brain = [[CalculatorBrain alloc] init];

	return _brain;
}

- (void)viewDidLoad {
	[self load];

	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.allCleared = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) == YES) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	} else {
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) == YES) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	} else {
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
}

// Display swiped
// Removes the last character from the display.
- (IBAction)displaySwiped:(id)sender {
	if ([@"Error" isEqualToString:self.display.text]) {
		self.display.text = @"0";
	} else if (self.display.text.length > 1) {
		if ([@"." isEqualToString:[self.display.text substringFromIndex:self.display.text.length - 1]]) self.enteredDecimal = NO;

		self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
	} else {
		self.display.text = @"0";

		self.enteringNumber = NO;
	}

	[self save];
}

// Digit pressed
// Add the digit or decimal pressed to the display.
- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = sender.currentTitle;

	if ([@"." isEqualToString:digit]) {
		if ( ! self.enteredDecimal) {
			self.display.text = [self.display.text stringByAppendingString:digit];

			self.enteredDecimal = YES;

			self.enteringNumber = YES;
		}
	} else if (self.enteringNumber) {
		self.display.text = [self.display.text stringByAppendingString:digit];
	} else {
		if ( ! [@"0" isEqualToString:digit]) {
			if (self.enteredNegative) {
				self.display.text = [@"-" stringByAppendingString:digit];
			} else {
				self.display.text = digit;
			}

			self.enteringNumber = YES;
		}
	}

	if (self.enteringNumber && self.allCleared) {
		[self.clearButton setTitle:@"C" forState:UIControlStateNormal];

		self.allCleared = NO;
	}

	[self save];
}

// Operation pressed
// Send the number and basic operation pressed to the brain, and display any results.
- (IBAction)operationPressed:(UIButton *)sender {
	NSString *operation = sender.currentTitle;

	if (self.enteredOperation) {
		[self enterPressed];

		self.enteredOperation = NO;
	}

	if ([@"+/-" isEqualToString:operation]) {
		if (self.enteredNegative) {
			self.display.text = [self.display.text substringFromIndex:1];

			self.enteredNegative = NO;
		} else {
			self.display.text = [@"-" stringByAppendingString:self.display.text];

			self.enteredNegative = YES;
		}
	} else {
		if (self.enteringNumber) {
			[self.brain pushNumber:[self.display.text doubleValue]];

			if (self.enteredNegative) self.enteredNegative = NO;

			self.enteringNumber = NO;
		}

		[self.brain pushOperation:operation];

		if (self.allCleared) {
			[self.clearButton setTitle:@"C" forState:UIControlStateNormal];

			self.allCleared = NO;
		}
	}

	self.enteredOperation = YES;

	[self save];
}

// Scientific operation pressed
// Send the number and scientific operation pressed to the brain, and display the results.
- (IBAction)scientificOperationPressed:(UIButton *)sender {
	NSString *operation = sender.currentTitle;

	if ([@"1/x" isEqualToString:operation] && [self.display.text doubleValue] == 0) {
		self.display.text = @"Error";
	} else {
		if ([@"π" isEqualToString:operation]) {
			self.display.text = @"3.141592653589793";

			self.enteringNumber = YES;

			self.enteredDecimal = YES;
			self.enteredNegative = NO;
		} else {
			[self.brain pushNumber:[self.display.text doubleValue]];

			self.display.text = [NSString stringWithFormat:@"%g", [self.brain performScientificOperation:operation]];
		}

		if (self.allCleared) {
			[self.clearButton setTitle:@"C" forState:UIControlStateNormal];

			self.allCleared = NO;
		}
	}

	if (self.enteredNegative) self.enteredNegative = NO;

	if (self.enteringNumber) self.enteringNumber = NO;

	[self save];
}

// Enter pressed
// Tell the brain to perform the operation, and display the results.
- (IBAction)enterPressed {
	if (self.enteringNumber) {
		[self.brain pushNumber:[self.display.text doubleValue]];

		if (self.enteredNegative) self.enteredNegative = NO;

		self.enteringNumber = NO;
	}

	self.display.text = [NSString stringWithFormat:@"%g", [self.brain performOperation]];

	[self save];
}

// Clear pressed
// Clear the data.
- (IBAction)clearPressed {
	self.display.text = @"0";

	[self.brain clear:NO];

	if (self.enteringNumber) self.enteringNumber = NO;
	if (self.enteredDecimal) self.enteredDecimal = NO;
	if (self.enteredNegative) self.enteredNegative = NO;

	if (self.allCleared) {
		[self.brain clear:YES];
	} else {
		[self.clearButton setTitle:@"AC" forState:UIControlStateNormal];

		self.allCleared = YES;
	}

	[self save];
}

// Radian pressed
// Toggle between radian and degrees.
- (IBAction)radianPressed {
	if (self.radian) {
		[self radianState:NO];
	} else {
		[self radianState:YES];
	}

	[self save];
}

// Radian state
// Set radian or degrees.
- (void)radianState:(BOOL)radian {
	if (radian) {
		[self.radianButton setTitle:@"Deg" forState:UIControlStateNormal];
		[self.radDisplay setHidden:NO];

		[self.brain toggleRadian:YES];

		self.radian = YES;
	} else {
		[self.radianButton setTitle:@"Rad" forState:UIControlStateNormal];
		[self.radDisplay setHidden:YES];

		[self.brain toggleRadian:NO];

		self.radian = NO;
	}

	[self save];
}

// Shift pressed
// Toggle betweeen shift states.
- (IBAction)shiftPressed {
	if (self.shift) {
		[self shiftState:NO];
	} else {
		[self shiftState:YES];
	}

	[self save];
}

- (void)shiftState:(BOOL)shift {
	if (shift) {
		[self.shiftButton setHighlighted:YES];

		[self.sinButton setTitle:@"sin⁻¹" forState:UIControlStateNormal];
		[self.cosButton setTitle:@"cos⁻¹" forState:UIControlStateNormal];
		[self.tanButton setTitle:@"tan⁻¹" forState:UIControlStateNormal];

		[self.shiftButton setLayoutMargins:UIEdgeInsetsFromString(@"{3.0, 3.0, 3.0, 3.0}")];

		self.shift = YES;
	} else {
		[self.shiftButton setHighlighted:NO];

		[self.sinButton setTitle:@"sin" forState:UIControlStateNormal];
		[self.cosButton setTitle:@"cos" forState:UIControlStateNormal];
		[self.tanButton setTitle:@"tan" forState:UIControlStateNormal];

		self.shift = NO;
	}

	[self save];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

// Save
// Saves the current state.
- (void)save {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject:self.display.text forKey:@"display"];

	[defaults setBool:self.allCleared forKey:@"allCleared"];
	[defaults setBool:self.enteringNumber forKey:@"enteringNumber"];
	[defaults setBool:self.enteredDecimal forKey:@"enteredDecimal"];
	[defaults setBool:self.enteredNegative forKey:@"enteredNegative"];
	[defaults setBool:self.enteredOperation forKey:@"enteredOperation"];
	[defaults setBool:self.radian forKey:@"calculatorRadian"];
	[defaults setBool:self.shift forKey:@"shift"];

	[defaults synchronize];

	[self.brain save];
}

// Load
// Loads the previous state.
- (void)load {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	self.display.text = [defaults objectForKey:@"display"];
	if ([self.display.text length] == 0) self.display.text = @"0";

	self.allCleared = [defaults boolForKey:@"allCleared"];
	self.enteringNumber = [defaults boolForKey:@"enteringNumber"];
	self.enteredDecimal = [defaults boolForKey:@"enteredDecimal"];
	self.enteredNegative = [defaults boolForKey:@"enteredNegative"];
	self.enteredOperation = [defaults boolForKey:@"enteredOperation"];
	self.radian = [defaults boolForKey:@"calculatorRadian"];
	self.shift = [defaults boolForKey:@"shift"];

	if (self.allCleared) {
		[self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
	} else {
		[self.clearButton setTitle:@"C" forState:UIControlStateNormal];
	}

	[self radianState:self.radian];
	[self shiftState:self.shift];

	[self.brain load];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	CalculatorTapeViewController *tapeViewController = [segue destinationViewController];

	[self.navigationController setNavigationBarHidden:NO animated:YES];

	tapeViewController.tape = [self.brain readTape];
	tapeViewController.allCleared = self.allCleared;
}

// Returned
- (IBAction)returned:(UIStoryboardSegue *)segue {}

// Returned and clear
- (IBAction)returnedClear:(UIStoryboardSegue *)segue {
	[self clearPressed];
}

@end