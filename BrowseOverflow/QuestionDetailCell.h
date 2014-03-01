//
//  QuestionDetailCell.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 1/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIWebView *bodyWebView;

@end
