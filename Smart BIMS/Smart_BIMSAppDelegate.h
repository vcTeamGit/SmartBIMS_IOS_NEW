//
//  Smart_BIMSAppDelegate.h
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kConfigFileName @"config.plist"

@class Smart_BIMSViewController;
@class HttpRequest;

@interface Smart_BIMSAppDelegate : NSObject <UIApplicationDelegate>
{
    HttpRequest* m_httpRequest;
    
    NSString* g_strConfirmNo;
    NSString* g_strPhoneNo;
    NSString* g_strDeviceToken;
    
    NSMutableDictionary* g_mDicConfig;
    
    // 화면크기 저장 변수
    NSNumber* g_viewWidth;
    NSNumber* g_viewHeight;
    NSNumber* g_winHeight;
    
    UIBackgroundTaskIdentifier bgTask;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Smart_BIMSViewController *viewController;

@property (nonatomic, retain) HttpRequest* m_httpRequest;

@property (nonatomic, retain) NSString* g_strConfirmNo;
@property (nonatomic, retain) NSString* g_strPhoneNo;
@property (nonatomic, retain) NSString* g_strDeviceToken;

@property (nonatomic, retain) NSMutableDictionary* g_mDicConfig;

@property (nonatomic, retain) NSNumber* g_viewWidth;
@property (nonatomic, retain) NSNumber* g_viewHeight;
@property (nonatomic, retain) NSNumber* g_winHeight;

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;


- (NSString*)dataFilePath;


@end
