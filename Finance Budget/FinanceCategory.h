//
//  FinanceCategory.h
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FinanceCategoryHolder.h"

@class Expense, Income;

NS_ASSUME_NONNULL_BEGIN

@interface FinanceCategory : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "FinanceCategory+CoreDataProperties.h"
