//
//  CameraViewController.m
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import "CameraViewController.h"
#import "Photos.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize takenPicture, imagePicker, appdel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the title and image to be displayed on the tab bar.
        self.title = @"Camera";
        self.tabBarItem.image = [UIImage imageNamed:@"camera"];
        appdel = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.tabBarController.delegate = self;
    [self startCameraControllerFromViewController:self usingDelegate:self];
    
}


//JB
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //loads the camera when the camera tab button is selected
    if ([viewController.tabBarItem.title isEqualToString:@"Camera"])
    {
        [self startCameraControllerFromViewController: self
                                        usingDelegate: self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//DS
//Method that checks if the camera hardware is avaiable and presents it as the view of the window.
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    //Checks to see if the hardware supports a camera.
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    //Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    //Specify the types of camera features available.
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    //Shows the controls for moving & scaling pictures.
    // To hide the controls, use NO
    cameraUI.allowsEditing = YES;
    
    //Set the delegate for the camera
    cameraUI.delegate = delegate;
    
    //Push the view onto the stack
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

//DS
//Taking the picture taken by the user and saving it to the core database
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Create an image and store the acquired picture
    UIImage *imageToSave;
    imageToSave = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    
    [self AddPhoto:imageToSave];
    
    //Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}


// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    //dismisses the camera and loads the allphotosviewcontroller
    [self dismissViewControllerAnimated: YES completion: nil];
    [self.tabBarController setSelectedIndex:0];
}

//Method that adds a taken photo to core database
- (void) AddPhoto:(UIImage *) photo
{
    NSManagedObjectContext *context = [appdel managedObjectContext];
    Photos *photodata = [NSEntityDescription insertNewObjectForEntityForName:@"Photos" inManagedObjectContext:context];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MMddmmss"];
    NSString *stringDate = [dateFormat stringFromDate:[NSDate date]];
    NSString *name = [stringDate stringByAppendingString:@".png"];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(photo)];
    photodata.name = name;
    photodata.owner = @"default";
    photodata.photo = imageData;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Couldn't create the subscription");
    }
} 
@end
