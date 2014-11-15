//
//  boxSub.m
//  SpaceNotifir
//
//  Created by Serge Sander on 14.11.14.
//  Copyright (c) 2014 Serge Sander. All rights reserved.
//

#import "boxSub.h"

@implementation boxSub

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // add a background color
    NSBezierPath * path;
    path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:10 yRadius:10];
    [[NSColor colorWithCalibratedRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.5] set];
    [path fill];
    
    // Draw Border
    [[NSColor colorWithCalibratedRed:0/255.0 green:0/255.0 blue:
      0/255.0 alpha:1.0] setStroke];
    [path setLineWidth:20];
    [path stroke];

}

@end
