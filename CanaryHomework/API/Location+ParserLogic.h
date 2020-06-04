//
//  Location+ParserLogic.h
//  Canary
//
//  Created by Andrew Whitcomb on 5/13/15.
//  Copyright (c) 2015 Michael Klein. All rights reserved.
//

#import "Location.h"

@interface Location (ParserLogic)

+ (Location *)locationFromDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
