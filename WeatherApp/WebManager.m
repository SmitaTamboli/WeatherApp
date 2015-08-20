//
//  WebManager.m
//  BookDetail
//
//  Created by Dev5 on 05/06/14.
//  Copyright (c) 2014 filebound. All rights reserved.
//

#import "WebManager.h"
#import "ParsingManager.h"

@implementation WebManager{
    
    NSMutableData *jsonData;
}

- (void)makeConnection:(NSString *)searchText
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?q=%@&cnt=14&APPID=dd3546328de71c05810fc4c0e76cf1b9",searchText];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    jsonData = [[NSMutableData alloc] init];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error = nil;
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
     
    NSMutableDictionary *dictionaryJsonData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if(error)
    {
        NSLog(@"JSON Error : %@",[error localizedDescription]);
        if ([self.networkManagerDelegate respondsToSelector:@selector(handleData:withError:withErrorMessag:)]) {
            [self.networkManagerDelegate handleData:nil withError:error withErrorMessag:nil];
        }
    }
    else if (dictionaryJsonData.count == 2)
    {
        
        if ([self.networkManagerDelegate respondsToSelector:@selector(handleData:withError:withErrorMessag:)]) {
            [self.networkManagerDelegate handleData:nil withError:nil withErrorMessag:dictionaryJsonData[@"message"]];
        }
    }
    else {
        NSArray *itemArray = [dictionaryJsonData valueForKey:@"list"];
        
        ParsingManager *parsingManager = [[ParsingManager alloc] init];
        NSArray *weatherArray = [parsingManager parseData:itemArray];
        
        if ([self.networkManagerDelegate respondsToSelector:@selector(handleData:withError:withErrorMessag:)]) {
            [self.networkManagerDelegate handleData:weatherArray withError:nil withErrorMessag:nil];
        }
    }
}

@end
