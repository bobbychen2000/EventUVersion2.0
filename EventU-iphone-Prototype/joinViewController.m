//
//  joinViewController.m
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/22/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "joinViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface joinViewController ()

@end

@implementation joinViewController
@synthesize activityView=_activityView;
@synthesize loadingLabel=_loadingLabel;
@synthesize loadingView=_loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)TextFieldExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(IBAction) backgroundTap:(id) sender{
    [sender resignFirstResponder];
}

- (IBAction)Register:(id)sender {
    NSLog(@"In register action handler, Email:%@, Name:%@, Password: %@, CON PASS: %@, GENDER: %@", self.Email.text, self.Name.text, self.Password.text, self.PasswordConfirm.text, [NSString stringWithFormat:@"%i", self.Gender.selectedSegmentIndex] );
            
    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if(self.Email.text==nil||self.Name.text==nil||self.Password.text==nil||self.PasswordConfirm.text==nil){
        [myAppDelegate showAlertTitle:@"Content Incomplete" Content:@"Please enter all required fills"];
        return;
    }
    
    BOOL isEmail = [myAppDelegate NSStringIsValidEmail:self.Email.text];
    
    if(!isEmail){
        [myAppDelegate showAlertTitle:@"Invalid Email" Content:@"Please enter a valid email address"];
        return;
    }
    
    if(![self.Password.text isEqualToString:self.PasswordConfirm.text]){
        [myAppDelegate showAlertTitle:@"Password Inconsistent" Content:@"Please enter the same password twice"];
        return;
    }
    
    if([self.PasswordConfirm.text length]<8){
        [myAppDelegate showAlertTitle:@"Password Length" Content:@"Please enter the password with length >=8"];
        return;
    }
    
    if([self.Name.text length]<4){
        [myAppDelegate showAlertTitle:@"Name Length" Content:@"Please enter the name with length >=4"];
        return;
    }
    
    [self.view addSubview:loadingView];
    self.view.userInteractionEnabled=FALSE;
    self.navigationController.view.userInteractionEnabled=FALSE;
    
    [activityView startAnimating];
    
    [myAppDelegate registerWithEmail:self.Email.text Name:self.Name.text Password:self.Password.text Gender:self.Gender.selectedSegmentIndex
                                   CallbackViewDelegate:self];
        
    return;
}


-(void)requestFailed:(ASIHTTPRequest *)request{

    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    myAppDelegate.UserName = nil;
    myAppDelegate.HashedPassword = nil;
    
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    [myAppDelegate showAlertTitle:@"Registration Failed" Content:@"Don't want to provide detailed info now, PLEASE RETRY"];
    self.view.userInteractionEnabled=TRUE;
    self.navigationController.view.userInteractionEnabled=TRUE;

    return;
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    AppDelegate* myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    [myAppDelegate showAlertTitle:@"Registration Successful" Content:@"Welcome!"];
    self.view.userInteractionEnabled=TRUE;
    self.navigationController.view.userInteractionEnabled=TRUE;
    
    [self performSegueWithIdentifier:@"JoinToLoginSegue" sender:self];
    return;
}


@end
