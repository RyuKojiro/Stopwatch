//
//  StopWatchViewController.m
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import "StopWatchViewController.h"
#import "DLStopwatchSplit.h"

#define kSplitCellReuseIdentifier @"defaultCell"

@interface StopWatchViewController ()

@end

@implementation StopWatchViewController {
	BOOL _running;
	NSDate *_startTime;
	NSDate *_lastSplit;
	NSDate *_lastStop;
	NSMutableArray *_splits;
}

- (void) dealloc {
	[_lastStop release];
	[_lastSplit release];
	[_splits release];
	[_startTime release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	_running = NO;
	
	_splits = [[NSMutableArray alloc] init];
}

- (void) _updateDisplay {
	NSTimeInterval totalTime = abs([_startTime timeIntervalSinceNow]);
	self.totalTimeLabel.text = [DLStopwatchSplit threePartStringForInterval:totalTime];
	
	NSTimeInterval splitTime = abs([_lastSplit timeIntervalSinceNow]);
	self.splitTimeLabel.text = [@"Δ " stringByAppendingString:[DLStopwatchSplit threePartStringForInterval:splitTime]];
	if (_running) {
		[self performSelector:_cmd withObject:nil afterDelay:0.1f]; // 10 updates per second so that strangely offset splits update more accurately
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) updateUIForStartness {
	self.startStopButton.title = _running ? @"Stop" : @"Start";
	self.splitButton.enabled = _running;
}

- (IBAction)startStop:(id)sender {
	if (!_startTime) {
		_startTime = [[NSDate alloc] init];
		
		// Just in case
		[_lastSplit release];

		_lastSplit = [[NSDate alloc] init];
		
		// This means the start and stop are no longer associated
		[_lastStop release];
		_lastStop = nil;
	}
	
	_running = !_running;
	[self updateUIForStartness];
	
	if (_running) {
		if (_lastStop) {
			NSTimeInterval stoppedDuration = [[NSDate date] timeIntervalSinceDate:_lastStop];
			
			NSDate *tmp = _startTime;
			_startTime = [[_startTime dateByAddingTimeInterval:stoppedDuration] retain];
			[tmp release];
			
			tmp = _lastSplit;
			_lastSplit = [[_lastSplit dateByAddingTimeInterval:stoppedDuration] retain];
			[tmp release];
		}
		
		[self _updateDisplay];
	}
	else {
		_lastStop = [[NSDate alloc] init];
	}
}

- (IBAction)split:(id)sender {
	DLStopwatchSplit *newSplit = [[DLStopwatchSplit alloc] init];
	
	newSplit.start = _lastSplit;
	newSplit.end = [NSDate date];
	newSplit.reference = _startTime;
	
	[_splits insertObject:newSplit atIndex:0];
	[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	[newSplit release];
	
	[_lastSplit release];
	_lastSplit = [[NSDate alloc] init];
	
	self.splitTimeLabel.text = @"Δ 00:00:00";
}

- (IBAction)reset:(id)sender {
	_running = NO;
	[self updateUIForStartness];

	[_startTime release];
	_startTime = nil;
	
	[_lastSplit release];
	_lastSplit = nil;

	[_splits removeAllObjects];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
				  withRowAnimation:UITableViewRowAnimationLeft];
	
	self.totalTimeLabel.text = @"00:00:00";
	self.splitTimeLabel.text = @"Δ 00:00:00";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_splits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSplitCellReuseIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSplitCellReuseIdentifier] autorelease];
	}
	
	NSTimeInterval splitTime = [(DLStopwatchSplit *)_splits[indexPath.row] duration];
	cell.textLabel.text = [@"Δ " stringByAppendingString:[DLStopwatchSplit precisionStringForInterval:splitTime]];
	
	NSTimeInterval totalTime = [(DLStopwatchSplit *)_splits[indexPath.row] timeIntervalSinceReferenceDate];
	cell.detailTextLabel.text = [@"Σ " stringByAppendingString:[DLStopwatchSplit precisionStringForInterval:totalTime]];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
		[_splits removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end
