//
//  HttpRequest.m
//  Pilot2
//
//  Created by wireline on 10. 6. 7..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"


@implementation HttpRequest

@synthesize m_receivedData;
@synthesize m_response;
@synthesize m_result;
@synthesize m_target;
@synthesize m_selector; 

- (BOOL) requestURL:(NSString*)url bodyObject:(NSDictionary*)bodyObject
{
    NSMutableArray* parts = [NSMutableArray array];
    NSString* part;
    
    if(bodyObject){
        id key;
        id value;
        
        for(key in bodyObject){
            value = [bodyObject objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", key, value];
            [parts addObject:part];
        }
    }
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@",[parts componentsJoinedByString:@"&"]];
    NSURL *urls = [NSURL URLWithString: url];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:urls];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    request.timeoutInterval = 60;
    
    NSURLConnection* connection = [[[NSURLConnection alloc] initWithRequest:request
                                                                   delegate:self]
                                   autorelease];
	
	if(connection){
        if(m_receivedData != nil){
            TRACE(@"HttpRequest m_receivedData will released");
            [m_receivedData release];
        }
        
        m_receivedData = [[NSMutableData alloc] init];
		
		return YES;
	}else{
		return NO;
	}
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// 데이터를 전송받기 전에 호출되는 메서드, 우선 Response의 헤더만을 먼저 받아 온다.
    //[receivedData setLength:0];
	self.m_response = response;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// 데이터를 전송받는 도중에 호출되는 메서드, 여러번에 나누어 호출될 수 있으므로 appendData를 사용한다.
	[m_receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	// 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
    if(m_result != nil){
        TRACE(@"HttpRequest m_result will released");
        [m_result release];
    }
	m_result = [[NSString alloc] initWithData:m_receivedData
									 encoding:NSUTF8StringEncoding];
	
	if(m_target){
        if(m_result.length <= 0){
            // wireline - 20160421: 통신상 문제로 정상적인 값을 받지 못한 경우 예외처리
            [m_target performSelector:m_selector withObject:@"RTO"];
        }else{
            [m_target performSelector:m_selector withObject:m_result];
        }
	}
}

- (void) setDelegate:(id)target selector:(SEL)selector
{
	// 데이터 수신이 완료된 이후에 호출될 메서드의 정보를 담고 있는 셀렉터 설정
	self.m_target = target;
	self.m_selector = selector;
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // 에러가 발생되었을 경우 호출되는 메서드
    NSLog(@"Error: %@", [error localizedDescription]);
//    m_result = [NSString stringWithFormat:@"%@ \n VPN 설정을 확인하세요.", [error localizedDescription]];
    
    if(m_target){
//        [m_target performSelector:m_selector withObject:[error localizedDescription]];
        [m_target performSelector:m_selector withObject:@"RTO"];
    }
}


- (void)dealloc
{
    [m_receivedData release];
    [m_response release];
    [m_result release];
    [super dealloc];
}


@end
