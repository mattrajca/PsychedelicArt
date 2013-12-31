//
//  AppDelegate.h
//  PsychedelicArt
//
//  Created by Matt on 12/30/13.
//  Copyright (c) 2013 Matt Rajca. All rights reserved.
//

#import "RenderView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, assign) IBOutlet NSWindow *window;

@property (nonatomic, weak) IBOutlet NSMatrix *optionsMatrix;
@property (nonatomic, weak) IBOutlet RenderView *renderView;

@end
