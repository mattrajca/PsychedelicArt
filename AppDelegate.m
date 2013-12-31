//
//  AppDelegate.m
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "AppDelegate.h"

#import "DrawingFilter.h"
#import "Functions.h"

@implementation AppDelegate

#define W 500

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	srand((unsigned int)time(NULL));
}

- (void)awakeFromNib {
	[self render:nil];
}

- (CIImage *)generateOutput {
	if ([self.optionsMatrix selectedRow] == 1) { /* random */
		MathFunction *rf = GenerateRandomFunction();
		MathFunction *gf = GenerateRandomFunction();
		MathFunction *bf = GenerateRandomFunction();
		
		DrawingFilter *dw = [[DrawingFilter alloc] initWithRedFunction:rf greenFunction:gf blueFunction:bf size:CGSizeMake(W, W)];
		return [dw outputImage];
	}
	else {
		MathFunctionSinPi *rf = [MathFunctionSinPi new];
		rf.argument = [MathFunctionX new];
		
		MathFunctionCosPi *gf = [MathFunctionCosPi new];
		MathFunctionTimes *times = [MathFunctionTimes new];
		times.argument1 = [MathFunctionX new];
		times.argument2 = [MathFunctionY new];
		gf.argument = times;
		
		MathFunctionSinPi *bf = [MathFunctionSinPi new];
		bf.argument = [MathFunctionY new];
		
		DrawingFilter *dw = [[DrawingFilter alloc] initWithRedFunction:rf greenFunction:gf blueFunction:bf size:CGSizeMake(W, W)];
		return [dw outputImage];
	}
}

- (IBAction)render:(id)sender {
	self.renderView.image = [self generateOutput];
}

- (IBAction)save:(id)sender {
	NSSavePanel *sp = [NSSavePanel savePanel];
	[sp setAllowedFileTypes:@[ (__bridge NSThread *)kUTTypePNG ]];
	[sp beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
		
		if (result != NSFileHandlingPanelOKButton)
			return;
		
		CIImage *image = [self generateOutput];
		
		NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithCIImage:image];
		NSData *data = [rep representationUsingType:NSPNGFileType properties:nil];
		
		[data writeToURL:[sp URL] atomically:YES];
		
	}];
}

@end
