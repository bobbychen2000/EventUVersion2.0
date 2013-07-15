//
//  Util.h
//  EventU-iphone-Prototype
//
//  Created by Zhongbo Chen on 6/29/13.
//  Copyright (c) 2013 Dongjin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>

@interface Util : NSObject
-(IBAction) showAlertTitle:(NSString *)inputTitle Content:(NSString*)inputContent;
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(NSString *) HashStringSHA2:(NSString *)input;
@end
