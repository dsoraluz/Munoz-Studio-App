//
//  FavoritesViewController.m
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Photos.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
{
    int currentPicture;
    NSManagedObjectContext *context;
    NSMutableArray *photoarray;
}
@synthesize appdel, DisplayedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the title to be displayed on the tab bar.
        self.title = @"Favorites";
        self.tabBarItem.image = [UIImage imageNamed:@"ticket"];
        appdel = [[UIApplication sharedApplication] delegate];
        context = [appdel managedObjectContext];
        currentPicture = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getPhotos];
    currentPicture = 0;
    if(photoarray.count!=0)
    {
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [self getPhotos];
    currentPicture = 0;
    if(photoarray.count!=0)
    {
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;
    }
}

-(void) getPhotos
{
    //JB
    //Method to obtain all the photos currently in the database
    NSEntityDescription *entitydisc = [NSEntityDescription entityForName:@"Photos" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setFetchBatchSize:25];
    [request setEntity:entitydisc];
    NSError *error;
    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    //Selects only the photos that are selected as favorites
    for(Photos *photo in results)
    {
        Photos *photo = [results objectAtIndex:currentPicture];
        if ([photo.favorited boolValue] == YES)
        {
            [temp addObject:photo];
        }
        currentPicture++;
    }
    if (temp.count!=0)
    {
        photoarray = temp;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Next:(id)sender
{
    //method to view the next image  JB
    currentPicture++;
    if(currentPicture != photoarray.count)
    {
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;        
    }
    else
    {
        currentPicture=0;
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;        
    }
}

- (IBAction)Previous:(id)sender
{
    //method to view the previous image  JB
    if(currentPicture != 0)
    {
        currentPicture--;
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;        
    }
    else
    {
        currentPicture = photoarray.count-1;
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;
    }
}
@end
