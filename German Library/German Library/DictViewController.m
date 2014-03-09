//
//  DictViewController.m
//  German Library
//
//  Created by Alex Seifert on 3/9/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "DictViewController.h"

@interface DictViewController ()

@end

@implementation DictViewController

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
}

@end
