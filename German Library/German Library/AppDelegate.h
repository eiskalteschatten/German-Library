//
//  AppDelegate.h
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTabView *tabView;

@property (assign) IBOutlet NSSegmentedControl *tabButtons;
@property (assign) IBOutlet NSSegmentedControl *backForward;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) IBOutlet NSSearchField *searchField;

@property (assign) IBOutlet WebView *leoView;
@property (assign) IBOutlet WebView *dictView;
@property (assign) IBOutlet WebView *canooView;
@property (assign) IBOutlet WebView *dudenView;

@property (assign) NSInteger clickedSegment;
@property (nonatomic,retain) NSMutableArray *refNames;
@property (nonatomic,retain) NSMutableArray *searchUrls;
@property (nonatomic,retain) NSMutableArray *webViews;

- (IBAction)switchTab:(id)sender;
- (IBAction)goBackForward:(id)sender;
- (IBAction)stopPage:(id)sender;
- (IBAction)reloadPage:(id)sender;
- (IBAction)search:(id)sender;

@end
