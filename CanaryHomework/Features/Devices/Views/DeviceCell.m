//
//  DeviceCell.m
//  CanaryHomework
//
//  Created by Stanley Delacruz on 6/3/20.
//  Copyright © 2020 Michael Schroeder. All rights reserved.
//

#import "DeviceCell.h"
#import "DateFormatter.h"

@interface DeviceCell ()

@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UILabel *subtitleLabel;
@property(nonatomic, retain) UILabel *dateLabel;

@end

@implementation DeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupComponents];
        [self layoutComponents];
    }
    return self;
}

+ (NSString *)identifer {
    return @"kDeviceCell";
}

- (void)configure:(Device *)device {
    self.titleLabel.text = device.name;
    if (device.type) {
        self.subtitleLabel.text = [NSString stringWithFormat:@"%@%@: %@", [[device.type substringToIndex:1] uppercaseString], [device.type substringFromIndex:1], device.value];
    }
    self.dateLabel.text = [[DateFormatter sharedFormatter] stringFromDate: device.createAt];
}

- (void)setupComponents {
    self.titleLabel = [UILabel new];
    self.subtitleLabel = [UILabel new];
    self.dateLabel = [UILabel new];
    
    self.titleLabel.textColor = [UIColor labelColor];
    self.subtitleLabel.textColor = [UIColor labelColor];
    self.dateLabel.textColor = [UIColor labelColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.dateLabel];
    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = false;

    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.subtitleLabel.font = [UIFont systemFontOfSize:16];
    self.dateLabel.font = [UIFont systemFontOfSize:16];
    
    self.dateLabel.textAlignment = NSTextAlignmentRight;
}

- (void)layoutComponents {
    [NSLayoutConstraint activateConstraints:@[
        
        [self.dateLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -8],
        [self.dateLabel.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor],

        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.dateLabel.leadingAnchor constant: -8],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant: 16],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant: 8],
        
        [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant: 0],
        [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant: 4],
        [self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant: 0],
        [self.subtitleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -8],
    ]];
}

@end
