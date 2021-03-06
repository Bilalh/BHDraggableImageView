//
//  DraggableImageView.m
//  VGTagger
//
//  Created by Bilal Syed Hussain on 09/08/2011.
//  Copyright 2011  All rights reserved.
//

#import "BHDraggableImageView.h"

@interface BHDraggableImageView()
- (void)startDrag:(NSEvent *)event
		 filename:(NSString*)filename;
@end

@implementation BHDraggableImageView
@synthesize downEvent;

- (void)startDrag:(NSEvent *)event
		 filename:(NSString*)filename
{
	NSPasteboard *pboard = [NSPasteboard pasteboardWithName:NSDragPboard];
	// Write the image data to clipboard
	[pboard declareTypes:[NSArray arrayWithObject:NSFilenamesPboardType]
				   owner:self];
	[pboard setData:[[self image] TIFFRepresentation] 
			forType:NSTIFFPboardType];
	
	// IF true write the data as a file as well which allows dragging the file e.g. to the desktop
	if (self.writeDraggedImageAsFile){
		NSString *tempFileName = [self.imageCachePath stringByAppendingFormat:@"/%@.%@", filename, [self extensionForType:self.writeImageFileType]];
		NSBitmapImageRep *bits = [[[self image] representations] objectAtIndex:0];
		NSData *data = [bits representationUsingType:self.writeImageFileType
										  properties:nil];
		[data writeToFile:tempFileName
			   atomically:NO];
		
		[pboard addTypes:[NSArray arrayWithObject:NSFilenamesPboardType] owner:self];
		[pboard setPropertyList:[NSArray arrayWithObject:tempFileName] 
						forType:NSFilenamesPboardType];
	}
	
	NSImage *scaledImage = [[self cell] objectValue];
	NSImage *dragImage = [[NSImage alloc] initWithSize:[scaledImage size]];
    [dragImage lockFocus];
    [[[self cell] objectValue] dissolveToPoint:NSMakePoint(0,0)
									  fraction:.5];
    [dragImage unlockFocus];
	
	NSPoint dragPoint = NSMakePoint(
									([self bounds].size.width - [scaledImage size].width) / 2,
									([self bounds].size.height - [scaledImage size].height) / 2);
	
    [self dragImage:dragImage
                 at:dragPoint
             offset:NSZeroSize
              event:event
         pasteboard:pboard
             source:self
          slideBack:YES];
}

- (BOOL)shouldDelayWindowOrderingForEvent:(NSEvent *)event
{
    return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
    return YES;
}

- (void)mouseDown:(NSEvent *)event
{
	self.downEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
    if ([self image]) {
        [self startDrag:self.downEvent 
			   filename:self.fileName];
	}
	self.downEvent = nil;
}


- (NSString *)extensionForType:(NSBitmapImageFileType)imageFileType
{
    switch (imageFileType) {
        case NSTIFFFileType:
            return @"tiff";
            break;
        case NSBMPFileType:
            return @"bpm";
            break;
        case NSGIFFileType:
            return @"gif";
            break;
        case NSJPEGFileType:
            return @"jpg";
            break;
        case NSPNGFileType:
            return @"png";
            break;
        case NSJPEG2000FileType:
            return @"j2k";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)fileName
{
    if (!_fileName) {
        return @"Filename";
    }
    return _fileName;
}

- (NSString *)imageCachePath
{
    if (!_imageCachePath) {
        return @"/tmp";
    }
    return _imageCachePath;
}


@end
