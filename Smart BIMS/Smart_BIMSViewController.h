//
//  Smart_BIMSViewController.h
//  Smart BIMS
//
//  Created by  on 11. 8. 4..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBLoginViewController;
@class SBDeviceConfirmViewController;


@interface Smart_BIMSViewController : UIViewController
{
    SBLoginViewController* m_SBLoginViewController;
    SBDeviceConfirmViewController* m_SBDeviceConfirmViewController;
}

@property (nonatomic, retain) IBOutlet SBLoginViewController* m_SBLoginViewController;
@property (nonatomic, retain) IBOutlet SBDeviceConfirmViewController* m_SBDeviceConfirmViewController;


//- (void)applicationWillResignActiveWithConfigSave:(NSNotification *)notification;

@end
