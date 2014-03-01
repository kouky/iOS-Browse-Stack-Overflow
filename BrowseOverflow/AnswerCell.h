//
//  AnswerCell.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 1/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptedIndicator;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UIImageView *personAvatar;
@property (weak, nonatomic) IBOutlet UIWebView *bodyWebView;

@end
