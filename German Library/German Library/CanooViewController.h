//
//  CanooViewController.h
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface CanooViewController : NSViewController

@property (assign) IBOutlet NSSegmentedControl *backForward;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;

@end
