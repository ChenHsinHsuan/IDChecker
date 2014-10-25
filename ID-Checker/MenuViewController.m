//
//  MenuViewController.m
//  ID_Checker_II
//
//  Created by Chen Hsin-Hsuan on 2014/3/30.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "MenuViewController.h"
#import "ContentViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

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
    
    // Make self the delegate of the ad banner.
    self.adBanner.delegate = self;
    
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    ContentViewController *destVC =[segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"CN"]) {
        [destVC setFlagImageName:@"CN.png"];
        [destVC setPlaceHolder:@"请输入身分证号码"];
    }else if ([segue.identifier isEqualToString:@"TW"]) {
        [destVC setFlagImageName:@"TW.png"];
        [destVC setPlaceHolder:@"請輸入身分證字號"];
    }else if ([segue.identifier isEqualToString:@"HK"]) {
        [destVC setFlagImageName:@"HK.png"];
        [destVC setPlaceHolder:@"请输入身分证号码"];
    }else if ([segue.identifier isEqualToString:@"KO"]) {
        [destVC setFlagImageName:@"KO.png"];
        [destVC setPlaceHolder:@"주민번호를 입력하십시오."];
    }
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
    
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}

@end
