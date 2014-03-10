//
//  AppDelegate.m
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize webViews;
@synthesize refNames;
@synthesize searchUrls;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _clickedSegment = 0;
    [_tabView selectTabViewItemAtIndex:0];
    
    [[_leoView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dict.leo.org"]]];
    [[_dictView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dict.cc"]]];
    [[_canooView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.canoo.net"]]];
    [[_dudenView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.duden.de"]]];
    
    refNames = [[NSMutableArray alloc] init];
    [refNames addObjectsFromArray:[NSArray arrayWithObjects:@"LEO",@"dict.cc",@"canoonet",@"Duden", nil]];
    
    searchUrls = [[NSMutableArray alloc] init];
    [searchUrls addObjectsFromArray:[NSArray arrayWithObjects:@"http://dict.leo.org/#/search=",@"http://www.dict.cc/?s=",@"http://canoo.net/services/Controller?MenuId=Search&service=canooNet&lang=de&input=",@"http://www.duden.de/suchen/dudenonline/", nil]];
    
    webViews = [[NSMutableArray alloc] init];
    [webViews addObjectsFromArray:[NSArray arrayWithObjects:_leoView, _dictView, _canooView, _dudenView, nil]];
}

- (IBAction)switchTab:(id)sender {
    _clickedSegment = [sender selectedSegment];
    
    [_tabView selectTabViewItemAtIndex:_clickedSegment];
    
    WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
    
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
    
    NSString *searchPlaceholder = @"Search ";
    searchPlaceholder = [searchPlaceholder stringByAppendingString:[refNames objectAtIndex:_clickedSegment]];
    [[_searchField cell] setPlaceholderString:searchPlaceholder];
}

- (IBAction)goBackForward:(id)sender {
    NSInteger clicked = [sender selectedSegment];
    WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
    
    if (clicked == 0) {
        [openWebView goBack];
    }
    else {
        [openWebView goForward];
    }
}

- (IBAction)stopPage:(id)sender {
    WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
    
	[[openWebView mainFrame] stopLoading];
    [_progressIndicator stopAnimation: self];
}

- (IBAction)reloadPage:(id)sender {
    WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
    
    [[openWebView mainFrame] reload];
}

- (IBAction)search:(id)sender {
    NSString *search = [_searchField stringValue];
    
    if (![search  isEqual: @""]) {
        WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
        NSString *searchUrl = [searchUrls objectAtIndex:_clickedSegment];
        searchUrl = [searchUrl stringByAppendingString:search];
        
        [[openWebView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchUrl]]];
    }
}

@end