//
//  FinanceCategoryHolder.h
//  Finance Budget
//
//  Created by Kristian Matthews on 02/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinanceCategoryHolder : NSObject

@property (nullable, nonatomic, strong) NSString *category;
@property (nullable, nonatomic, strong) NSNumber *expense;
@property (nullable, nonatomic, strong) NSNumber *income;

@end