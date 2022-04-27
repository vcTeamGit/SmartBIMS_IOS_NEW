//
//  PictureLibViewController.h
//  SmartBIMS
//
//  Created by  on 12. 4. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PictureLibViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImageView* imageView;
    UIButton* takePictureButton;
    MPMoviePlayerController* moviePlayerController;
    UIImage* image;
    NSURL* movieURL;
    NSString* lastChosenMediaType;
    CGRect imageFrame;
    
    UIButton* m_uploadButton;
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIButton* takePictureButton;
@property (nonatomic, retain) MPMoviePlayerController* moviePlayerController;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) NSURL* movieURL;
@property (nonatomic, retain) NSString* lastChosenMediaType;

@property (strong) IBOutlet UIButton* m_uploadButton;


- (IBAction)shootPictureOrVideo:(id)sender;
- (IBAction)selectExistingPictureOrVideo:(id)sender;

- (IBAction)onBack:(id)sender;

- (IBAction)uploadContent:(id)sender;

@end
