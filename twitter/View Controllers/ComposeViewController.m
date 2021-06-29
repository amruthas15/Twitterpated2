//
//  ComposeViewController.m
//  twitter
//
//  Created by Amrutha Srikanth on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)closeButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)tweetButtonClicked:(UIBarButtonItem *)sender {
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            NSLog(@"😎😎😎 Successfully posted tweet");
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
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
