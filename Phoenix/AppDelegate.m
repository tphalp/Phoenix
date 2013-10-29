//
//  AppDelegate.m
//  Phoenix
//
//  Created by Steven on 10/15/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self loadStatusItem];
    self.config = [SDConfig freshConfig];
}

- (void) loadStatusItem {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setTitle:@"[P]"];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setMenu:self.menu];
}

@end
