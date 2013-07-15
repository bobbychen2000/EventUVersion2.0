//
//  BackendCommunicator.h
//  EventU-iphone-Prototype
//
//  Created by Zhongbo Chen on 6/25/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "NSObject+SBJson.h"
#import <Foundation/Foundation.h>
#import "JoinViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "EventRetriverObject.h"

static EventRetriverObject* ERO;

@interface BackendCommunicator : NSObject

+ (void)initialize;

+ (void)LoginAsynchronousWithName:(NSString* )userName Password:(NSString*)passWord Timeout:(int64_t)timeout CallbackViewDelegate:(UIViewController*) viewD;

+ (void)RegisterAsynchronousWithEmail:(NSString* )userName Password:(NSString*)passWord NickName:(NSString*)nickName Gender:(NSInteger)gender Timeout:(int64_t)timeout CallbackViewDelegate:(UIViewController*) viewD;

+ (void)RetrieveEventsAsynchronousWithCallbackViewDelegate:(eventsViewController*)viewD Timeout:(int64_t)timeout;

@end
