//
//  Smart_BIMSAppDelegate.m
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "Smart_BIMSAppDelegate.h"

#import "Smart_BIMSViewController.h"
#import "SBLoginViewController.h"

#import "HttpRequest.h"
#import "JSON.h"

#import "SBUtils.h"

@implementation Smart_BIMSAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

@synthesize m_httpRequest;

@synthesize g_strConfirmNo;
@synthesize g_strPhoneNo;
@synthesize g_strDeviceToken;

@synthesize g_mDicConfig;

@synthesize g_viewWidth;
@synthesize g_viewHeight;
@synthesize g_winHeight;

@synthesize bgTask;



#pragma marks - 
#pragma marks Custom Mothods
- (NSString*)dataFilePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kConfigFileName];
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return YES;
}


//push : APNS 에 장치 등록 성공시 자동실행
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	TRACE(@"deviceToken := [%@]", deviceToken);

    NSString* strTempDeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString* strDeviceToken = [strTempDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    TRACE(@"strDeviceToken := [%@]", strDeviceToken);
    
    self.g_strDeviceToken = [NSString stringWithString:strDeviceToken];
}



//- (void) didReceiveResponse:(id)result
//{
//    NSString* strRetVal = (NSString*)result;
//    NSString* strResult;
//    
//    strRetVal = [strRetVal stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
//    
//    SBJsonParser* jsonParser = [SBJsonParser new];
//    NSDictionary* dictionary = nil;
//    
//    // JSON 문자열을 객체로 변환
//    dictionary = [jsonParser objectWithString:strRetVal error:nil];
//    
//    // 결과 출력
//    NSString* key;
//    for (key in dictionary) {
//        TRACE(@"Key: %@, Value: %@", key, [dictionary valueForKey:key]);
//    }
//    
//    strResult = [dictionary valueForKey:@"result"];
//    
//    TRACE(@"APNS strResult := [%@]", strResult);
//    
//    // if strResult == 1 is success!
//}



//push : APNS 에 장치 등록 오류시 자동실행
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	TRACE(@"deviceToken error : %@", error);
}


//push : 어플 실행중에 알림도착
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSDictionary *aps = [userInfo valueForKey:@"aps"];
	TRACE(@"userInfo Alert : %@", [aps valueForKey:@"alert"]);
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"[알림]"
                                                        message:[aps valueForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles: nil];
    
    [alertView show];
    [alertView release];
}



//self.window.frame = [UIScreen mainScreen].bounds; 


// 어플 실행 시에 최초 한 번 실행됨.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 탈옥 폰 방지 / 파일 권한 기반 체크
    NSError *error;
    NSString *stringToBeWritten = @"";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if(error == nil) {
        exit(0);
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    // 탈옥 폰 방지 / 시디아앱을 이용한 프로토콜 핸들러 체크
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        exit(0);
    }
    
    // 화면크기 체크
    CGRect frame = [UIScreen mainScreen].bounds;
    // 320.000000, 568.000000
    TRACE(@"단말기 크기 %f, %f", frame.size.width, frame.size.height);
    NSLog(@"%f", self.window.frame.size.width);
    NSLog(@"%f", [UIScreen mainScreen].bounds.size.width);
    self.g_viewWidth = [NSNumber numberWithDouble:frame.size.width];
    self.g_viewHeight = [NSNumber numberWithDouble:(frame.size.height)]; // -20
    self.g_winHeight = [NSNumber numberWithDouble:frame.size.height];
    
//    self.g_viewWidth = [NSNumber numberWithDouble:320];
//    self.g_viewHeight = [NSNumber numberWithDouble:(568 - 20)];
//    self.g_winHeight = [NSNumber numberWithDouble:568];
    
    // 저장 체크 변수
    // NSInteger intValue = 0;
    //        NSString *key = @"chkTakeOverIsSaved";
    //        [[NSUserDefaults standardUserDefaults] setInteger:intValue forKey:key];
    //        [[NSUserDefaults standardUserDefaults] synchronize];

    
    TRACE(@"%@", NSStringFromSelector(_cmd));
    
    m_httpRequest = [[HttpRequest alloc] init];
    
    NSString* filePath = [self dataFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        g_mDicConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if(g_mDicConfig == nil){
            self.g_strConfirmNo = @"";
            self.g_strPhoneNo = @"";
            self.g_strDeviceToken = @"";
        }else{
            if([g_mDicConfig objectForKey:@"confirmNo"] == nil){
                g_strConfirmNo = @"";
            }else{
                g_strConfirmNo = [NSString stringWithString:[g_mDicConfig objectForKey:@"confirmNo"]];
            }
            
            if([g_mDicConfig objectForKey:@"phoneNo"] == nil){
                g_strPhoneNo = @"";
            }else{
                g_strPhoneNo = [NSString stringWithString:[g_mDicConfig objectForKey:@"phoneNo"]];
            }
            
            if([g_mDicConfig objectForKey:@"deviceToken"] == nil){
                g_strDeviceToken = @"";
            }else{
                g_strDeviceToken = [NSString stringWithString:[g_mDicConfig objectForKey:@"deviceToken"]];
            }
        }
        
        TRACE(@"confirmNO=[%@], phoneNO=[%@], deviceToken=[%@]", g_strConfirmNo, g_strPhoneNo, g_strDeviceToken);
        
//        [mDic release];
    }else{
        TRACE(@"No config");
        self.g_strConfirmNo = @"";
        self.g_strPhoneNo = @"";
        self.g_strDeviceToken = @"";
    }
    
#ifdef APNS_TEST_MODE
//    int nRemoteNotificationTypes = [application enabledRemoteNotificationTypes];
    
    //APNS 에 장치 등록
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    //Badge 개수 설정
    application.applicationIconBadgeNumber = 0;
#endif
    
    TRACE(@"단말 OS버전 [%f]", [[UIDevice currentDevice].systemVersion floatValue]);
    
    // iOS7 향... 화면 status bar 아래로 내리는 녀석
//    if ([[UIDevice currentDevice].systemVersion floatValue] < 13) {
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    } else {
//        // handling statusBar (iOS7)
//        application.statusBarStyle = UIStatusBarStyleLightContent;
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//        self.window.clipsToBounds = NO;
//
//
//        // handling screen rotations for statusBar (iOS7)
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return YES;
}

// iOS7 향...
- (void)applicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification {
    // handling statusBar (iOS7)
    self.window.frame = [UIScreen mainScreen].bounds;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    TRACE(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    TRACE(@"%@", NSStringFromSelector(_cmd));
    
    
    UIApplication*    app = [UIApplication sharedApplication];
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [app endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    
    // Start the long-running task and return immediately.
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // Do the work associated with the task.
//        // VPN 터널링 유지를 위한 강제 트래픽 발생
//        [NSTimer scheduledTimerWithTimeInterval:5
//                                         target:self
//                                       selector:@selector(makeTrafficForVPN)
//                                       userInfo:nil
//                                        repeats:YES];
//        
//        [app endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    TRACE(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    TRACE(@"%@", NSStringFromSelector(_cmd));
    
//    self.window.rootViewController = self.viewController;
    [_window setRootViewController:_viewController];
    [self.window makeKeyAndVisible];
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    TRACE(@"%@", NSStringFromSelector(_cmd));
    
    NSMutableDictionary* tempMDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    [tempMDic setObject:g_strConfirmNo forKey:@"confirmNo"];
    [tempMDic setObject:g_strPhoneNo forKey:@"phoneNo"];
    [tempMDic setObject:g_strDeviceToken forKey:@"deviceToken"];
    
    [tempMDic writeToFile:[self dataFilePath]
               atomically:YES];
    [tempMDic release];
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    
    [m_httpRequest release];
    
    [g_strPhoneNo release];
    [g_strConfirmNo release];
    [g_strDeviceToken release];
    
    [g_mDicConfig release];
    
    [super dealloc];
}

@end
