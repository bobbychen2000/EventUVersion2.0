//
//  eventsViewController.h
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/23/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackendCommunicator.h"
#import "AppDelegate.h"

@interface EventViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *events;
}

@property (nonatomic,retain) NSArray *events;

- (void)retrieveEventFailedWithMessage:(NSString*)message;
- (void)retrieveEventSucceededWithMessage:(NSString *)message Content:(NSArray*)array;
@end
