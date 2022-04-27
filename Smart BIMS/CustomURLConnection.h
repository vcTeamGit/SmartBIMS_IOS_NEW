//
//  CustomURLConnection.h
//  iBloodInfo
//
//  Created by wireline on 10. 6. 16..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomURLConnection : NSURLConnection {
	NSString* m_tag;
}

@property (nonatomic, retain) NSString *m_tag;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately tag:(NSString*)tag;

@end
