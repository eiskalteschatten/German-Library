//
//  NotepadViewController.m
//  German Library
//
//  Created by Alex Seifert on 3/10/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NotepadViewController.h"

@interface NotepadViewController ()

@end

@implementation NotepadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)saveNotepad {
    NSString *path = [self pathToNotes];
	
    [_notePad writeRTFDToFile:path atomically:NO];
    
	[_notePadWindow setDocumentEdited: NO];
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

- (void)windowWillClose:(NSNotification *)notification {
    [self saveNotepad];
}

- (void)windowDidResignKey:(NSNotification *)notification {
    [self saveNotepad];
}

@end
