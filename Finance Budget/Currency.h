//
//  Currency.h
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property NSString *code;

- (NSString *)currency;
- (NSString *)symbol;
- (NSNumberFormatter *)formatter;
- (NSNumberFormatter *)currencyFormatter;
- (NSNumberFormatter *)numberFormatter;

@end