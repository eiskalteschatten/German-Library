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
    _window.titleVisibility = NSWindowTitleHidden;
    
    _clickedSegment = 0;
    [_tabView selectTabViewItemAtIndex:_clickedSegment];
    
    [[_leoView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dict.leo.org"]]];
    [[_dictView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.dict.cc"]]];
    [[_canooView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.canoo.net"]]];
    [[_dudenView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.duden.de"]]];
    [[_ponsView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.pons.com"]]];
    
    refNames = [[NSMutableArray alloc] init];
    [refNames addObjectsFromArray:[NSArray arrayWithObjects:@"LEO",@"dict.cc",@"CanooNet",@"Duden",@"PONS", nil]];
    
    searchUrls = [[NSMutableArray alloc] init];
    [searchUrls addObjectsFromArray:[NSArray arrayWithObjects:@"https://dict.leo.org/#/search=",@"https://www.dict.cc/?s=",@"https://canoo.net/services/Controller?MenuId=Search&service=canooNet&lang=de&input=",@"https://www.duden.de/suchen/dudenonline/",@"https://en.pons.com/translate?l=deen&in=&lf=de&q=", nil]];
    
    webViews = [[NSMutableArray alloc] init];
    [webViews addObjectsFromArray:[NSArray arrayWithObjects:_leoView, _dictView, _canooView, _dudenView, _ponsView, nil]];
    
    NSString *path = [self pathToNotes];
    [_notePad readRTFDFromFile:path];
    
    [_searchField setRecentsAutosaveName:@"recentsearches"];
    [self buildSearchMenu];
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
    NSString *query = [sender stringValue];
    [self searchWithString:query];
}

- (IBAction)searchFromMenu:(id)sender {
    NSString *query = [sender title];
    
    [_searchField setStringValue:query];
    
    [self searchWithString:query];
}

- (void)searchWithString:(NSString*)query {
    if (![query isEqual: @""]) {
        query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        WebView *openWebView = [webViews objectAtIndex:_clickedSegment];
        NSString *searchUrl = [searchUrls objectAtIndex:_clickedSegment];
        searchUrl = [searchUrl stringByAppendingString:query];
        
        [[openWebView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchUrl]]];
        
        [self buildSearchMenu];
        [_searchField becomeFirstResponder];
    }
}

- (void)buildSearchMenu {
    NSArray *searches = [_searchField recentSearches];
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Recent searches"];
    
    [menu addItemWithTitle:@"Recent searches" action:nil keyEquivalent:@""];
    
    for (NSString* key in searches) {       
        [menu addItemWithTitle:key action:@selector(searchFromMenu:) keyEquivalent:@""];
    }
    
    [menu insertItem:[NSMenuItem separatorItem] atIndex:[menu numberOfItems]];
    [menu addItemWithTitle:@"Clear recent searches" action:@selector(clearSearchMenu:) keyEquivalent:@""];
    
    [[_searchField cell] setSearchMenuTemplate:menu];
}

- (IBAction)clearSearchMenu:(id)sender {
    NSMutableArray *clear = [NSMutableArray arrayWithCapacity:1];
    [_searchField setRecentSearches:clear];
    [self buildSearchMenu];
}

- (IBAction)focusSearch:(id)sender {
    [_searchField becomeFirstResponder];
}

- (NSString*)pathToOptions {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = @"~/Library/Application Support/Germany Library/Options/";
    folder2 = [folder2 stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder2] == NO) {
        [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
    }
    
    folder2 = [folder2 stringByAppendingPathComponent:@"Notepad.rtfd"];
    
    return folder2;
}

- (NSString*)pathToNotes {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = @"~/Library/Application Support/Germany Library/Notes/";
    folder2 = [folder2 stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder2] == NO) {
        [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
    }
    
    folder2 = [folder2 stringByAppendingPathComponent:@"Notepad.rtfd"];
    
    return folder2;
}

@end
