# Project 3 - Twitterpated

Twitterpated is a basic twitter app to read and compose tweets using the [Twitter API](https://apps.twitter.com/).

Time spent: 20 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User sees app icon in home screen and styled launch screen
- [X] User can sign in using OAuth login flow
- [X] User can Logout
- [X] User can view last 20 tweets from their home timeline
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] User can pull to refresh.
- [X] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [X] User should display the relative timestamp for each tweet "8m", "7h"
- [X] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.

The following **optional** features are implemented:

- [ ] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ ] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [X] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [X] Countdown for characters in compose page disables tweeting option if the tweet exceeds the 280 character limit and offers visual cues to user that they should reduce their character count

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to embed images in a cell/view
2. How to hide views and show them only when wanted

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://imgur.com/a/KCA3lNp.gif' title='Video Walkthrough Pt.1' width='' alt='Video Walkthrough Pt.1: logging in and out and retweeting/liking functionality' /> Link to Video Walkthrough gif also at https://imgur.com/a/KCA3lNp.gif

<img src='https://imgur.com/a/JGgQnza.gif' title='Video Walkthrough Pt.2' width='' alt='Video Walkthrough Pt.2: pull to refresh and compose features' /> Link to Video Walkthrough gif also at https://imgur.com/a/JGgQnza.gif

<img src='https://imgur.com/a/qFK7y3z.gif' title='Video Walkthrough Pt.3' width='' alt='Video Walkthrough Pt.3: Autolayout comparisons' /> Link to Video Walkthrough gif also at https://imgur.com/a/qFK7y3z.gif

GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

It was difficult to understand the delegate concept, but walking through it in class with the added metaphors and examples really helped me understand the concept better. I had to redo parts of the autolayout section a few times to fully understand it because of its complexity, but I figured it out in the end.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date formatting library


## License

    Copyright [2021] [Amrutha Srikanth]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
