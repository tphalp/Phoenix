//
//  AppDelegate.h
//  Phoenix
//
//  Created by Steven on 10/15/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDConfig.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property SDConfig *config;

@property IBOutlet NSMenu* menu;
@property NSStatusItem* statusItem;

@end
