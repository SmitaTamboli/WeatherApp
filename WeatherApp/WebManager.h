//
//  WebManager.h
//  BookDetail
//
//  Created by Dev5 on 05/06/14.
//  Copyright (c) 2014 filebound. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkManagerDelegate <NSObject>

- (void)handleData:(NSArray*)data withError:(NSError *)error withErrorMessag:(NSString *)errorMessage;

@end

@interface WebManager : NSObject <NSURLConnectionDataDelegate>

@property (assign, nonatomic) id<NetworkManagerDelegate> networkManagerDelegate;
- (void)makeConnection:(NSString *)searchText;

@end
