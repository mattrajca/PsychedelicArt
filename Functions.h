//
//  Functions.h
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MathFunction;

NSArray *MathFunctionsWithArguments();
NSArray *MathFunctionsWithoutArguments();

MathFunction *GenerateRandomFunction();


@interface MathFunction : NSObject

- (CGFloat)evaluateWithX:(CGFloat)x y:(CGFloat)y;

- (NSString *)stringRepresentation;

@end


@interface MathFunctionX : MathFunction

@end


@interface MathFunctionY : MathFunction

@end


@interface MathFunctionSinPi : MathFunction

@property (nonatomic, strong) MathFunction *argument;

@end


@interface MathFunctionCosPi : MathFunction

@property (nonatomic, strong) MathFunction *argument;

@end


@interface MathFunctionTimes : MathFunction

@property (nonatomic, strong) MathFunction *argument1;
@property (nonatomic, strong) MathFunction *argument2;

@end


@interface MathFunctionAvg : MathFunction

@property (nonatomic, strong) MathFunction *argument1;
@property (nonatomic, strong) MathFunction *argument2;

@end


@interface MathFunctionAbs : MathFunction

@property (nonatomic, strong) MathFunction *argument;

@end
