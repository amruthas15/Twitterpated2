//
//  DetailsViewController.m
//  twitter
//
//  Created by Amrutha Srikanth on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImage setImageWithURL:url];
    
    self.name.text = self.tweet.user.name;
    self.username.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.date.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    self.replyCount.text = @"0"; //no reply functionality
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeButton.selected = self.tweet.favorited;
    self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}
- (IBAction)didTapRetweet:(id)sender {
    // Update the local tweet model
    if(self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        // Update cell UI
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        // Update cell UI
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}
- (IBAction)didTapLike:(id)sender {
    // Update the local tweet model
    if(self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        // Update view UI
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        // Update view UI
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

-(void)refreshData {
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImage setImageWithURL:url];
    
    self.name.text = self.tweet.user.name;
    self.username.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.date.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    self.replyCount.text = @"0"; //no reply functionality
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeButton.selected = self.tweet.favorited;
    self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (IBAction)didTapBack:(UIButton *)sender {
    [self.delegate didUpdate:self.tweet];
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
