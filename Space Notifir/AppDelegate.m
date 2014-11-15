//
//  AppDelegate.m
//  Space Notifir
//
//  Created by Serge Sander on 11.11.14.
//  Copyright (c) 2014 Serge Sander. All rights reserved.
//

#import "AppDelegate.h"
#import "TSLib.h"

@implementation AppDelegate
@synthesize NotifirWindow;
@synthesize IndexCircleView;

- (void) setupWindow{
    NSScreen *displa = [NSScreen mainScreen];
    int dW = displa.frame.size.width;
    int dH = displa.frame.size.height;
    NSRect fullScreen = NSMakeRect(0, 0, dW, dH);
    [NotifirWindow setFrame:fullScreen display:YES];
    
    NSRect boxframe = NSMakeRect(0, 0, dW, 100);
    [box setFrame:boxframe];
    
    NSRect index = NSMakeRect(0, 0, 500, 500);
   [SpaceIndex setFrameSize:NSMakeSize(500, 500)];
    
    
    [IndexCircleView setFrame:index];
    [SpaceIndex setFont:[NSFont systemFontOfSize:450]];

}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Window Settings
    [NotifirWindow setLevel:NSMainMenuWindowLevel + 2];
    [self setupWindow];
    [NotifirWindow orderOut:self];
    // Spaces Observer
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(switchedToRegularSpace:) name:NSWorkspaceActiveSpaceDidChangeNotification object:nil];
    [self showNotification:@"Running in Menu Bar now!"];
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [NSUserNotificationCenter.defaultUserNotificationCenter removeDeliveredNotification:notification];
    });
    
    // Init StatusBar Item
    myStatusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] self];
    
    NSImage *statusImage = [NSImage imageNamed:@"statusIcon"];
    [myStatusItem setImage:statusImage];
    [myStatusItem setHighlightMode:YES];
    myStatusItem.target = self;
    myStatusItem.action = @selector(mouseDown:);
    
    [myStatusItem setMenu:myStatusMenu];
    
    //[myStatusItem setTitle:NSLocalizedString(@"Special Status", @"status menu item text")];
    //Tells the NSStatusItem what menu to load
    [myStatusItem setMenu:statusMenu];
    //Sets the tooptip for our item
    [myStatusItem setToolTip:@"Space Change Notifir"];
    //Enables highlighting
    [myStatusItem setHighlightMode:YES];
}

- (void)showNotification:(NSString *)message {
    notification = [[NSUserNotification alloc] init];
    notification.title = @"Space Change Notifir";
    notification.informativeText = message;
    notification.soundName = nil;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (void)switchedToRegularSpace:(NSNotification *)n {
    //[self showNotification:@"On a regular space"];
    [self setupWindow];
    
    // Get Space Nr
    NSString *data = [self runAsCommand];
    [SpaceIndex setStringValue:data];
    if ( currentSpaceIndex == 0){
        currentSpaceIndex = [data intValue];
        [NotifirLabel setStringValue:@"Navigation Indicator"];
    } else if ([data intValue] < currentSpaceIndex){
        [NotifirLabel setStringValue:@"Backwards"];
        currentSpaceIndex -= 1;
    } else {
        [NotifirLabel setStringValue:@"Forwards"];
        currentSpaceIndex += 1;
    }
    
    
    NSString *spaceName = @"";
    const char *name = tsapi_spaceNameForSpaceNumberOnDisplay([data intValue], 0);
    if (name) {
        spaceName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        tsapi_freeString((char *)name);
    }
    [NotifirLabel setStringValue:spaceName];  // or put the name anywhere you wish
    
    
    
    // Show
    [self.NotifirWindow setAlphaValue:1];
    [self.NotifirWindow orderFront:self];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[NotifirWindow animator] setAlphaValue:0];
        [self.NotifirWindow orderOut:self];
    });
    [self animateIndex];
}
- (void) animateIndex{
    NSScreen *displa = [NSScreen mainScreen];
    int dW = (displa.frame.size.width - 500) / 2;
    int dH = (displa.frame.size.height - 500) / 2;
    
    NSRect oldSize = NSMakeRect(0, 0, 100, 100);
    NSRect index = NSMakeRect(dW, dH, 500, 500);
    NSRect index2 = NSMakeRect(0, 0, 500, 500);
    [SpaceIndex setFrame:index2];
    [IndexCircleView setFrame:index];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[SpaceIndex animator] setFrame:oldSize];
        [[IndexCircleView animator] setFrame:oldSize];
        [SpaceIndex setFont:[NSFont systemFontOfSize:90]];
    });
    
}
- (NSString*)runAsCommand {
    NSPipe* pipe = [NSPipe pipe];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *helperAppPath = [[mainBundle bundlePath]
                               stringByAppendingString:@"/Contents/Resources/currentSpace"];

    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath: helperAppPath];
    //task.arguments  = @[helperAppPath];
    [task setStandardOutput:pipe];
    
    NSFileHandle* file = [pipe fileHandleForReading];
    [task launch];
    
    return [[NSString alloc] initWithData:[file readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

- (IBAction)QuitApp:(id)sender {
    [[NSApplication sharedApplication] terminate:nil];
}

@end
