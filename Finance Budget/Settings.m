//
//  Settings.m
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "Settings.h"

@interface Settings()

@end

@implementation Settings

- (BOOL)getSplash {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	if ([defaults boolForKey:FBSettingsSplashPreference] == YES || [defaults boolForKey:FBSettingsSplash] == NO) return NO;

	return [defaults boolForKey:FBSettingsSplash];
}

- (void)setSplash:(BOOL)splash {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setBool:splash forKey:FBSettingsSplash];

	if (splash == YES) {
		[defaults setBool:NO forKey:FBSettingsSplashPreference];
	} else {
		[defaults setBool:YES forKey:FBSettingsSplashPreference];
	}

	[defaults synchronize];
}

- (Currency *)getCurrency {
	Currency *currency = [Currency alloc];

	currency.code = self.getCurrencyCode;

	return currency;
}

- (NSString *)getCurrencyCode {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	NSString *currencyCode = [defaults stringForKey:FBSettingsCurrencyCode];

	if (currencyCode == nil) [self setCurrencyCode:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode]];

	return [defaults stringForKey:FBSettingsCurrencyCode];
}

- (void)setCurrencyCode:(NSString *)currencyCode {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject:currencyCode forKey:FBSettingsCurrencyCode];

	[defaults synchronize];
}

- (Sort *)getSort {
	Sort *sort = [Sort alloc];

	sort.sort = self.getSortKey;

	return sort;
}

- (FBSort)getSortKey {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	FBSort sort = [defaults stringForKey:FBSettingsSort];

	if (sort == nil) [self setSortKey:FBSortDate];

	return [defaults stringForKey:FBSettingsSort];
}

- (void)setSortKey:(FBSort)sort {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject:sort forKey:FBSettingsSort];

	[defaults synchronize];
}

- (NSString *)getTab {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	return [defaults stringForKey:FBSettingsTab];
}

- (void)setTab:(NSString *)tab {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject:tab forKey:FBSettingsTab];

	[defaults synchronize];
}

@end