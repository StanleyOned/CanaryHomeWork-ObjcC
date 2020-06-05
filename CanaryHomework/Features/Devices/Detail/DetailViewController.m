//
//  DetailViewController.m
//  CanaryHomework
//
//  Created by Michael Schroeder on 9/24/19.
//  Copyright © 2019 Michael Schroeder. All rights reserved.
//

#import "CoreDataController.h"
#import "DetailViewController.h"
#import "Device+CoreDataProperties.h"
#import "Reading+CoreDataProperties.h"

@interface DetailViewController ()

@property(nonatomic, retain) UILabel *airQualityTitleLabel;
@property(nonatomic, retain) UILabel *airQualityMinLabel;
@property(nonatomic, retain) UILabel *airQualityMaxLabel;
@property(nonatomic, retain) UILabel *airQualityAverageLabel;

@property(nonatomic, retain) UILabel *humidityTitleLabel;
@property(nonatomic, retain) UILabel *humidityMinLabel;
@property(nonatomic, retain) UILabel *humidityMaxLabel;
@property(nonatomic, retain) UILabel *humidityAverageLabel;

@property(nonatomic, retain) UILabel *temperatureTitleLabel;
@property(nonatomic, retain) UILabel *temperatureMinLabel;
@property(nonatomic, retain) UILabel *temperatureMaxLabel;
@property(nonatomic, retain) UILabel *temperatureAverageLabel;

@property(nonatomic, retain) UIStackView *airQualityStackView;
@property(nonatomic, retain) UIStackView *humidityStackView;
@property(nonatomic, retain) UIStackView *temperatureStackView;

@property(nonatomic, retain) UIActivityIndicatorView *indicator;

@property(nonatomic, retain) NSMutableArray<NSNumber *> *airQualities;
@property(nonatomic, retain) NSMutableArray<NSNumber *> *humidities;
@property(nonatomic, retain) NSMutableArray<NSNumber *> *temperatures;

@property (nonatomic, strong) NSLayoutConstraint *airQualityTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *humidityTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *temperatureTopConstraint;


@end

@implementation DetailViewController

- (id)initWithDeviceID:(NSString *)deviceID {
    
    self = [super init];
    if (self) {
        self.deviceID = deviceID;
        self.airQualities = [NSMutableArray new];
        self.humidities = [NSMutableArray new];
        self.temperatures = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"About Device";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    [self setupComponents];
    [self fetchDevices];
}

- (void)fetchDevices {
    [self.indicator startAnimating];
    [[CoreDataController sharedCache] getReadingsForDevice:self.deviceID completionBlock:^(BOOL completed, BOOL success, NSArray * _Nonnull objects) {
        [self.indicator stopAnimating];
        if (success) {
            self.readings = objects;
            [self updateData];
        }
    }];
}

- (void)updateData {
    
    for (int i = 0; i < self.readings.count; i++)
    {
        Reading *reading = self.readings[i];
        if ([reading.type isEqualToString:@"airquality"]) {
            [self.airQualities addObject: reading.value];
        }
        
        if ([reading.type isEqualToString:@"temperature"]) {
            [self.humidities addObject: reading.value];
        }
        
        if ([reading.type isEqualToString:@"humidity"]) {
            [self.temperatures addObject: reading.value];
        }
    }
    NSNumber *airqualityMax = [self.airQualities valueForKeyPath:@"@max.self"];
    NSNumber *airqualityMin = [self.airQualities valueForKeyPath:@"@min.self"];
    
    self.airQualityMinLabel.text = [NSString stringWithFormat:@"Min: %@", [airqualityMin stringValue]];
    self.airQualityMaxLabel.text = [NSString stringWithFormat:@"Max: %@", [airqualityMax stringValue]];
    
    NSNumber *humidityMin = [self.humidities valueForKeyPath:@"@min.self"];
    NSNumber *humidityMax = [self.humidities valueForKeyPath:@"@max.self"];
    
    self.humidityMinLabel.text = [NSString stringWithFormat:@"Min: %@", [humidityMin stringValue]];
    self.humidityMaxLabel.text = [NSString stringWithFormat:@"Max: %@", [humidityMax stringValue]];
        
    NSNumber *temperatureMin = [self.temperatures valueForKeyPath:@"@min.self"];
    NSNumber *temperatureMax = [self.temperatures valueForKeyPath:@"@max.self"];
    
    self.temperatureMinLabel.text = [NSString stringWithFormat:@"Min: %@", [temperatureMin stringValue]];
    self.temperatureMaxLabel.text = [NSString stringWithFormat:@"Max: %@", [temperatureMax stringValue]];
    
    NSNumber * airQualityAverage = [self.airQualities valueForKeyPath:@"@avg.self"];
    NSNumber * humidityAverage = [self.humidities valueForKeyPath:@"@avg.self"];
    NSNumber * temperatureAverage = [self.temperatures valueForKeyPath:@"@avg.self"];
    
    self.airQualityAverageLabel.text = [NSString stringWithFormat:@"Average: %@", [airQualityAverage stringValue]];
    self.temperatureAverageLabel.text = [NSString stringWithFormat:@"Average: %@", [temperatureAverage stringValue]];
    self.humidityAverageLabel.text = [NSString stringWithFormat:@"Average: %@", [humidityAverage stringValue]];
    
    CGFloat kPadding = 16.0;
    
    if ([self.airQualities count] == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [[self airQualityStackView] removeFromSuperview];
            self.humidityTopConstraint = [self.humidityStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kPadding];
            [self.humidityTopConstraint setActive:YES];
            [self.view layoutIfNeeded];
        }];
    }
    
    if ([self.humidities count] == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [[self humidityStackView] removeFromSuperview];
            if ([self.airQualities count] == 0) {
                self.temperatureTopConstraint = [self.temperatureStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kPadding];
                [self.temperatureTopConstraint setActive:YES];
            } else {
                self.temperatureTopConstraint = [self.temperatureStackView.topAnchor constraintEqualToAnchor:self.airQualityStackView.bottomAnchor constant:kPadding];
                [self.temperatureTopConstraint setActive:YES];
            }
            [self.view layoutIfNeeded];
        }];
    }
    
    if ([self.temperatures count] == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [[self temperatureStackView] removeFromSuperview];
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)buildLabels {
    self.airQualityTitleLabel = [UILabel new];
    self.airQualityMinLabel = [UILabel new];
    self.airQualityMaxLabel = [UILabel new];
    self.airQualityAverageLabel = [UILabel new];
    
    self.humidityTitleLabel = [UILabel new];
    self.humidityMinLabel = [UILabel new];
    self.humidityMaxLabel = [UILabel new];
    self.humidityAverageLabel = [UILabel new];
    
    self.temperatureTitleLabel = [UILabel new];
    self.temperatureMinLabel = [UILabel new];
    self.temperatureMaxLabel = [UILabel new];
    self.temperatureAverageLabel = [UILabel new];
    
    self.airQualityTitleLabel.textColor = [UIColor labelColor];
    self.airQualityMinLabel.textColor = [UIColor labelColor];
    self.airQualityMaxLabel.textColor = [UIColor labelColor];
    self.airQualityAverageLabel.textColor = [UIColor labelColor];
    
    self.humidityTitleLabel.textColor = [UIColor labelColor];
    self.humidityMinLabel.textColor = [UIColor labelColor];
    self.humidityMaxLabel.textColor = [UIColor labelColor];
    self.humidityAverageLabel.textColor = [UIColor labelColor];
    
    self.temperatureTitleLabel.textColor = [UIColor labelColor];
    self.temperatureMinLabel.textColor = [UIColor labelColor];
    self.temperatureMaxLabel.textColor = [UIColor labelColor];
    self.temperatureAverageLabel.textColor = [UIColor labelColor];
    
    self.airQualityTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.humidityTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.temperatureTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    self.airQualityTitleLabel.text = @"Airquality";
    self.humidityTitleLabel.text = @"Humidity";
    self.temperatureTitleLabel.text = @"Temperature";
}

- (void)setupComponents {
    
    [self buildLabels];
    
    self.airQualityStackView = [self buildStackViewWithTitleLabel:self.airQualityTitleLabel
                                                                 minLabel:self.airQualityMinLabel
                                                                 maxLabel:self.airQualityMaxLabel
                                                             averageLabel:self.airQualityAverageLabel];
    self.humidityStackView = [self buildStackViewWithTitleLabel:self.humidityTitleLabel
                                                               minLabel:self.humidityMinLabel
                                                               maxLabel:self.humidityMaxLabel
                                                           averageLabel:self.humidityAverageLabel];
    self.temperatureStackView = [self buildStackViewWithTitleLabel:self.temperatureTitleLabel
                                                                  minLabel:self.temperatureMinLabel
                                                                  maxLabel:self.temperatureMaxLabel
                                                              averageLabel:self.temperatureAverageLabel];
    CGFloat kPadding = 16.0;
    
    self.airQualityTopConstraint = [self.airQualityStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kPadding];
    self.humidityTopConstraint = [self.humidityStackView.topAnchor constraintEqualToAnchor:self.airQualityStackView.bottomAnchor constant:kPadding];
    self.temperatureTopConstraint = [self.temperatureStackView.topAnchor constraintEqualToAnchor:self.humidityStackView.bottomAnchor constant:kPadding];
    [NSLayoutConstraint activateConstraints:@[
        
        self.airQualityTopConstraint,
        [self.airQualityStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kPadding],
        [self.airQualityStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -kPadding],
        
        self.humidityTopConstraint,
        [self.humidityStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kPadding],
        [self.humidityStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -kPadding],
        
        self.temperatureTopConstraint,
        [self.temperatureStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kPadding],
        [self.temperatureStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -kPadding],
    ]];
}

- (UIStackView *)buildStackViewWithTitleLabel:(UILabel *)titleLabel minLabel:(UILabel *)minLabel maxLabel:(UILabel*)maxLabel averageLabel:(UILabel *)averageLabel {
    
    UIStackView *stackView = [UIStackView new];
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentLeading;
    stackView.spacing = 8;

    [stackView addArrangedSubview:titleLabel];
    [stackView addArrangedSubview:minLabel];
    [stackView addArrangedSubview:maxLabel];
    [stackView addArrangedSubview:averageLabel];
    
    [self.view addSubview:stackView];
    
    return stackView;
}


@end
