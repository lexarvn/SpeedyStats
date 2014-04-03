//
//  PostJsonInteraction.h
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import <Foundation/Foundation.h>

//query keys
#define qkFunction @"function"

//response keys
#define rkSuccess @"success"
#define rkErrorKey @"errorKey"
#define rkErrorMessage @"errorMsg"

//query functions
#define qfLogin @"login"
#define qfGetUserInfo @"getAccountDetails"
#define qfIsLoggedIn @"loggedIn"

//error keys
#define ekBadLogin @"login"
#define ekNotAdmin @"admin"


@interface PostJsonInteraction : NSObject
+(NSDictionary*)queryWithDictionary:(NSDictionary*) outData;
@end
