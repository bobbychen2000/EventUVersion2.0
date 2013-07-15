//
//  BackendCommunicator.m
//  EventU-iphone-Prototype
//
//  Created by Zhongbo Chen on 6/25/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "BackendCommunicator.h"

@interface BackendCommunicator()

@end

static EventRetriverObject* ERO;

@implementation BackendCommunicator

+ (void)initialize{
    ERO = [[EventRetriverObject alloc] init];
}

+ (void)LoginAsynchronousWithName:(NSString* )userName Password:(NSString*) passWord Timeout:(int64_t)timeout CallbackViewDelegate:(UIViewController*)viewD{
    NSLog(@"NAME: %@, PASSWORD: %@", userName, passWord);
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.0.3:8080/UServer-1/Gateway"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"login", @"action", userName, @"userEmail", passWord, @"password", nil];
    NSString *requestJson = [jsonDictionary JSONRepresentation];
    NSData * requestData_ = [requestJson dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/TESTING"];
    [request addRequestHeader:@"User-Agent" value:@"Iphone"];
    [request appendPostData:requestData_];
    [request setTimeOutSeconds:timeout];
    [request setDelegate:viewD];
    [request startAsynchronous];
}

+ (void)RegisterAsynchronousWithEmail:(NSString* )userName Password:(NSString*)passWord NickName:(NSString*)nickName Gender:(NSInteger)gender Timeout:(int64_t)timeout CallbackViewDelegate:(UIViewController*) viewD{
    NSLog(@"NAME: %@, PASSWORD: %@, NICKN: %@", userName, passWord, nickName);
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.0.3:8080/UServer-1/Gateway"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"register", @"action", userName, @"userEmail", passWord, @"password", nil];
    NSString *requestJson = [jsonDictionary JSONRepresentation];
    NSData * requestData_ = [requestJson dataUsingEncoding:NSUTF8StringEncoding];
        
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/TESTING"];
    [request addRequestHeader:@"User-Agent" value:@"Iphone"];
    [request appendPostData:requestData_];
    [request setTimeOutSeconds:timeout];
    [request setDelegate:viewD];
    [request startAsynchronous];
}

/**
 *THIS ENTIRE ACTION STACK IS NOT REENTRANT, NOT JUST THIS METHOD
 */
+ (void)RetrieveEventsAsynchronousWithCallbackViewDelegate:(eventsViewController*)viewD Timeout:(int64_t)timeout{
    [ERO RetrieveEventsAsynchronousWithCallbackViewDelegate:viewD Timeout:timeout];
}

@end
