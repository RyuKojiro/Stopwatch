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

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)startStop:(id)sender {
	_running = !_running;
	self.startStopButton.title = _running ? @"Stop" : @"Start";
}

- (IBAction)split:(id)sender {
	
}

- (IBAction)reset:(id)sender {
	[_startTime release];
	_startTime = [[NSDate alloc] init];
}

@end
