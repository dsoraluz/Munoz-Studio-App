//
//  DetailsViewController.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunozStudioAppAppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface DetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *myImage;
@property (nonatomic, retain) MunozStudioAppAppDelegate *appdel;
- (IBAction)requestToBeDeveloped:(id)sender;
- (IBAction)tweetButton:(id)sender;

@end
