//
//  Photos.h
//  Munoz Studio App
//
//  Created by daniel alejandro soraluz on 12/11/13.
//  Copyright (c) 2013 daniel alejandro soraluz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photos : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * sessionid;
@property (nonatomic, retain) NSNumber * favorited;

@end
