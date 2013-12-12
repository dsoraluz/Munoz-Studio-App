//
//  DetailsViewController.m
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import "DetailsViewController.h"
#import "AllPhotosViewController.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>


@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize myImage, appdel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Details";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];   
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavorites)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Action taken whent the requestToBeDeveloped button is pressed.
- (IBAction)requestToBeDeveloped:(id)sender
{
    //DS
    
    //Create photo data to be used for the attachment
    NSData *data = UIImagePNGRepresentation(myImage.image);
    
    // Email Subject
    NSString *emailTitle = @"I want this photo developed.";
    // Email Content
    NSString *messageBody = @"Please develop this photo.";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"d.soraluz@gmail.com"];
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [mc addAttachmentData:data mimeType:@"image/png" fileName:@"Photo to be developed"];
    
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

//DS
//Reports the status of the transmission of the email and dismisses the MailComposeViewController
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
        switch (result)
        {
            case MFMailComposeResultCancelled:
                NSLog(@"Mail cancelled");
                break;
            case MFMailComposeResultSaved:
                NSLog(@"Mail saved");
                break;
            case MFMailComposeResultSent:
                NSLog(@"Mail sent");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"Mail sent failure: %@", [error localizedDescription]);
                break;
            default:
                break;
        }
        
        // Close the Mail Interface
        [self dismissViewControllerAnimated:YES completion:NULL];
    
}



//Invokes the Twitter support build into iOS to send a simple tweet via the app
- (IBAction)tweetButton:(id)sender
{
    
    //TWITTER KL
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I just sent a picture using the Munoz Studio App!!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }

}
@end
