//
//  MenuViewController.m
//  ID_Checker_II
//
//  Created by Chen Hsin-Hsuan on 2014/3/30.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "MenuViewController.h"
#import "ContentViewController.h"
#import "MainCollectionViewCell.h"

@interface MenuViewController (){
    NSArray *myArr;
}


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

    myArr = @[@"CN", @"TW", @"KO", @"HK"];
    
    //Admob
    self.aGADBannerView.adUnitID = @"ca-app-pub-5200673733349176/2738515243";
    self.aGADBannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.aGADBannerView loadRequest:request];
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




#pragma mark - Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [myArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myArr[indexPath.row]
                                                             forIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark Segue
- (IBAction)backToMain:(UIStoryboardSegue *)unwindSegue
{

}
@end
