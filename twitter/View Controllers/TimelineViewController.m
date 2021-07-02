//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"

@interface TimelineViewController () <DetailsViewControllerDelegate, ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = [[NSMutableArray alloc] initWithArray:tweets];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                //NSString *text = dictionary[@"text"];
//                NSLog(@"%@", dictionary[@"text"]);
//            }
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonClicked:(UIButton *)sender {
    
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    NSLog(@"Byeee");

    [[APIManager shared] logout];
}

// Makes a network request to get updated data
  // Updates the tableView with the new data
  // Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = [[NSMutableArray alloc] initWithArray:tweets];
            NSLog(@"😎😎😎 Refreshed home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                //NSString *text = dictionary[@"text"];
//                NSLog(@"%@", dictionary[@"text"]);
//            }
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            
            [self.tableView reloadData];
            [refreshControl endRefreshing];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        DetailsViewController *detailsViewController = (DetailsViewController*)navigationController.topViewController;
        detailsViewController.delegate = self;
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.arrayOfTweets[indexPath.row];
        detailsViewController.tweet = tweet;
    }
    else
    {
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    Tweet *currentTweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = currentTweet;
    
    NSString *URLString = cell.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [cell.profileImage setImageWithURL:url];
    
    cell.name.text = cell.tweet.user.name;
    cell.username.text = [@"@" stringByAppendingString:cell.tweet.user.screenName];
    cell.date.text = cell.tweet.createdAtString;
    cell.tweetText.text = cell.tweet.text;
    cell.replyCount.text = @"0"; //no reply functionality
    cell.retweetButton.selected = cell.tweet.retweeted;
    cell.retweetCount.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    cell.likeButton.selected = cell.tweet.favorited;
    cell.likeCount.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (void)didTweet:(nonnull Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

-(void)didUpdate: (nonnull Tweet *)tweet {
    int index = [self.arrayOfTweets indexOfObject:tweet];
    [self.arrayOfTweets replaceObjectAtIndex:index withObject:tweet ];
    [self.tableView reloadData];
}



@end
