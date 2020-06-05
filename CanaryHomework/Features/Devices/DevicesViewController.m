//
//  ViewController.m
//  CanaryHomework
//
//  Created by Michael Schroeder on 9/19/19.
//  Copyright © 2019 Michael Schroeder. All rights reserved.
//

#import "CoreDataController.h"
#import "DevicesViewController.h"
#import "DetailViewController.h"
#import "Device+CoreDataProperties.h"
#import "DeviceCell.h"
#import "Device+Retrieval.h"

@interface DevicesViewController ()

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UIActivityIndicatorView *indicator;
@property(nonatomic, retain) NSArray<Device *> *devices;
@property(nonatomic, retain) UILayoutGuide *safeArea;

@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Devices";
    
    self.safeArea = self.view.layoutMarginsGuide;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    [self setupTableView];
    [self fetchDevices];
}

- (void)setupTableView {
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.tableView];
    [[self.tableView.topAnchor constraintEqualToAnchor:self.safeArea.topAnchor] setActive:true];
    [[self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:true];
    [[self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:true];
    [[self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:true];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[DeviceCell class] forCellReuseIdentifier:[DeviceCell identifer]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)fetchDevices {
    [self.indicator startAnimating];
    [[CoreDataController sharedCache] getAllDevices:^(BOOL completed, BOOL success, NSArray * _Nonnull objects) {
        [self.indicator stopAnimating];
        if (success) {
            self.devices = objects;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DeviceCell *cell  = [tableView dequeueReusableCellWithIdentifier:[DeviceCell identifer] forIndexPath:indexPath];
    Device *device = self.devices[indexPath.row];
    [cell configure: device];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark UITableView Delegate 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Device *device = self.devices[indexPath.row];
    DetailViewController *dc = [[DetailViewController alloc] initWithDeviceID:device.deviceID];
    [self.navigationController pushViewController:dc animated:YES];
}

@end
