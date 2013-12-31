//
//  DrawingFilter.m
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "DrawingFilter.h"

@implementation DrawingFilter {
	CIKernel *_kernel;
	CGSize _size;
}

#define KERNEL_FORMAT \
@"kernel vec4 drawRfGfBf(sampler src) {"\
@"    float pi = 3.14159265;"\
@"    vec2 coord = samplerCoord(src);"\
@"    vec2 size = samplerSize(src);"\
@"    float hw = size.x / 2.0;"\
@"    float hh = size.y / 2.0;"\
@"    float x = (coord.x / hw) - 1.0;"\
@"    float y = (coord.y / hh) - 1.0;"\
@"    float r = %@;"\
@"    float rt = (r + 1.0) / 2.0;"\
@"    float g = %@;"\
@"    float gt = (g + 1.0) / 2.0;"\
@"    float b = %@;"\
@"    float bt = (b + 1.0) / 2.0;"\
@"    return vec4(rt, gt, bt, 1.0);"\
@"}"

- (instancetype)initWithRedFunction:(MathFunction *)rf greenFunction:(MathFunction *)gf blueFunction:(MathFunction *)bf size:(CGSize)size {
	NSParameterAssert(rf);
	NSParameterAssert(gf);
	NSParameterAssert(bf);
	
	NSParameterAssert(!CGSizeEqualToSize(size, CGSizeZero));
	
	CIKernel *kernel = [CIKernel kernelsWithString:[NSString stringWithFormat:
													KERNEL_FORMAT, [rf stringRepresentation], [gf stringRepresentation], [bf stringRepresentation]]][0];
	
	if (!kernel) {
		return nil;
	}
	
	self = [super init];
	if (self) {
		_kernel = kernel;
		_size = size;
	}
	return self;
}

- (CIImage *)outputImage {
	CIImage *inputImage = [CIImage imageWithColor:[CIColor colorWithRed:0 green:0 blue:0]];
	inputImage = [inputImage imageByCroppingToRect:CGRectMake(0, 0, _size.width, _size.height)];
	
	CISampler *sampler = [CISampler samplerWithImage:inputImage];
	NSArray *outputExtent = @[ @(0), @(0), @([inputImage extent].size.width), @([inputImage extent].size.height) ];
	
	return [self apply:_kernel, sampler, kCIApplyOptionExtent, outputExtent, nil];
}

@end
