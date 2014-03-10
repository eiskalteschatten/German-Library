//
//  NotepadViewController.h
//  German Library
//
//  Created by Alex Seifert on 3/10/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NotepadViewController : NSViewController

@property (assign) IBOutlet NSWindow *notePadWindow;
@property (assign) IBOutlet NSTextView *notePad;

- (void)saveNotepad;
- (NSString*)pathToNotes;

@end
