//
//  afterLoginTabViewController.m
//  EventU-iphone-Prototype
//
//  Created by Dongjin Wang on 6/23/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import "afterLoginTabViewController.h"

@interface afterLoginTabViewController ()

@end

@implementation afterLoginTabViewController

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
	// Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logoutButton:(id)sender{
    NSLog(@"LOGGING OUT");
     [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
