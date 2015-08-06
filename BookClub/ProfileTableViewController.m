//
//  ProfileTableViewController.m
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "ProfileTableViewController.h"
#import <CoreData/CoreData.h>
#import "AddBookViewController.h"
#import "BookDetailTableViewController.h"
#import "Friend.h"
#import "Book.h"

@interface ProfileTableViewController ()
@property NSArray *books;

@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.friend.name;
    [self loadBooks];
}

- (void)loadBooks {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    request.predicate = [NSPredicate predicateWithFormat:@"friend = %@", self.friend];
    self.books = [self.moc executeFetchRequest:request error:NULL];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    Book *book = self.books[indexPath.row];
    cell.textLabel.text = book.name;
    cell.detailTextLabel.text = book.author;
    return cell;
}


#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"Book"]) {
        BookDetailTableViewController *vc = segue.destinationViewController;
        vc.moc = self.moc;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        Book *book = self.books[indexPath.row];
        vc.book = book;
    }
    else {
        AddBookViewController *vc = segue.destinationViewController;
        vc.moc = self.moc;
        vc.friend = self.friend;
    }

}

- (IBAction)unwindBookSegue:(UIStoryboardSegue *)segue {
    [self loadBooks];
}


@end
