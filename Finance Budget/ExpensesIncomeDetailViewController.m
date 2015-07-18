//
//  ExpensesIncomeDetailViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 14/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import "ExpensesIncomeDetailViewController.h"

@interface ExpensesIncomeDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *categoryCell;
@property (weak, nonatomic) IBOutlet UITextField *amountCellTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionCellTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateCellLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerCellDatePicker;

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ExpensesIncomeDetailViewController

#pragma mark - Managing the Detail Item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
		self.title = [[self.detailItem valueForKey:@"transaction"] description];

		self.categoryCell.detailTextLabel.text = [[[self.detailItem valueForKey:@"category"] valueForKey:@"category"] description];
		self.amountCellTextField.text = [[self.detailItem valueForKey:@"amount"] description];
		self.descriptionCellTextField.text = [[self.detailItem valueForKey:@"transaction"] description];
		self.dateCellLabel.text = [NSString stringWithFormat:@"%@", [self.detailItem valueForKey:@"timestamp"]];

		self.datePickerCellDatePicker.date = [self.detailItem valueForKey:@"timestamp"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];

	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];

	self.dateFormatter = [[NSDateFormatter alloc] init];

	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterLongStyle;

	self.amountCellTextField.placeholder = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:[NSNumber numberWithInt:0]]];

	[self datePickerCellDatePickerEditingChanged:self.datePickerCellDatePicker];

	if (self.settings.getCurrency.formatter.maximumFractionDigits == 0) {
		self.amountCellTextField.keyboardType = UIKeyboardTypeNumberPad;
	} else {
		self.amountCellTextField.keyboardType = UIKeyboardTypeDecimalPad;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)datePickerCellDatePickerEditingChanged:(UIDatePicker *)sender {
	self.dateCellLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:sender.date]];
}

@end
