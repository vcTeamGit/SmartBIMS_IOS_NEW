//
//  HttpRequest2.m
//  iBloodInfo
//
//  Created by wireline on 10. 6. 16..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest2.h"
#import "CustomURLConnection.h"


@implementation HttpRequest2

@synthesize m_receivedData;
@synthesize m_target;
@synthesize m_selector;


	

- (void)load {
	m_receivedData = [[NSMutableDictionary alloc] initWithCapacity:256];
	
	NSURL *url1 = [NSURL URLWithString:@"http://blog.emmerinc.be"];
	NSURL *url2 = [NSURL URLWithString:@"http://www.emmerinc.be"];
	NSURL *url3 = [NSURL URLWithString:@"http://twitter.com/emmerinc"]; 
	
	[self startAsyncLoad:url1 tag:@"tag1"];
	[self startAsyncLoad:url2 tag:@"tag2"];
	[self startAsyncLoad:url3 tag:@"tag3"];
}

- (void) load:(NSString*)url tag:(NSString*)tag
{
	NSURL* temp_url = [NSURL URLWithString:url];
	
	[self startAsyncLoad:temp_url
					 tag:tag];
}


- (void)startAsyncLoad:(NSString*)url bodyObject:(NSDictionary*)bodyObject tag:(NSString*)tag {
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
														   cachePolicy:NSURLRequestUseProtocolCachePolicy
													   timeoutInterval:60.0f];
	[request setHTTPMethod:@"POST"];
	
	if(bodyObject){
		NSMutableArray* parts = [NSMutableArray array];
		NSString* part;
		id key;
		id value;
		
		for(key in bodyObject){
			value = [bodyObject objectForKey:key];
			part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
					[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[parts addObject:part];
		}
		
		[request setHTTPBody:[[parts componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
	}
    
    
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	CustomURLConnection *connection = [[CustomURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES tag:tag];
	
	if (connection) {
		[m_receivedData setObject:[[NSMutableData data] retain] forKey:connection.m_tag];
	}
}


- (void)startAsyncLoad:(NSURL*)url tag:(NSString*)tag {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	CustomURLConnection *connection = [[CustomURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES tag:tag];
	
	if (connection) {
		[m_receivedData setObject:[[NSMutableData data] retain] forKey:connection.m_tag];
	}
}


- (NSMutableData*)dataForConnection:(CustomURLConnection*)connection {
	NSMutableData *data = [m_receivedData objectForKey:connection.m_tag];
	return data;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSMutableData *dataForConnection = [self dataForConnection:(CustomURLConnection*)connection];
	[dataForConnection setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSMutableData *dataForConnection = [self dataForConnection:(CustomURLConnection*)connection];
	[dataForConnection appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    CustomURLConnection* tempConn = [[CustomURLConnection alloc] init];
    tempConn = (CustomURLConnection*)connection;
    
	NSMutableData *dataForConnection = [self dataForConnection:(CustomURLConnection*)connection];
	
//	// 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
//	m_result = [[NSString alloc] initWithData:m_receivedData
//									 encoding:NSUTF8StringEncoding];
	
	if(m_target){
//		[m_target performSelector:m_selector withObject:dataForConnection];
        [m_target performSelector:m_selector withObject:dataForConnection withObject:tempConn.m_tag];
	}
	
	[connection release];
    [tempConn release];
	
	// Do something with the dataForConnection.
}


- (void) setDelegate:(id)target selector:(SEL)selector
{
	// 데이터 수신이 완료된 이후에 호출될 메서드의 정보를 담고 있는 셀렉터 설정
	self.m_target = target;
	self.m_selector = selector;
}


#pragma mark -
#pragma mark Default Methods

- (id) init
{
	NSLog(@"%@", @"init");
	if(self = [super init]){
		m_receivedData = [[NSMutableDictionary alloc] initWithCapacity:64];
	}
	
	return self;
}

- (void)dealloc
{
	m_target = nil;
	m_selector = nil;
	
    [m_receivedData release];
    [super dealloc];
}


@end
