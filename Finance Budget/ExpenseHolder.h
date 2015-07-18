//
//  ExpenseHolder.h
//  Finance Budget
//
//  Created by Kristian Matthews on 02/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinanceCategory.h"
#import "RepeatSpan.h"

@class FinanceCategory, FinanceCategoryHolder, RepeatSpan, RepeatSpanHolder;

@interface ExpenseHolder : NSObject

@property (nullable, nonatomic, strong) NSDecimalNumber *amount;
@property (nullable, nonatomic, strong) NSNumber *repeatInterval;
@property (nullable, nonatomic, strong) NSDate *timestamp;
@property (nullable, nonatomic, strong) NSString *transaction;
@property (nullable, nonatomic, strong) FinanceCategory *category;
@property (nullable, nonatomic, strong) RepeatSpan *repeatSpan;
@property (nullable, nonatomic, strong) FinanceCategoryHolder *categoryHolder;
@property (nullable, nonatomic, strong) RepeatSpanHolder *repeatSpanHolder;

@end