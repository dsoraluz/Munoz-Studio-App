//
//  AllPhotosViewController.m
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/3/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import "AllPhotosViewController.h"
#import "Photos.h"
#import "DetailsViewController.h"

@interface AllPhotosViewController ()
@end

@implementation AllPhotosViewController
{
    int currentPicture;
    NSManagedObjectContext *context;
    NSMutableArray *photoarray;    
}
@synthesize appdel, DisplayedImage, DVC, filter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the title to be displayed on the tab bar. 
        self.title = @"All Photos";
        self.tabBarItem.image = [UIImage imageNamed:@"multiple"];
        appdel = [[UIApplication sharedApplication] delegate];
        context = [appdel managedObjectContext];
        currentPicture=1;
        //loads all the stock photos into the database
        while(currentPicture!=5)
        {
            Photos *photodata = [NSEntityDescription insertNewObjectForEntityForName:@"Photos" inManagedObjectContext:context];
            NSString *photostring = [NSString stringWithFormat:@"%i.png", currentPicture];
            UIImage *image = [UIImage imageNamed:photostring];
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
            photodata.name = photostring;
            photodata.owner = @"default";
            photodata.photo = imageData;
            if(currentPicture<3)
            photodata.sessionid = @"1";
            else
            photodata.sessionid = @"2";
            NSError *error;
            if (![context save:&error])
            {
                NSLog(@"Couldn't create the subscription");
            }
            currentPicture++;
        }
        currentPicture=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DVC = [[DetailsViewController alloc]
           initWithNibName:@"DetailsViewController" bundle:nil];
    [self getPhotos];
    Photos *photo = [photoarray objectAtIndex:currentPicture];
    UIImage *setphoto = [UIImage imageWithData :[photo photo]];
    DisplayedImage.image = setphoto;
}

- (void) viewDidAppear:(BOOL)animated
{
    [self getPhotos];
    Photos *photo = [photoarray objectAtIndex:currentPicture];
    UIImage *setphoto = [UIImage imageWithData :[photo photo]];
    DisplayedImage.image = setphoto;
}

- (IBAction)NextImage:(id)sender
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

//-(BOOL) textFieldShouldReturn:(UITextField *)textField{ //KL
//    
//    [textField resignFirstResponder];
//    return YES;
//}

- (IBAction)detailButton:(id)sender
{
    [self.navigationController pushViewController:DVC  animated:YES];
    DVC.myImage.image = DisplayedImage.image;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  //KL
    [filter resignFirstResponder];
}

- (IBAction)filter:(id)sender
{ //KL
    //method to search through the images based on session id
    [self getPhotos];
    if ([filter.text isEqualToString:@""])
    {
        // resets array to original ("all")
        [self getPhotos];
        currentPicture = 0; //KL
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;
    }
    //JB
    if ([filter.text isEqualToString:@"2"] || [filter.text isEqualToString:@"1"])
    {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for(Photos *photo in photoarray)
        {
            //Cycles through all the photos to find the right one
            if([photo.sessionid isEqualToString:filter.text])
            {
                [temp addObject:photo];
            }
        }
        photoarray = temp;
        currentPicture = 0; //JB
        Photos *photo = [photoarray objectAtIndex:currentPicture];
        UIImage *setphoto = [UIImage imageWithData:[photo photo]];
        DisplayedImage.image = setphoto;
    }
}

//Deletes current photo in database  JB
- (IBAction)delete:(id)sender
{    
    [context deleteObject:[photoarray objectAtIndex:currentPicture]];
    [self getPhotos];
    currentPicture = 0;
    Photos *photo = [photoarray objectAtIndex:currentPicture];
    UIImage *setphoto = [UIImage imageWithData:[photo photo]];
    DisplayedImage.image = setphoto;
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
    photoarray = results;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Sets boolean in  photo object to true and puts it back in the database
- (IBAction)favorite:(id)sender
{
    int temp;
    temp = currentPicture;
    Photos *photo = [photoarray objectAtIndex:currentPicture];
    photo.favorited = [NSNumber numberWithBool:YES];
    [photoarray insertObject:photo atIndex:currentPicture];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Couldn't create the subscription");
    }
    currentPicture = temp;
}
@end
