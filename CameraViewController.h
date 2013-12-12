//
//  CameraViewController.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunozStudioAppAppDelegate.h"

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate, UITabBarControllerDelegate>
{
    UIImageView *takenPicture;
}

@property (strong, nonatomic) IBOutlet UIImageView *takenPicture;
@property (strong, nonatomic) IBOutlet UIImagePickerController *imagePicker;
@property (nonatomic, retain) MunozStudioAppAppDelegate *appdel;

@end
