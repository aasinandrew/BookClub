//
//  BookDetailTableViewController.h
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;
@interface BookDetailTableViewController : UITableViewController
@property Book *book;
@property NSManagedObjectContext *moc;

@end
