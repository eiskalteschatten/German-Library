//
//  NotepadDelegate.m
//  German Library
//
//  Created by Alex Seifert on 3/10/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotepadDelegate.h"

@implementation NotepadDelegate

- (void)textDidChange: (NSNotification *) notification {
	[_notePadWindow setDocumentEdited: YES];
}

@end
