//
//  DrawingFilter.h
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Functions.h"

@interface DrawingFilter : CIFilter

- (instancetype)initWithRedFunction:(MathFunction *)rf
					  greenFunction:(MathFunction *)gf
					   blueFunction:(MathFunction *)bf
							   size:(CGSize)size;

- (CIImage *)outputImage;

@end
