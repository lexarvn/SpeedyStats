//
//  PostJsonInteraction.m
//  Speedy Stats
//
//  Created by Jeffrey Farb on 6/13/13.
//  Copyright (c) 2013 Jeffrey Farb. All rights reserved.
//

#import "PostJsonInteraction.h"

@implementation PostJsonInteraction
+(NSDictionary*)queryWithDictionary:(NSDictionary*) dict
{
    if([NSJSONSerialization isValidJSONObject:dict])
    {
        NSMutableString *requestString = [NSMutableString stringWithString:@""];
        NSString* formatString = @"%@=%@";
        BOOL first = YES;
        
        for (NSString* key in dict) {
            NSString* value = [dict objectForKey:key];
            
            [requestString appendFormat:formatString,key,value];
            
            if(first)
            {
                formatString = @"&%@=%@";
                first = NO;
            }
        }
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://afk.jfarb.com/php/ios-json.php"]];
        
//        NSLog(@"request: %@",requestString);
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[NSString stringWithFormat:@"%d", [requestString length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: [requestString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if(error)
        {
            NSLog(@"%@",error);
            if([error code] == -1009)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"This app can only run when connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            return nil;
        }
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"response %@",response);
        
        return response;
    }
    
    return nil;
}
@end
