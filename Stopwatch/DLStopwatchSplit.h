//
//  DLStopwatchSplit.h
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLStopwatchSplit : NSObject

@property (retain) NSDate *start;
@property (retain) NSDate *end;
@property (retain) NSDate *reference;

- (NSTimeInterval) duration;
- (NSTimeInterval) timeIntervalSinceReferenceDate;

+ (NSString *) threePartStringForInterval:(NSTimeInterval)interval;
+ (NSString *) precisionStringForInterval:(NSTimeInterval)interval;

@end
