//
//  AppDelegate.m
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/22/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize UserName;
@synthesize HashedPassword;
@synthesize status;

//My functions, little bit messy now
-(IBAction) showAlertTitle:(NSString *)inputTitle Content:(NSString*)inputContent{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:inputTitle
                                                    message:inputContent
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(NSString *) HashStringSHA2:(NSString *)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return [NSString stringWithString:output];
}

-(void) loginWithUsername:(NSString *)userName Password:(NSString *)userPassword CallbackViewDelegate:(UIViewController*) viewD{
    NSString* hashedPassword = [self HashStringSHA2:userPassword];
    self.UserName = userName;
    self.HashedPassword = hashedPassword;
    [BackendCommunicator LoginAsynchronousWithName:userName Password:hashedPassword Timeout:1 CallbackViewDelegate:viewD];
}

-(void) registerWithEmail:(NSString *)userName Name:(NSString*)nickName Password:(NSString*)userPassword Gender:(NSInteger)gender CallbackViewDelegate:(UIViewController *)viewDelegate{
    NSString* hashedPassword = [self HashStringSHA2:userPassword];
    self.UserName = userName;
    self.HashedPassword = hashedPassword;
    [BackendCommunicator RegisterAsynchronousWithEmail:userName Password:hashedPassword NickName:nickName Gender:gender Timeout:1 CallbackViewDelegate:viewDelegate];
}


-(void) retrieveEventListWithCallbackViewDelegate:(eventsViewController *) viewDelegate{
    [BackendCommunicator RetrieveEventsAsynchronousWithCallbackViewDelegate:viewDelegate Timeout:10];
}












//other original stuff
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
