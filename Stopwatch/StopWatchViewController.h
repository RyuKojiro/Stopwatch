//
//  StopWatchViewController.h
//  Stopwatch
//
//  Created by Daniel Loffgren on 11/19/14.
//  Copyright (c) 2014 Daniel Loffgren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopWatchViewController : UIViewController

@property (assign) IBOutlet UILabel *totalTimeLabel;
@property (assign) IBOutlet UILabel *splitTimeLabel;
@property (assign) IBOutlet UIBarButtonItem *startStopButton;

- (IBAction)startStop:(id)sender;
- (IBAction)split:(id)sender;
- (IBAction)reset:(id)sender;

@end

