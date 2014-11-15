//
//  myWindow.m
//  Space Notifir
//
//  Created by Serge Sander on 11.11.14.
//  Copyright (c) 2014 Serge Sander. All rights reserved.
//

#import "myWindow.h"

@implementation myWindow
- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect
                            styleMask:aStyle
                              backing:bufferingType
                                defer:flag];
    if (self) {
        [self setStyleMask:NSNormalWindowLevel];
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:NO];
    }
    return self;
}


- (BOOL)canBecomeKeyWindow {
    return YES;
}

-(BOOL)canBecomeMainWindow {
    return YES;
}

@end
