//  Hi, Dongjin
//  My second Commit
//  AppDelegate.h
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/22/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackendCommunicator.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>
#import "ViewController.h"
#import "eventsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) NSString* UserName;
@property (strong, atomic) NSString* HashedPassword;
@property (strong, atomic) NSString* userID;
//status: 0 - start first run
//status: 1 - logged in
//status: 2 - **
//others: ***
@property (atomic) int status;
-(IBAction) showAlertTitle:(NSString *)inputTitle Content:(NSString*)inputContent;
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(NSString *) HashStringSHA2:(NSString *)input;
-(void) loginWithUsername:(NSString *)userName Password:(NSString *)userPassword CallbackViewDelegate:(UIViewController*)viewD;
-(void) registerWithEmail:(NSString *)userName Name:(NSString*)nickName Password:(NSString*)userPassword Gender:(NSInteger)gender CallbackViewDelegate:(UIViewController *)viewDelegate;
-(void) retrieveEventListWithCallbackViewDelegate:(eventsViewController *) viewDelegate;
-(NSString*) isRegistrationSuccess:(ASIHTTPRequest*)request;
-(NSString*) isLoginSuccess:(ASIHTTPRequest*)request;
@end
