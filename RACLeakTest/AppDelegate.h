//
//  AppDelegate.h
//  RACLeakTest
//
//  Created by Sam on 4/7/14.
//  Copyright (c) 2014 Sam Goldman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)runNoLeak:(NSButton *)button;
- (IBAction)runLeak:(NSButton *)button;

@end
