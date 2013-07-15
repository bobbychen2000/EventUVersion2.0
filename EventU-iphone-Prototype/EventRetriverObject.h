//
//  EventRetriverObject.h
//  EventU-iphone-Prototype
//
//  Created by Zhongbo Chen on 7/14/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BackendCommunicator.h"
#import <CoreLocation/CoreLocation.h>
#import "EventBrief.h"
@class EventViewController;

@interface EventRetriverObject : NSObject <CLLocationManagerDelegate>{
    EventViewController* callBackViewController;
    CLLocationManager* locationManager;
    boolean_t flag;
}
@property(atomic, strong) EventViewController* callBackViewController;
@property(atomic, strong) CLLocationManager* locationManager;
@property(atomic) boolean_t flag;

- (void)RetrieveEventsAsynchronousWithCallbackViewDelegate:(EventViewController *)viewD Timeout:(int64_t)timeout;
- (void)locationManager:(CLLocationManager *) manager didUpdateLocations:(NSArray*)locations;
- (void)locationManager:(CLLocationManager *) manager didFailWithError:(NSError*) error;
- (void)locationManager:(CLLocationManager *) manager didFinishDeferredUpdatesWithError:(NSError*) error;
- (void)requestEventListFromBackendWithLatitude:(NSString*)latitude Longtitude:(NSString*)longtitude Delegate:(EventRetriverObject*)delegate Timeout:(int64_t)timeout;
- (void)requestFinished:(ASIHTTPRequest*)request;
- (void)requestFailed:(ASIHTTPRequest*)request;

@end
