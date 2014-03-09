//
//  LeoViewController.m
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "LeoViewController.h"

@interface LeoViewController ()

@end

@implementation LeoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
    [_progressIndicator startAnimation: self];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    [_progressIndicator stopAnimation: self];
    
    if ([sender canGoBack]) {
        [_backForward setEnabled:true forSegment:0];
    }
    else {
        [_backForward setEnabled:false forSegment:0];
    }
    
    if ([sender canGoForward]) {
        [_backForward setEnabled:true forSegment:1];
    }
    else {
        [_backForward setEnabled:false forSegment:1];
    }
}

@end
