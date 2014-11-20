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
	return [NSString stringWithFormat:@"%02u:%02u:%02u",
										(unsigned int)(interval / 360) % 60,	// H
										(unsigned int)(interval / 60) % 60,	// M
										(unsigned int)interval % 60];			// S
}

+ (NSString *) precisionStringForInterval:(NSTimeInterval)interval {
	return [NSString stringWithFormat:@"%02u:%02u:%02u.%03u",
			(unsigned int)(interval / 360) % 60,		// H
			(unsigned int)(interval / 60) % 60,		// M
			(unsigned int)interval % 60,				// S
			(unsigned int)(interval * 1000) % 1000];	// ms
}

- (NSTimeInterval) duration {
	return [self.end timeIntervalSinceDate:self.start];
}

- (NSTimeInterval) timeIntervalSinceReferenceDate {
	return [self.end timeIntervalSinceDate:self.reference];
}

@end
