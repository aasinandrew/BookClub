//
//  BookDetailTableViewController.m
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "BookDetailTableViewController.h"
#import <CoreData/CoreData.h>
#import "Book.h"
#import "Comment.h"

@interface BookDetailTableViewController ()
@property NSArray *comments;


@end

@implementation BookDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.book.name;
    
    [self loadComments];
}

- (void)loadComments {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Comment"];
    request.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.book];
    self.comments = [self.moc executeFetchRequest:request error:NULL];
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    Comment *comment = self.comments[indexPath.row];
    cell.textLabel.text = comment.comment;
    
    return cell;
}

#pragma mark - IBActions

- (IBAction)onAddCommentButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Leave A Comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comment";
    }];

    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add Comment" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *commentTextField = [[alert textFields] firstObject];
        NSString *enteredComment = commentTextField.text;

        Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.moc];
        comment.comment = enteredComment;
        comment.book = self.book;

        [self.moc save:NULL];
        [self loadComments];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];

    [alert addAction:addAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
