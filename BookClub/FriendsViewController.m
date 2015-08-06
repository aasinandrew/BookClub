//
//  ViewController.m
//  BookClub
//
//  Created by Andrew  Nguyen on 8/5/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "FriendsViewController.h"
#import <CoreData/CoreData.h>
#import "Friend.h"
#import "ProfileTableViewController.h"

@interface FriendsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property NSArray *friends;
@property NSMutableArray *filteredFriends;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL isFiltered;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFriends];
    self.isFiltered = NO;

}

- (void)viewWillAppear:(BOOL)animated {
    [self loadFriends];
}

- (void)loadFriends {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Friend"];

    NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:@"books.@count" ascending:NO];
    NSArray *d = [[NSArray alloc]initWithObjects:sd, nil];

    self.friends =  [self.moc executeFetchRequest:request error:NULL];
    self.friends = [self.friends sortedArrayUsingDescriptors:d];

    [self.tableView reloadData];
}

#pragma mark - searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isFiltered = NO;
    }
    else {
        self.isFiltered = YES;
        [self filterContentForSearchText:searchText];
    }

    [self.tableView reloadData];
}

-(void)filterContentForSearchText:(NSString*)searchText{

    [self.filteredFriends removeAllObjects];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@",searchText];
    self.filteredFriends = [NSMutableArray arrayWithArray:[self.friends filteredArrayUsingPredicate:predicate]];
}


#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount;
    if (self.isFiltered) {
        rowCount = self.filteredFriends.count;
    }
    else {
        rowCount = self.friends.count;
    }

    return rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    Friend * friend;
    if (self.isFiltered) {
        friend = self.filteredFriends[indexPath.row];
    }
    else {
        friend = self.friends[indexPath.row];
    }
    cell.textLabel.text = friend.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"Profile"]) {
        ProfileTableViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath =  [self.tableView indexPathForCell:(UITableViewCell *)sender];
        Friend *friend;
        if (self.isFiltered) {
            friend = [self.filteredFriends objectAtIndex:indexPath.row];
        }
        else {
            friend  = [self.friends objectAtIndex:indexPath.row];
        }
        vc.friend = friend;
        vc.moc = self.moc;
    }

    else {
        AddFriendsTableViewController *vc = segue.destinationViewController;
        vc.moc = self.moc;

        NSMutableArray *names = [NSMutableArray new];
        for (NSManagedObject *friends in self.friends) {
            [names addObject:[friends valueForKey:@"name"]];
        }
        vc.checkedFriends = names;
    }
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    [self loadFriends];
}

@end
