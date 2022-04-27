//
//  PictureLibViewController.m
//  SmartBIMS
//
//  Created by  on 12. 4. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "PictureLibViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface PictureLibViewController ()

static UIImage* shrinkImage(UIImage* original, CGSize size);

- (void)updateDisplay;
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType;

@end

@implementation PictureLibViewController

@synthesize imageView;
@synthesize takePictureButton;
@synthesize moviePlayerController;
@synthesize image;
@synthesize movieURL;
@synthesize lastChosenMediaType;
@synthesize m_uploadButton;




#pragma mark upload 
- (IBAction)uploadContent:(id)sender;{
    NSString *url = @"http://mbims.bloodinfo.net:59999/mbims/appservice/SBFileUploadTest.jsp";
    
    NSData *imageData = UIImageJPEGRepresentation(imageView.image, 0.9);
    //UIImageJPEGRepresentation(UIViewImage.image,퀄리티);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
	NSMutableData *httpBody = [NSMutableData data];
	[httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //ACT_NAME
	[httpBody appendData:[[NSString stringWithFormat:@"content-disposition: form-data; name=\"ACT_NAME\"\r\n\r\n%@",@"APP_UPLOAD"] dataUsingEncoding:NSUTF8StringEncoding] ];
	[httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
    
    //파일정보
	[httpBody appendData:[@"Content-Disposition:form-data; name=\"FileData\"; filename=\"test.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[httpBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];   
	[httpBody appendData:[NSData dataWithData:imageData]];
    [httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
	[request setHTTPBody:httpBody];
    
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];    
    TRACE(@"uploadContent returnString = [%@]",returnString);
}


#pragma mark - 
- (IBAction)shootPictureOrVideo:(id)sender
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectExistingPictureOrVideo:(id)sender
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)onBack:(id)sender
{
    [self.view removeFromSuperview];
}


#pragma mark UIImagePickerController delegate methods
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([lastChosenMediaType isEqual:(NSString*)kUTTypeImage]){
        UIImage* chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage* shrunkenImage = shrinkImage(chosenImage, imageFrame.size);
        self.image = shrunkenImage;
    }else if([lastChosenMediaType isEqual:(NSString*)kUTTypeMovie]){
        self.movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
    }
    
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
static UIImage* shrinkImage(UIImage* original, CGSize size)
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale, size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width * scale, size.height * scale), original.CGImage);
    
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage* final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
}

- (void)updateDisplay
{
    if([lastChosenMediaType isEqual:(NSString*)kUTTypeImage]){
        imageView.image = image;
        imageView.hidden = NO;
        moviePlayerController.view.hidden = YES;
    }else if([lastChosenMediaType isEqual:(NSString*)kUTTypeMovie]){
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = [[[MPMoviePlayerController alloc] initWithContentURL:movieURL] autorelease];
        moviePlayerController.view.frame = imageFrame;
        moviePlayerController.view.clipsToBounds = YES;
        [moviePlayerController play];
        
        [self.view addSubview:moviePlayerController.view];
        imageView.hidden = YES;
    }
}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0){
        NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
//        [self presentModalViewController:picker animated:YES];
        [self presentViewController:picker
                           animated:YES
                         completion:nil];
        [picker release];
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media"
                                                        message:@"Device doesn't support that media source."
                                                       delegate:nil
                                              cancelButtonTitle:@"Drat!"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}


#pragma mark -
#pragma mark Defaults

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        takePictureButton.hidden = YES;
    }
    
    imageFrame = imageView.frame;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.imageView = nil;
    self.takePictureButton = nil;
    self.moviePlayerController = nil;
    
    self.m_uploadButton = nil;
}

- (void)dealloc
{
    [imageView release];
    [takePictureButton release];
    [moviePlayerController release];
    [image release];
    [movieURL release];
    [lastChosenMediaType release];
    [m_uploadButton release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
