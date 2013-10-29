//
//  SDConfig.m
//  Phoenix
//
//  Created by Steven on 10/29/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import "SDConfig.h"

//#import <Silica/Silica.h>
//#import "SDWindow.h"

#import "Beowulf.h"
#import "BWCallable.h"
#import "SDHotKey.h"

@interface SDConfig ()

@property BWEnv* env;
@property NSMutableArray* hotkeys;

@end

@implementation SDConfig

+ (SDConfig*) freshConfig {
    NSString* configFile = @"/Users/sdegutis/Dropbox/Steven/config.bwlf";
    NSString* configFileContents = [[NSString alloc] initWithContentsOfFile:configFile
                                                           encoding:NSUTF8StringEncoding
                                                              error:NULL];
    
    SDConfig* config = [[SDConfig alloc] init];
    [config load:configFileContents];
    return config;
}

- (void) debug:(NSString*)str {
    NSLog(@"%@", str);
}

- (void) bind:(NSString*)key mods:(NSArray*)mods fn:(id<BWCallable>)callable {
    SDHotKey* hotkey = [[SDHotKey alloc] init];
    hotkey.modifiers = @[@"CMD", @"CTRL", @"ALT"];
    hotkey.key = @"d";
    hotkey.fn = ^{
        [callable call:@[] env:self.env];
    };
    [hotkey bind];
}

- (void) load:(NSString*)contents {
    NSURL* preludeURL = [[NSBundle mainBundle] URLForResource:@"prelude" withExtension:@"bwlf"];
    NSString* prelude = [[NSString alloc] initWithContentsOfURL:preludeURL
                                                       encoding:NSUTF8StringEncoding
                                                          error:NULL];
    
    self.hotkeys = [NSMutableArray array];
    
    self.env = [Beowulf basicEnv];
    [Beowulf eval:prelude env:self.env error:NULL];
    
    [self.env.names setObject:self forKey:@"*config*"];
    [Beowulf eval:contents env:self.env error:NULL];
}

@end
