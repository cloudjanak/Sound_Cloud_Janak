//
//  Manager.m
//  Queue
//
//  Created by Ketan Raval on 25/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

#import "Manager.h"
#import "Common.h"
#import "AFNetworking.h"
#import "Helper.h"

@implementation Manager
@synthesize dictUserData,strID;
+(id)sharedInstance{
    static Manager *objManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objManager = [[Manager alloc] init];
    });
    return objManager;
}
-(id)init{
    self = [super init];
    dictUserData = [[NSDictionary alloc] init];
    return self;
}
-(void)Authonticate:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock
{
    
    NSString *strRequestUrl = [KBaseURL stringByAppendingString:KToken];
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager POST:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);

        NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess > 0){
            _strToken = [dictResponse valueForKey:@"access_token"];
            pCompletionBlock(1);
        }
        else{
            pCompletionBlock(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}

-(void)getUserData:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    NSString *strRequestUrl = [KBaseURL stringByAppendingString:KGetUserData];
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        NSInteger intSuccess = [[dictResponse valueForKey:@"id"] integerValue];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess > 0){
            strID = [dictResponse valueForKey:@"id"];
            pCompletionBlock(1);
        }
        else{
            pCompletionBlock(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}

-(void)getActivities:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    NSString *strRequestUrl = [KBaseURL stringByAppendingString:KGetActivity];
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess > 0){
            _strToken = [dictResponse valueForKey:@"access_token"];
            pCompletionBlock(1);
        }
        else{
            pCompletionBlock(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}

-(void)getTrackList:(NSDictionary *)dictParam reqURL:(NSString *)strRequestUrl completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess > 0){
            _strToken = [dictResponse valueForKey:@"access_token"];
            pCompletionBlock(1);
        }
        else{
            pCompletionBlock(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}
-(void)getPlayList:(NSDictionary *)dictParam reqURL:(NSString *)strRequestUrl completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        NSLog(@"%ld",(long)intSuccess);
        if (intSuccess > 0){
            _strToken = [dictResponse valueForKey:@"access_token"];
            pCompletionBlock(1);
        }
        else{
            pCompletionBlock(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}
-(void)searchedTracks:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    NSString *strRequestUrl = [KBaseURL stringByAppendingString:KSearchTracks];
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        //NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        //NSLog(@"%ld",(long)intSuccess);
        //if (intSuccess > 0){
           // _strToken = [dictResponse valueForKey:@"access_token"];
            pCompletionBlock(1);
       // }
       // else{
            pCompletionBlock(0);
       // }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}

-(void)searchedPlayLists:(NSDictionary *)dictParam completionBlock:(ManagerCompletionBlock)pCompletionBlock{
    NSString *strRequestUrl = [KBaseURL stringByAppendingString:KSearchPlayLists];
    //[Helper showGlobalProgressHUDWithTitle:@"Loading"];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *operation = [operationManager GET:strRequestUrl parameters:dictParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[Helper dismissGlobalHUD];
        NSDictionary* dictResponse = [NSJSONSerialization
                                      JSONObjectWithData:operation.responseData //1
                                      options:kNilOptions
                                      error:nil];
        
        NSLog(@"%@",dictResponse);
        
        //NSInteger intSuccess = [[dictResponse valueForKey:@"access_token"] length];
        //NSLog(@"%ld",(long)intSuccess);
        //if (intSuccess > 0){
        // _strToken = [dictResponse valueForKey:@"access_token"];
        pCompletionBlock(1);
        // }
        // else{
        pCompletionBlock(0);
        // }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // [Helper dismissGlobalHUD];
        pCompletionBlock(NO);
        NSLog(@"Failed %@",operation.responseString);
    }];
    [operation start];
}
@end
