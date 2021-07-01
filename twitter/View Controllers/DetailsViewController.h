//
//  DetailsViewController.h
//  twitter
//
//  Created by Amrutha Srikanth on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate

-(void)didUpdate: (Tweet *)tweet;

@end

@interface DetailsViewController : UIViewController
@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;

@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
