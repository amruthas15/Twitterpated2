//
//  ComposeViewController.m
//  twitter
//
//  Created by Amrutha Srikanth on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *remainingCount;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.layer.borderWidth = 3;
    self.textView.clipsToBounds = YES;
    self.textView.layer.cornerRadius = 10.0f;
    self.textView.layer.borderColor = [UIColor colorWithRed:0.11 green:0.63 blue:0.95 alpha:1.00].CGColor;
    self.textView.delegate = self;
}

- (IBAction)closeButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)tweetButtonClicked:(UIBarButtonItem *)sender {
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            NSLog(@"😎😎😎 Successfully posted tweet");
            tweet.text = self.textView.text;
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

-(void)textViewDidChange:(UITextView *)textView {
    int remaining = 280 - textView.text.length;
    if(remaining < 0)
    {
        self.remainingCount.textColor = UIColor.redColor;
        self.remainingCount.text = [[@(-1 * remaining) stringValue] stringByAppendingString:@" Characters Over Limit"];
        self.tweetButton.enabled = FALSE;
        self.textView.layer.borderColor = UIColor.grayColor.CGColor;
    }
    else
    {
        self.remainingCount.textColor = UIColor.blackColor;
        self.textView.layer.borderColor = [UIColor colorWithRed:0.11 green:0.63 blue:0.95 alpha:1.00].CGColor;
        self.remainingCount.text = [[@(remaining) stringValue] stringByAppendingString:@" Characters Remaining"];
        self.tweetButton.enabled = TRUE;
    }
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
