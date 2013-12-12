//
//  MunozStudioAppAppDelegate.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/2/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllPhotosViewController;

@interface MunozStudioAppAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) AllPhotosViewController *AVC;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
