//
//  DLStopwatchSplit.m
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import "DLStopwatchSplit.h"

@implementation DLStopwatchSplit

+ (NSString *) threePartStringForInterval:(NSTimeInterval)interval {
	return [NSString stringWithFormat:@"%02lu:%02lu:%02lu",
										(NSUInteger)(interval / 360) % 60,	// H
										(NSUInteger)(interval / 60) % 60,	// M
										(NSUInteger)interval % 60];			// S
}

- (NSTimeInterval) duration {
	return [self.end timeIntervalSinceDate:self.start];
}

@end
