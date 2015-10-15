//
//  ViewController.m
//  UITest
//
//  Created by Ketan Raval on 22/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

#import "ViewController.h"

const CGFloat kViewGapDistance = 35.0;
@interface ViewController (){
     CGFloat _prevOriginY;
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    objMan = [Manager sharedInstance];
    [self configureTextFields];
}
- (IBAction)btnLoginClicked:(id)sender {
    [objMan Authonticate:[self setPostPara] completionBlock:^(BOOL success) {
        if(success){
            [Helper setNsuserValue:KAccessToken value:objMan.strToken];
            [Helper globalAlert:@"Successfully LoggedIN."];
        }else{
            [Helper globalAlert:@"Oppss Failed To LogIN."];
        }
    }];
}
- (IBAction)btnGetUserDataClicked:(id)sender {
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    
    [objMan getUserData:parameters completionBlock:^(BOOL success) {
            if(success){
                [Helper setNsuserValue:KAccessToken value:objMan.strToken];
                [Helper globalAlert:@"User data retrived successfully."];
            }else{
                [Helper globalAlert:@"Failed To retrivre user data."];
            }
        }];
}
- (IBAction)btnGetAcitivitiesClicked:(id)sender {
    /*===SOUND TRACKS===*/
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    [parameters setObject:[NSNumber numberWithInt:20] forKey:@"limit"];
    
    [objMan getActivities:parameters completionBlock:^(BOOL success) {
        if(success){
            [Helper setNsuserValue:KAccessToken value:objMan.strToken];
            [Helper globalAlert:@"Activity Retrived Successfully."];
        }else{
            [Helper globalAlert:@"Failed to retrive activity."];
        }
    }];

}
-(IBAction)btnPlayListTracks:(id)sender{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    [parameters setObject:[NSNumber numberWithInt:20] forKey:@"limit"];
    [parameters setObject:@"0" forKey:@"offset"];
    NSString *reqURL=@"https://api.soundcloud.com/playlists/148017914.json"; //148017914 == PlayListID
    [objMan getTrackList:parameters reqURL:reqURL completionBlock:^(BOOL success) {
        if(success){
        }else{
        }
    }];
}
-(IBAction)btnPlayList:(id)sender{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    [parameters setObject:[NSNumber numberWithInt:20] forKey:@"limit"];
    [parameters setObject:@"0" forKey:@"offset"];
    NSString *reqURL=@"https://api.soundcloud.com/playlists/148017914.json";
    [objMan getTrackList:parameters reqURL:reqURL completionBlock:^(BOOL success) {
        if(success){
        }else{
        }
    }];
}
-(IBAction)btnSearchQueryClicked:(id)sender{
    NSMutableDictionary * paramters = [[NSMutableDictionary alloc]init];
    [paramters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    [paramters setObject:@"Garba" forKey:@"q"];
    [paramters setObject:@"20" forKey:@"limit"];
    [paramters setObject:@"0" forKey:@"offset"];
    [objMan searchedTracks:paramters completionBlock:^(BOOL success) {
        if(success){
        }else{
        }
    }];
}

-(IBAction)btnSearchQueryPlayListsClicked:(id)sender{
    NSMutableDictionary * paramters = [[NSMutableDictionary alloc]init];
    [paramters setValue:[Helper getNsuserValue:KAccessToken] forKey:@"oauth_token"];
    [paramters setObject:@"sad songs" forKey:@"q"];
    [paramters setObject:@"20" forKey:@"limit"];
    [paramters setObject:@"0" forKey:@"offset"];
    [objMan searchedPlayLists:paramters completionBlock:^(BOOL success) {
        if(success){
        }else{
        }
    }];
}
-(NSMutableDictionary*)setPostPara{
    post = [[NSMutableDictionary alloc] init];
    [post setValue:KCLIENT_ID forKey:@"client_id"];
    [post setValue:KCLIENT_SECRET forKey:@"client_secret"];
    [post setValue:@"password" forKey:@"grant_type"];
    [post setValue:@"non-expiring" forKey:@"scope"];
    [post setValue:@"idevelopingIndia7" forKey:@"password"];
    [post setValue:@"janak.thakkar@letsnurture.com" forKey:@"username"];
    return post;
}
-(void)configureTextFields{

    txtEmail.layer.borderColor = [UIColor clearColor].CGColor;
    //txtEmail.placeholder = @"Github";
    txtEmail.floatingPlaceholderEnabled = TRUE;
    txtEmail.tintColor = [UIColor Blue];
    txtEmail.rippleLocation = EPRippleLocationRight;
    txtEmail.cornerRadius = 0;
    txtEmail.bottomBorderEnabled = TRUE;
    
    txtPassword.layer.borderColor = [UIColor clearColor].CGColor;
    //txtPassword.placeholder = @"Github";
    txtPassword.floatingPlaceholderEnabled = TRUE;
    txtPassword.tintColor = [UIColor Blue];
    txtPassword.rippleLocation = EPRippleLocationRight;
    txtPassword.cornerRadius = 0;
    txtPassword.bottomBorderEnabled = TRUE;
    

}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    _prevOriginY = frame.origin.y;
    frame.origin.y -= [self gapDistanceForFirstResponder];
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = _prevOriginY;
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    NSInteger tag = theTextField.tag;
    if (++tag > 5) {
        tag = 0;
    }
    EPTextField *nextTextField = nil;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            if (textField.tag == tag) {
                nextTextField = textField;
                break;
            }
        }
    }
    if (nextTextField != nil)
        [nextTextField becomeFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:TRUE];
}

#pragma mark - Private methods

- (CGFloat)gapDistanceForFirstResponder
{
    CGFloat gap = 0;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            if ([textField isFirstResponder]) {
                gap = textField.tag * kViewGapDistance;
                break;
            }
        }
    }
    return gap;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
