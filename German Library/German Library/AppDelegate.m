//
//  AppDelegate.m
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_tabView selectTabViewItemAtIndex:0];
    
    [[_leoView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dict.leo.org"]]];
    [[_dictView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dict.cc"]]];
    [[_canooView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.canoo.net"]]];
    [[_dudenView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.duden.de"]]];
}

- (IBAction)switchTab:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    
    [_tabView selectTabViewItemAtIndex:clickedSegment];
}

- (void)webView:(WebView *)sender didStartProvisonalLoadForFrame:(WebFrame *)frame {
    NSLog(@"started loading");
    [_progressIndicator startAnimation: self];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    NSLog(@"finished loading");
    [_progressIndicator stopAnimation: self];
}

@end
