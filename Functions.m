//
//  Functions.m
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "Functions.h"

#import "NSArray+Randomness.h"
#import <objc/runtime.h>

#define ARC4RANDOM_MAX 0x100000000


static double _RandomDouble() {
	return ((double)arc4random() / ARC4RANDOM_MAX);
}


NSArray *MathFunctionsWithArguments() {
	static dispatch_once_t onceToken;
	static NSArray *gFunctions;
	
	dispatch_once(&onceToken, ^{
		gFunctions = @[ [MathFunctionSinPi class], [MathFunctionCosPi class],
						[MathFunctionTimes class], [MathFunctionAvg class],
						[MathFunctionAbs class] ];
	});
	
	return gFunctions;
}


NSArray *MathFunctionsWithoutArguments() {
	static dispatch_once_t onceToken;
	static NSArray *gFunctions;
	
	dispatch_once(&onceToken, ^{
		gFunctions = @[ [MathFunctionX class], [MathFunctionY class] ];
	});
	
	return gFunctions;
}


MathFunction *_GenerateRandomFunction(CGFloat p) {
	if (_RandomDouble() < p) {
		MathFunction *f = [[MathFunctionsWithArguments() randomObject] new];
		
		unsigned int methodsCount = 0;
		Method *methods = class_copyMethodList([f class], &methodsCount);
		
		for (unsigned int m = 0; m < methodsCount; m++) {
			SEL name = method_getName(methods[m]);
			
			if ([NSStringFromSelector(name) hasPrefix:@"setArgument"]) {
				MathFunction *rf = _GenerateRandomFunction(p * p);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
				[f performSelector:name withObject:rf];
#pragma clang diagnostic pop
			}
		}
		
		free(methods);
		
		return f;
	}
	else {
		return [[MathFunctionsWithoutArguments() randomObject] new];
	}
}

MathFunction *GenerateRandomFunction() {
	return _GenerateRandomFunction(0.99);
}


@implementation MathFunction

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	NSAssert(0, @"to be implemented by subclasses");
	return 0;
}

- (NSString *)stringRepresentation {
	NSAssert(0, @"to be implemented by subclasses");
	return nil;
}

@end


@implementation MathFunctionX

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return x;
}

- (NSString *)stringRepresentation {
	return @"x";
}

@end


@implementation MathFunctionY

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return y;
}

- (NSString *)stringRepresentation {
	return @"y";
}

@end


@implementation MathFunctionSinPi

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return sin(M_PI * [self.argument evaluateWithX:x y:y]);
}

- (NSString *)stringRepresentation {
	return [NSString stringWithFormat:@"sin(pi * %@)", [self.argument stringRepresentation]];
}

@end


@implementation MathFunctionCosPi

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return cos(M_PI * [self.argument evaluateWithX:x y:y]);
}

- (NSString *)stringRepresentation {
	return [NSString stringWithFormat:@"cos(pi * %@)", [self.argument stringRepresentation]];
}

@end


@implementation MathFunctionTimes

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return [self.argument1 evaluateWithX:x y:y] * [self.argument2 evaluateWithX:x y:y];
}

- (NSString *)stringRepresentation {
	return [NSString stringWithFormat:@"%@ * %@", [self.argument1 stringRepresentation], [self.argument2 stringRepresentation]];
}

@end


@implementation MathFunctionAvg

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return ([self.argument1 evaluateWithX:x y:y] + [self.argument2 evaluateWithX:x y:y]) / 2.0;
}

- (NSString *)stringRepresentation {
	return [NSString stringWithFormat:@"(%@ + %@) / 2.0", [self.argument1 stringRepresentation], [self.argument2 stringRepresentation]];
}

@end


@implementation MathFunctionAbs

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y {
	return fabs([self.argument evaluateWithX:x y:y]);
}

- (NSString *)stringRepresentation {
	return [NSString stringWithFormat:@"abs(%@)", [self.argument stringRepresentation]];
}

@end
