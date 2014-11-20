//
//  StopWatchViewController.m
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController ()

@end

@implementation StopWatchViewController {
	BOOL _running;
	NSDate *_startTime;
	NSDate *_lastSplit;
	NSMutableArray *_splits;
}

- (void) dealloc {
	[_startTime release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	_running = NO;
}

- (void) _updateDisplay {
	NSTimeInterval totalTime = abs([_startTime timeIntervalSinceNow]);
	self.totalTimeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",
								(NSUInteger)(totalTime / 360) % 60,	// H
								(NSUInteger)(totalTime / 60) % 60,	// M
								(NSUInteger)totalTime % 60];		// S
	
	NSTimeInterval splitTime = abs([_lastSplit timeIntervalSinceNow]);
	self.splitTimeLabel.text = [NSString stringWithFormat:@"Δ %02lu:%02lu:%02lu",
								(NSUInteger)(splitTime / 360) % 60,	// H
								(NSUInteger)(splitTime / 60) % 60,	// M
								(NSUInteger)splitTime % 60];		// S
	
	if (_running) {
		[self performSelector:_cmd withObject:nil afterDelay:1.0f];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)startStop:(id)sender {
	if (!_startTime) {
		[self reset:sender];
	}
	
	_running = !_running;
	self.startStopButton.title = _running ? @"Stop" : @"Start";
	
	if (_running) {
		[self _updateDisplay];
	}
}

- (IBAction)split:(id)sender {
	
}

- (IBAction)reset:(id)sender {
	_running = NO;
	self.startStopButton.title = @"Start";

	[_startTime release];
	_startTime = [[NSDate alloc] init];
	
	[_lastSplit release];
	_lastSplit = [[NSDate alloc] init];

	self.totalTimeLabel.text = @"00:00:00";
	self.splitTimeLabel.text = @"Δ 00:00:00";
}

@end
