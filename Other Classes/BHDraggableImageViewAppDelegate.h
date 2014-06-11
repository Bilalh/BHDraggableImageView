//
//  BHDraggableImageViewAppDelegate.h
//  BHDraggableImageView
//
//  Created by Bilal Syed Hussain on 09/08/2011.
//  Copyright 2011 St. Andrews KY16 9XW. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BHDraggableImageViewAppDelegate : NSObject <NSApplicationDelegate> {
@private
	NSWindow *__strong window;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSImage  *cover;

@end
