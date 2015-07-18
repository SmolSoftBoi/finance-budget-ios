//
//  Brain.m
//  Calculator
//
//  Created by Kristian Matthews on 16/02/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *numberStack;
@property (nonatomic, strong) NSString *operation;
@property (nonatomic, strong) NSString *tape;

@property (nonatomic) NSUInteger offset;
@property (nonatomic) BOOL radian;

@end

@implementation CalculatorBrain

// Initialise the number stack, operation, and tape
@synthesize numberStack = _numberStack;
@synthesize operation = _operation;
@synthesize tape = _tape;

- (NSMutableArray *)numberStack {
    if ( ! _numberStack) _numberStack = [[NSMutableArray alloc] init];

    return _numberStack;
}

- (NSString *)operation {
    if ( ! _operation) _operation = [[NSString alloc] init];

    return _operation;
}

- (NSString *)tape {
    if ( ! _tape) _tape = [[NSString alloc] init];

    return _tape;
}

// Get number
// Gets a number from the end of the number stack.
- (double)getNumber:(NSUInteger)numberFromEnd {
    NSInteger index = (NSInteger)self.numberStack.count - (NSInteger)numberFromEnd;

    if (index < 0) index = 0;

    NSNumber *numberObject = [self.numberStack objectAtIndex:(NSUInteger)index];

    return [numberObject doubleValue];
}

// Push number
// Pushes a number to the end of the number stack.
- (void)pushNumber:(double)number {
    [self.numberStack addObject:[NSNumber numberWithDouble:number]];

    NSUInteger length = 0;

    if (self.numberStack.count >= 2) length = self.numberStack.count - 2;

    [self.numberStack removeObjectsInRange:NSMakeRange(0, length)];
    self.offset = 0;
}

// Push result
// Pushes the result to the end of the number stack.
- (void)pushResult:(double)number {
    [self.numberStack addObject:[NSNumber numberWithDouble:number]];
}

// Push operation
- (void)pushOperation:(NSString *)operation {
    self.operation = operation;
}

// Perform operation
- (double)performOperation {
    double result = [self getNumber:1];

    double x = 0;
    double y = 0;

    if (self.offset == 0) {
        x = [self getNumber:2];
    } else {
        x = [self getNumber:1];
    }
    y = [self getNumber:1 + self.offset];

    if ([@"÷" isEqualToString:self.operation]) {
        result = x / y;

        [self addTape:[NSString stringWithFormat:@"%g ÷ %g = %g", x, y, result]];
    } else if ([@"×" isEqualToString:self.operation]) {
        result = x * y;

        [self addTape:[NSString stringWithFormat:@"%g × %g = %g", x, y, result]];
    } else if ([@"−" isEqualToString:self.operation]) {
        result = x - y;

        [self addTape:[NSString stringWithFormat:@"%g − %g = %g", x, y, result]];

    } else if ([@"+" isEqualToString:self.operation]) {
        result = x + y;

        [self addTape:[NSString stringWithFormat:@"%g + %g = %g", x, y, result]];
    }

    [self pushResult:result];

    self.offset = self.offset + 1;

    return result;
}

// Perform scientific operation
- (double)performScientificOperation:(NSString *)operation {
    double result = [self getNumber:1];

    double x = 0;

    x = [self getNumber:1];

    if ([@"%" isEqualToString:operation]) {
        result = x / 100.0;

        [self addTape:[NSString stringWithFormat:@"%g%% = %g", x, result]];
    } else if ([@"1/x" isEqualToString:operation]) {
        result = pow(x, -1.0);

        [self addTape:[NSString stringWithFormat:@"1/%g = %g", x, result]];
    } else if ([@"²√x" isEqualToString:operation]) {
         result = pow(x, 1.0 / 2.0);

        [self addTape:[NSString stringWithFormat:@"²√%g = %g", x, result]];
    } else if ([@"x²" isEqualToString:operation]) {
        result = pow(x, 2.0);

        [self addTape:[NSString stringWithFormat:@"%g² = %g", x, result]];
    } else if ([@"ln" isEqualToString:operation]) {
        result = log(x);

        [self addTape:[NSString stringWithFormat:@"log %g = %g", x, result]];
    } else if ([@"log₁₀" isEqualToString:operation]) {
        result = log10(x);

        [self addTape:[NSString stringWithFormat:@"log₁₀ %g = %g", x, result]];
    } else if ([@"sin" isEqualToString:operation]) {
        if (self.radian) {
            result = sin(x);
        } else {
            result = sin(x * 3.14159265358979323846264338327950288 / 180);
        }

        [self addTape:[NSString stringWithFormat:@"sine %g = %g", x, result]];
    } else if ([@"sin⁻¹" isEqualToString:operation]) {
        if (self.radian) {
            result = asin(x);
        } else {
            result = asin(x) * 180 / 3.14159265358979323846264338327950288;
        }

        [self addTape:[NSString stringWithFormat:@"arcsine %g = %g", x, result]];
    } else if ([@"cos" isEqualToString:operation]) {
        if (self.radian) {
            result = cos(x);
        } else {
            result = cos(x * 3.14159265358979323846264338327950288 / 180);
        }
        
        [self addTape:[NSString stringWithFormat:@"cosine %g = %g", x, result]];
    } else if ([@"cos⁻¹" isEqualToString:operation]) {
        if (self.radian) {
            result = acos(x);
        } else {
            result = acos(x) * 180 / 3.14159265358979323846264338327950288;
        }
        
        [self addTape:[NSString stringWithFormat:@"arccosine %g = %g", x, result]];
    } else if ([@"tan" isEqualToString:operation]) {
        if (self.radian) {
            result = tan(x);
        } else {
            result = tan(x * 3.14159265358979323846264338327950288 / 180);
        }
        
        [self addTape:[NSString stringWithFormat:@"tangent %g = %g", x, result]];
    } else if ([@"tan⁻¹" isEqualToString:operation]) {
        if (self.radian) {
            result = atan(x);
        } else {
            result = atan(x) * 180 / 3.14159265358979323846264338327950288;
        }
        
        [self addTape:[NSString stringWithFormat:@"arctangent %g = %g", x, result]];
    }

    [self pushResult:result];

    self.offset = self.offset + 1;

    return result;
}

// Add tape
// Adds to the end of the tape.
- (void)addTape:(NSString *)tape {
    if ( ! [@"" isEqualToString:self.tape]) self.tape = [self.tape stringByAppendingString:@"\n"];

    self.tape = [self.tape stringByAppendingString:tape];
}

// Read tape
- (NSString *)readTape {
    return self.tape;
}

// Toggle radian
- (void)toggleRadian:(BOOL)radian {
    self.radian = radian;
}

// Clear
- (void)clear:(BOOL)all {
    if (all) {
        [self.numberStack removeAllObjects];

        self.operation = @"";

        self.tape = @"";
    } else {
        if ( ! [@"" isEqualToString:self.tape]) self.tape = [self.tape stringByAppendingString:@"\n"];
    }
}

// Save
// Saves the current state.
- (void)save {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:self.numberStack forKey:@"numberStack"];
    [defaults setObject:self.operation forKey:@"operation"];
    [defaults setObject:self.tape forKey:@"tape"];

    [defaults setInteger:self.offset forKey:@"offset"];
    [defaults setBool:self.radian forKey:@"brainRadian"];

    [defaults synchronize];
}

// Load
// Loads the previous state.
- (void)load {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.numberStack = [defaults objectForKey:@"numberStack"];
    self.operation = [defaults objectForKey:@"operation"];
    self.tape = [defaults objectForKey:@"tape"];

    self.offset = [defaults integerForKey:@"offset"];
    self.radian = [defaults boolForKey:@"brainRadian"];
}

@end