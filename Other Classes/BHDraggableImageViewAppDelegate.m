//
//  BHDraggableImageViewAppDelegate.m
//  BHDraggableImageView
//
//  Created by Bilal Syed Hussain on 09/08/2011.
//  Copyright 2011 St. Andrews KY16 9XW. All rights reserved.
//

#import "BHDraggableImageViewAppDelegate.h"

@implementation BHDraggableImageViewAppDelegate

@synthesize window, cover;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.cover = [NSImage imageNamed:@"feather.jpg"];
}

@end
