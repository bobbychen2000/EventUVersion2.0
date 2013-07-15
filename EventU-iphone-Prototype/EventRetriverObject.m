//
//  EventRetriverObject.m
//  EventU-iphone-Prototype
//
//  Created by Zhongbo Chen on 7/14/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "EventRetriverObject.h"

@implementation EventRetriverObject 
@synthesize callBackViewController = _callBackViewController;
@synthesize locationManager = _locationManager;
@synthesize flag = _flag;

- (id)init{
        _locationManager = [[CLLocationManager alloc] init];
        return self;
    }

/*
 *THIS ENTIRE CALLING STACK IS NOT THREAD-SAFE, IT DOES NOT SUPPORT REENTRANT CALLS
 */
- (void) RetrieveEventsAsynchronousWithCallbackViewDelegate:(eventsViewController*)viewD Timeout:(int64_t)timeout{
    _callBackViewController = viewD;
    _locationManager.delegate=self;
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    _locationManager.distanceFilter=kCLDistanceFilterNone;
    [_locationManager startUpdatingLocation];
    [_locationManager performSelector:@selector(stopUpdatingLocation:) withObject:@"TimedOut" afterDelay:30];
}

- (void)locationManager:(CLLocationManager *) manager didUpdateLocations:(NSArray*)locations{
    NSLog(@"UPDATE LOCATION SUCCESSFUL");
    [manager stopUpdatingLocation];
    CLLocation * location = [locations lastObject];
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", location.coordinate.latitude];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%f", location.coordinate.longitude];
    [self requestEventListFromBackendWithLatitude:latitude Longtitude:longitude Delegate:self Timeout:3];
}

- (void)locationManager:(CLLocationManager *) manager didFailWithError:(NSError*) error{
    NSLog(@"UPDATE LOCATION FAILED WITH ERROR: %@", [error localizedDescription]);
    [manager stopUpdatingLocation];
    [_callBackViewController retrieveEventFailedWithMessage:@"update Location Failed with Error"];
}

- (void)locationManager:(CLLocationManager *) manager didFinishDeferredUpdatesWithError:(NSError*) error{
    NSLog(@"UPDATE LOCATION DEFFERRED WITH ERROR: %@", [error localizedDescription]);
    [manager stopUpdatingLocation];
    [_callBackViewController retrieveEventFailedWithMessage:@"update Location DEFFERED Failed with Error"];
}

- (void)requestEventListFromBackendWithLatitude:(NSString*)latitude Longtitude:(NSString*)longtitude Delegate:(EventRetriverObject*)delegate Timeout:(int64_t)timeout{
    NSLog(@"Location data is Latitude: %@, Longtitude: %@", latitude, longtitude);
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.0.3:8080/UServer-1/Gateway"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"getEvent", @"action", longtitude, @"longtitude", latitude, @"latitude", nil];
    NSString *requestJson = [jsonDictionary JSONRepresentation];
    NSData * requestData_ = [requestJson dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/TESTING"];
    [request addRequestHeader:@"User-Agent" value:@"Iphone"];
    [request appendPostData:requestData_];
    [request setTimeOutSeconds:timeout];
    [request setDelegate:delegate];
    [request startAsynchronous];
  }
                           
- (void)requestFinished:(ASIHTTPRequest*)request{
    [_callBackViewController retrieveEventSucceededWithMessage:@"GET EVENTS Succeeded" Content:nil];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
    [_callBackViewController retrieveEventFailedWithMessage:@"NETWORK Failed with Error"];
}

                           
@end
