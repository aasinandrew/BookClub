//
//  ProfileTableViewController.h
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Friend;
@interface ProfileTableViewController : UITableViewController

@property Friend *friend;
@property NSManagedObjectContext *moc;
@end
