//
//  DraggableImageView.h
//  VGTagger
//
//  Created by Bilal Syed Hussain on 09/08/2011.
//  Copyright 2011  All rights reserved.
//

#import <AppKit/AppKit.h>

/// NSImageView where the image can be dragged to any 
/// other image source as a file
@interface BHDraggableImageView : NSImageView {
@private
	NSEvent* __strong downEvent;
}

@property (strong) NSEvent* downEvent;

@property (strong, nonatomic) NSString *fileName; // The name of the file that's written. Defaults to "Filename".

@property BOOL writeDraggedImageAsFile; // Whether the image should be written to a file (able to be dragged to Finder). Defaults to NO.
@property NSBitmapImageFileType writeImageFileType; // File type of image written to file. Defaults to NSTIFFFileType.

@property (strong, nonatomic) NSString *imageCachePath; // Directory path to which drag images should be temporarily written. Defaults to "/tmp".

@end
