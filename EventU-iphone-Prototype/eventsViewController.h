//
//  eventsViewController.h
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/23/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eventsViewController : UITableViewController
{
    NSArray *events;
}

@property (nonatomic,retain) NSArray *events;

- (void)retrieveEventFailedWithMessage:(NSString*)message;
- (void)retrieveEventSucceededWithMessage:(NSString *)message Content:(NSArray*)array;
@end
