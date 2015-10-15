//
//  Manager.h
//  Queue
//
//  Created by Ketan Raval on 25/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ManagerCompletionBlock)(BOOL success);
typedef void(^ManagerCompletionBlock)(BOOL success);
typedef void(^TokenCompletion)(NSString *);

@interface Manager : NSObject

+(id)sharedInstance;

@property (strong , nonatomic) NSString *strToken;
@property (strong , nonatomic) NSString *strID;
@property (strong , nonatomic) NSDictionary *dictUserData;
/*====METHODS====*/
-(void)Authonticate:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)getUserData:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)getActivities:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)getTrackList:(NSDictionary *)dictParam reqURL:(NSString *)strRequestUrl completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)getPlayList:(NSDictionary *)dictParam reqURL:(NSString *)strRequestUrl completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)searchedTracks:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock;

-(void)searchedPlayLists:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock;
@end
