//
//  AppDelegate.h
//  Space Notifir
//
//  Created by Serge Sander on 11.11.14.
//  Copyright (c) 2014 Serge Sander. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "myWindow.h"
#import <Foundation/Foundation.h>
#import "IndexCircleSub.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    __weak IBOutlet NSTextField *SpaceIndex;
    IBOutlet NSTextField *NotifirLabel;
    IBOutlet NSBox *box;
    int currentSpaceIndex;
    NSUserNotification *notification;
    
    //Status Menu Inits
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *myStatusItem;
    IBOutlet NSMenu *myStatusMenu;
    
}
@property (assign) IBOutlet myWindow *NotifirWindow;
@property (strong) IBOutlet IndexCircleSub *IndexCircleView;

- (NSString*)runAsCommand;
- (IBAction)QuitApp:(id)sender;

@end
