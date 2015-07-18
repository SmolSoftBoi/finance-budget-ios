//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Kristian Matthews on 16/02/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushNumber:(double)number;
- (void)pushOperation:(NSString *)operation;
- (double)performOperation;
- (double)performScientificOperation:(NSString *)operation;
- (NSString *)readTape;
- (void)clear:(BOOL)all;
- (void)toggleRadian:(BOOL)radian;
- (void)save;
- (void)load;

@end