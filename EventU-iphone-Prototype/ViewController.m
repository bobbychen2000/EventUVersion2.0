//
//  ViewController.m
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/22/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize activityView=_activityView;
@synthesize loadingLabel=_loadingLabel;
@synthesize loadingView=_loadingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [BackendCommunicator initialize];
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius=10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    [loadingView addSubview:loadingLabel];
    
    NSLog(@"IN VIEW DID LOAD");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    
    NSLog(@"In login action handler, Name:%@, Password:%@", self.Name.text, self.Password.text);
    
    if(self.Name.text==nil||self.Password.text==nil)
        return;
    
    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    BOOL ret = [myAppDelegate NSStringIsValidEmail:self.Name.text];
    if(ret && self.Password!=nil && [self.Password.text length]>=8){
        
        [self.view addSubview:loadingView];
        self.view.userInteractionEnabled=FALSE;
        self.navigationController.view.userInteractionEnabled=FALSE;
        [activityView startAnimating];

        [myAppDelegate loginWithUsername:self.Name.text Password:self.Password.text CallbackViewDelegate:self];
        
        return;
    }
    
    [myAppDelegate showAlertTitle:@"Invalid Username or Password" Content:@"UserName or Password is not correct, Please check again."];
}

- (IBAction)Join:(id)sender {
    NSLog(@"In join action handler");
    [self performSegueWithIdentifier:@"JoinSegue" sender:self];
}

- (IBAction)TextFieldExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(IBAction) backgroundTap:(id) sender{
    [sender resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"In prepare for segue from Main to JOIN/LOGIN");
}

- (void)requestFailed:(ASIHTTPRequest*)request{
    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    myAppDelegate.UserName = nil;
    myAppDelegate.HashedPassword = nil;
    
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    [myAppDelegate showAlertTitle:@"Login Failed" Content:@"Please check your username and password again"];
    self.view.userInteractionEnabled=TRUE;
    self.navigationController.view.userInteractionEnabled=TRUE;
    
    return;
}

- (void)requestFinished:(ASIHTTPRequest*)request{
    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    [myAppDelegate showAlertTitle:@"Login Successful" Content:@"Welcome back!"];
    self.view.userInteractionEnabled=TRUE;
    self.navigationController.view.userInteractionEnabled=TRUE;
    
    [self performSegueWithIdentifier:@"LoginSegue" sender:self];
    return;

}

@end
