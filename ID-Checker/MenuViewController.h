//
//  MenuViewController.h
//  ID_Checker_II
//
//  Created by Chen Hsin-Hsuan on 2014/3/30.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface MenuViewController : UIViewController<ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@end
