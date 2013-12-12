//
//  FavoritesViewController.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunozStudioAppAppDelegate.h"

@interface FavoritesViewController : UIViewController

@property (nonatomic, retain) MunozStudioAppAppDelegate *appdel;
@property (strong, nonatomic) IBOutlet UIImageView *DisplayedImage;
- (IBAction)Next:(id)sender;
- (IBAction)Previous:(id)sender;

@end
