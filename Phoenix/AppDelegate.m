//
//  AppDelegate.m
//  Phoenix
//
//  Created by Steven on 10/15/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import "AppDelegate.h"

#import <Silica/Silica.h>
#import "SDWindow.h"

#import "Beowulf.h"

#import "SDHotKey.h"

@interface AppDelegate ()

@property SDHotKey* hotkey;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSURL* preludeURL = [[NSBundle mainBundle] URLForResource:@"prelude" withExtension:@"bwlf"];
    NSString* prelude = [[NSString alloc] initWithContentsOfURL:preludeURL
                                                       encoding:NSUTF8StringEncoding
                                                          error:NULL];
    
    BWEnv* env = [Beowulf basicEnv];
    [Beowulf eval:prelude env:env error:NULL];
    
    self.hotkey = [[SDHotKey alloc] init];
    self.hotkey.modifiers = @[@"CMD", @"CTRL", @"ALT"];
    self.hotkey.key = @"d";
    self.hotkey.fn = ^{
//        NSLog(@"boo");
//        [self.hotkey unbind];
    };
    [self.hotkey bind];
    
//    NSLog(@"%@", [Beowulf eval:@"(+ 1 2)" env:env error:NULL]);
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"%@", @"getting first");
        NSLog(@"%@", [SIWindow allWindows]);
    });
    
    // Insert code here to initialize your application
}

@end
