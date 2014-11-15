//
//  IndexCircleSub.m
//  SpaceNotifir
//
//  Created by Serge Sander on 13.11.14.
//  Copyright (c) 2014 Serge Sander. All rights reserved.
//

#import "IndexCircleSub.h"

@implementation IndexCircleSub

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // add a background color
    NSBezierPath * path;
    path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:250 yRadius:250];
    [[NSColor colorWithCalibratedRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.3] set];
    [path fill];
    
    // Draw Border
    [[NSColor colorWithCalibratedRed:256/255.0 green:256/255.0 blue:
      256/255.0 alpha:1.0] setStroke];
    [path setLineWidth:5];
    [path stroke];
    
    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowColor:[NSColor blackColor]];
    [dropShadow setShadowOffset:NSMakeSize(0, 0)];
    [dropShadow setShadowBlurRadius:5.0];
    
    [self setWantsLayer: YES];
    [self setShadow: dropShadow];
}


@end
