//
//  AllPhotosViewController.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunozStudioAppAppDelegate.h"
@class DetailsViewController;

@interface AllPhotosViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) MunozStudioAppAppDelegate *appdel;
@property (strong, nonatomic) IBOutlet UIImageView *DisplayedImage;
@property (strong, nonatomic) DetailsViewController * DVC;
@property (strong, nonatomic) IBOutlet UITextField *filter;
- (IBAction)NextImage:(id)sender;
- (IBAction)detailButton:(id)sender;
- (IBAction)filter:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)favorite:(id)sender;

@end
