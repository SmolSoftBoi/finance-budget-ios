//
//  Income+CoreDataProperties.h
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Income.h"

NS_ASSUME_NONNULL_BEGIN

@interface Income (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *repeatInterval;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSString *transaction;
@property (nullable, nonatomic, retain) FinanceCategory *category;
@property (nullable, nonatomic, retain) RepeatSpan *repeatSpan;

@end

NS_ASSUME_NONNULL_END
