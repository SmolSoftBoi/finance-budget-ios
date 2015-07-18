//
//  IncomeHolder.m
//  Finance Budget
//
//  Created by Kristian Matthews on 02/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "IncomeHolder.h"

@implementation IncomeHolder

- (instancetype)init {
	self = [super init];

	self.categoryHolder = [[FinanceCategoryHolder alloc] init];
	self.repeatSpanHolder = [[RepeatSpanHolder alloc] init];

	return self;
}

@end