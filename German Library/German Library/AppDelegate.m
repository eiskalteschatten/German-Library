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
    _clickedSegment = 0;
    [_tabView selectTabViewItemAtIndex:0];
    
    [[_leoView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dict.leo.org"]]];
    [[_dictView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dict.cc"]]];
    [[_canooView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.canoo.net"]]];
    [[_dudenView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.duden.de"]]];
    
    _webViews = [[NSMutableArray alloc] init];
    [_webViews addObjectsFromArray:[NSArray arrayWithObjects:_leoView, _dictView, _canooView, _dudenView, nil]];
}

- (IBAction)switchTab:(id)sender {
    _clickedSegment = [sender selectedSegment];
    
    [_tabView selectTabViewItemAtIndex:_clickedSegment];
    
    WebView *openWebView = [_webViews objectAtIndex:_clickedSegment];
    
    if ([openWebView canGoBack]) {
        [_backForward setEnabled:true forSegment:0];
    }
    else {
        [_backForward setEnabled:false forSegment:0];
    }
    
    if ([openWebView canGoForward]) {
        [_backForward setEnabled:true forSegment:1];
    }
    else {
        [_backForward setEnabled:false forSegment:1];
    }
}

- (IBAction)goBackForward:(id)sender {
    NSInteger clicked = [sender selectedSegment];
    WebView *openWebView = [_webViews objectAtIndex:_clickedSegment];
    
    if (clicked == 0) {
        [openWebView goBack];
    }
    else {
        [openWebView goForward];
    }
}

@end