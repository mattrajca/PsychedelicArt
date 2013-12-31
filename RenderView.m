//
//  RenderView.m
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "RenderView.h"

#import <QuartzCore/QuartzCore.h>

#import "DrawingFilter.h"

@implementation RenderView

- (void)setImage:(CIImage *)image {
	if (_image != image) {
		_image = image;
		
		[self setNeedsDisplay:YES];
	}
}

- (void)drawRect:(NSRect)dirtyRect {
	if (!_image)
		return;
	
	CIContext *ctx = [[NSGraphicsContext currentContext] CIContext];
	[ctx drawImage:self.image inRect:[self bounds] fromRect:[_image extent]];
}

@end
