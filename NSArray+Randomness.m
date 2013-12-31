//
//  NSArray+Randomness.m
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "NSArray+Randomness.h"

@implementation NSArray (Randomness)

- (id)randomObject {
	if ([self count] == 0)
		return nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		srand((unsigned int)time(NULL));
	});
	
	int index = rand() % [self count];
	
	return [self objectAtIndex:index];
}

@end
