//
//  CustomURLConnection.m
//  iBloodInfo
//
//  Created by wireline on 10. 6. 16..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomURLConnection.h"


@implementation CustomURLConnection

@synthesize m_tag;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately tag:(NSString*)tag {
	self = [super initWithRequest:request delegate:delegate startImmediately:startImmediately];
	
	if (self) {
		self.m_tag = tag;
	}
	return self;
}

- (void)dealloc {
	[m_tag release];
	[super dealloc];
}

@end
