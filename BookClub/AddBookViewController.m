//
//  AddBookViewController.m
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "AddBookViewController.h"
#import <CoreData/CoreData.h>
#import "Book.h"
#import "Friend.h"

@interface AddBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)onAddButtonPressed:(UIButton *)sender {
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.moc];
    book.author = self.authorTextField.text;
    book.name = self.bookTextField.text;
    book.friend = self.friend;

    [self.friend addBooksObject:book];

    [self.moc save:NULL];
}

@end
