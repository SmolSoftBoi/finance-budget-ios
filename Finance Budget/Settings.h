//
//  Settings.h
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FB.h"
#import "Currency.h"
#import "Sort.h"

@interface Settings : NSObject

- (BOOL)getSplash;
- (void)setSplash:(BOOL)splash;
- (Currency *)getCurrency;
- (NSString *)getCurrencyCode;
- (void)setCurrencyCode:(NSString *)code;
- (Sort *)getSort;
- (FBSort)getSortKey;
- (void)setSortKey:(FBSort)sort;
- (NSString *)getTab;
- (void)setTab:(NSString *)tab;

@end