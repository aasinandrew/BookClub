//
//  Book.h
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Friend;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) Friend *friend;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
