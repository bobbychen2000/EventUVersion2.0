//
//  joinViewController.h
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/22/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface joinViewController : UIViewController{
UIActivityIndicatorView * activityView;
UIView *loadingView;
UILabel *loadingLabel;
}
@property (strong, nonatomic) UIActivityIndicatorView * activityView;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *PasswordConfirm;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Gender;
- (IBAction)Register:(id)sender;
- (void)requestFinished:(ASIHTTPRequest*)request;
- (void)requestFailed:(ASIHTTPRequest*)request;

@end
