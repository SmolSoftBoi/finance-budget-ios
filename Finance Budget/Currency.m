//
//  Currency.m
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "Currency.h"

@implementation Currency

- (NSString *)currency {
	return [self.currentLocale displayNameForKey:NSLocaleCurrencyCode value:self.code];
}

- (NSString *)symbol {
	return [self.locale objectForKey:NSLocaleCurrencySymbol];
}

- (NSNumberFormatter *)formatter {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];

	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.currencyCode = self.code;

	return formatter;
}

- (NSNumberFormatter *)currencyFormatter {
	return self.formatter;
}

- (NSNumberFormatter *)numberFormatter {
	NSNumberFormatter *formatter = self.formatter;

	formatter.currencySymbol = @"";

	return formatter;
}

- (NSLocale *)locale {
	return [[NSLocale alloc] initWithLocaleIdentifier:[NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObject:self.code forKey:NSLocaleCurrencyCode]]];
}

- (NSLocale *)currentLocale {
	return [[NSLocale alloc] initWithLocaleIdentifier:[NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObjectsAndKeys:self.code, NSLocaleCurrencyCode, [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode], NSLocaleCountryCode, [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode], NSLocaleLanguageCode, nil]]];
}

@end