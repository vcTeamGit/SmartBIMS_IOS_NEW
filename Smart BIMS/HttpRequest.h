//
//  HttpRequest.h
//  Pilot2
//
//  Created by wireline on 10. 6. 7..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequest : NSObject {
	NSMutableData* m_receivedData;
	NSURLResponse* m_response;
	NSString* m_result;
	id m_target;
	SEL m_selector;
}

@property (nonatomic, retain) NSMutableData* m_receivedData;
@property (nonatomic, retain) NSURLResponse* m_response;
@property (nonatomic, assign) NSString* m_result;
@property (nonatomic, assign) id m_target;
@property (nonatomic, assign) SEL m_selector;

- (BOOL) requestURL:(NSString*)url bodyObject:(NSDictionary*)bodyObject;
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void) connectionDidFinishLoading:(NSURLConnection *)connection;
- (void) setDelegate:(id)target selector:(SEL)selector;


@end