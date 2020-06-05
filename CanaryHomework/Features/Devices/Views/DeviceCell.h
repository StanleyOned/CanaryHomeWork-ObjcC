//
//  DeviceCell.h
//  CanaryHomework
//
//  Created by Stanley Delacruz on 6/3/20.
//  Copyright © 2020 Michael Schroeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceCell : UITableViewCell

+ (NSString*)identifer;
- (void)configure:(Device *)device;

@end

NS_ASSUME_NONNULL_END
