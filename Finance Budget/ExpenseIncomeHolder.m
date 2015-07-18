//
//  ExpenseIncomeHolder.m
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "ExpenseIncomeHolder.h"

@implementation ExpenseIncomeHolder

- (instancetype)init {
	self = [super init];

	self.categoryHolder = [[FinanceCategoryHolder alloc] init];
	self.repeatSpanHolder = [[RepeatSpanHolder alloc] init];

	return self;
}

@end