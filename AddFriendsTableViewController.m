//
//  AddFriendsTableViewController.m
//  
//
//  Created by Andrew  Nguyen on 8/5/15.
//
//

#import "AddFriendsTableViewController.h"
#import <CoreData/CoreData.h>
#import "Friend.h"


@interface AddFriendsTableViewController ()
@property NSArray *friends;


@end

@implementation AddFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];

}

- (void)getData {
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mmios8week/friends.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.friends = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    }]resume];

}

#pragma mark - Table view data source & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddFriendCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.friends[indexPath.row];

    NSString *name = self.friends[indexPath.row];

    if ([self.checkedFriends containsObject:name]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSString * name = [self.friends objectAtIndex:indexPath.row];



    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Friend"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSArray *results = [self.moc executeFetchRequest:request error:NULL];

        [self.moc deleteObject:results.firstObject];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

        Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.moc];
        friend.name = self.friends[indexPath.row];
    }
    [self.moc save:NULL];
}

@end
