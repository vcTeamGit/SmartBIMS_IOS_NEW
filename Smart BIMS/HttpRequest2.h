//
//  HttpRequest2.h
//  iBloodInfo
//
//  Created by wireline on 10. 6. 16..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomURLConnection;


@interface HttpRequest2 : NSObject {
	NSMutableDictionary* m_receivedData;
	
	id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) NSMutableDictionary* m_receivedData;

@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;


- (void) load;
- (void) load:(NSString*)url tag:(NSString*)tag;

- (void)startAsyncLoad:(NSURL*)url tag:(NSString*)tag;
- (void)startAsyncLoad:(NSString*)url bodyObject:(NSDictionary*)bodyObject tag:(NSString*)tag;
- (NSMutableData*)dataForConnection:(CustomURLConnection*)connection;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

- (void) setDelegate:(id)target selector:(SEL)selector;

@end