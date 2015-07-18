//
//  Tab.m
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "Tab.h"

@implementation Tab

- (NSString *)masterTitle {
	switch (self.tab) {
		case FBTabExpenses:
			return @"Expenses";
			break;

		case FBTabIncome:
			return @"Income";
			break;

		default:
			return @"";
			break;
	}
}

- (NSString *)detailTitle {
	switch (self.tab) {
		case FBTabExpenses:
			return @"Expense";
			break;

		case FBTabIncome:
			return @"Income";
			break;

		default:
			return @"";
			break;
	}
}

- (NSString *)addTitle {
	switch (self.tab) {
		case FBTabExpenses:
			return @"Add Expense";
			break;

		case FBTabIncome:
			return @"Add Income";
			break;

		default:
			return @"";
			break;
	}
}

- (NSString *)entityForName {
	switch (self.tab) {
		case FBTabExpenses:
			return @"Expense";
			break;

		case FBTabIncome:
			return @"Income";
			break;

		default:
			return @"";
			break;
	}
}

- (NSString *)predicate {
	switch (self.tab) {
		case FBTabExpenses:
			return @"expense";
			break;

		case FBTabIncome:
			return @"income";
			break;

		default:
			return @"";
			break;
	}
}

- (NSString *)cacheName {
	switch (self.tab) {
		case FBTabExpenses:
			return @"Expenses";
			break;

		case FBTabIncome:
			return @"Income";
			break;

		default:
			return @"";
			break;
	}
}

@end