//
//  DLStopwatchSplit.m
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import "DLStopwatchSplit.h"

@implementation DLStopwatchSplit

- (NSTimeInterval) duration {
	return [self.end timeIntervalSinceDate:self.start];
}

@end
