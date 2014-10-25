//
//  ContentViewController.m
//  ID_Checker_II
//
//  Created by Chen Hsin-Hsuan on 2014/3/30.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "ContentViewController.h"
#define MAX_LENGTH_TW 10 
#define MAX_LENGTH_CN 18
#define MAX_LENGTH_HK 9
#define MAX_LENGTH_KOR 13
@interface ContentViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *flagImageView;
@property (strong, nonatomic) IBOutlet UITextField *idTextField;
@property (strong, nonatomic) IBOutlet UIImageView *answerImageView;
@property NSDictionary *plistData;
@end

@implementation ContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //指定字典資料檔位置
    NSString *finalPath;
    if ([self.flagImageName isEqualToString:@"TW.png"]) {
       finalPath = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"TW.plist"];
    }
    if ([self.flagImageName isEqualToString:@"CN.png"]) {
       finalPath = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"CN.plist"];
    }
    if ([self.flagImageName isEqualToString:@"HK.png"]) {
        finalPath = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"HK.plist"];
    }
     //將資料檔資料讀入Dictionary
    _plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_flagImageView setImage:[UIImage imageNamed:self.flagImageName]];
    [_idTextField setPlaceholder:self.placeHolder];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [_flagImageView setImage:nil];
    [_idTextField setText:nil];
    
}



#pragma mark - TextField Protocal

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.flagImageName isEqualToString:@"TW.png"]) {
        if (textField.text.length == MAX_LENGTH_TW && range.length == 0){
            return NO;
        }else if (range.length == 0){
             [_answerImageView setImage:nil];
        }
    }
    
    if ([self.flagImageName isEqualToString:@"CN.png"]) {
        if (textField.text.length >= MAX_LENGTH_CN && range.length == 0){
            return NO;
        }else if (range.length == 0){
            [_answerImageView setImage:nil];
        }

    }
    if ([self.flagImageName isEqualToString:@"HK.png"]) {
        if (textField.text.length >= MAX_LENGTH_HK && range.length == 0){
            return NO;
        }else if (range.length == 0){
            [_answerImageView setImage:nil];
        }
    }
    if ([self.flagImageName isEqualToString:@"KO.png"]) {
        if (textField.text.length >= MAX_LENGTH_KOR && range.length == 0){
            return NO;
        }else if (range.length == 0){
            [_answerImageView setImage:nil];
        }

    }
    return YES;

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.flagImageName isEqualToString:@"TW.png"]) {
        if (textField.text.length == MAX_LENGTH_TW){
            if([self checkTaiwanId]){
                [_answerImageView setImage:[UIImage imageNamed:@"right.png"]];
            }else{
                [_answerImageView setImage:[UIImage imageNamed:@"wrong.png"]];
            }
        }else{
            [_answerImageView setImage:nil];
        }
    }
    
    if ([self.flagImageName isEqualToString:@"CN.png"]) {
        if (textField.text.length == MAX_LENGTH_CN){
            if([self checkChinaId]){
                [_answerImageView setImage:[UIImage imageNamed:@"right.png"]];
            }else{
                [_answerImageView setImage:[UIImage imageNamed:@"wrong.png"]];
            }
        }else{
            [_answerImageView setImage:nil];
        }
    }
    
    if ([self.flagImageName isEqualToString:@"KO.png"]) {
        if (textField.text.length == MAX_LENGTH_KOR){
            if([self checkKoreaId]){
                [_answerImageView setImage:[UIImage imageNamed:@"right.png"]];
            }else{
                [_answerImageView setImage:[UIImage imageNamed:@"wrong.png"]];
            }
        }else{
            [_answerImageView setImage:nil];
        }
    }

    if ([self.flagImageName isEqualToString:@"HK.png"]) {
        if (textField.text.length >= MAX_LENGTH_HK-1 ){
            if([self checkHongKongId]){
                [_answerImageView setImage:[UIImage imageNamed:@"right.png"]];
            }else{
                [_answerImageView setImage:[UIImage imageNamed:@"wrong.png"]];
            }
        }else{
            [_answerImageView setImage:nil];
        }
    }



}



- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL) checkTaiwanId
{
    //檢核第一個字母
    if ([_plistData objectForKey:[_idTextField.text substringWithRange:NSMakeRange(0, 1)].uppercaseString] == nil) {
        return NO;
    }
    
    //檢核第二個數字
    if (!([[_idTextField.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"] ||
          [[_idTextField.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"2"] ))
    {
        return NO;
    }

    NSString *idNO = [NSString stringWithFormat:@"%@", _idTextField.text];
    
    int counter = 0;
    int number;
    for (int i = 0 ; i < idNO.length; i++) {
        NSString *charString = [idNO substringWithRange:NSMakeRange(i, 1)];
        
        switch (i) {
            case 0:
                //第一碼轉換數字： 十位數*1   個位數* 9
                number = [[_plistData objectForKey:[_idTextField.text substringWithRange:NSMakeRange(0, 1)].uppercaseString] intValue];
                counter += (number / 10);
                counter += (number%10 *9);
                break;
            case 1:
                //第二碼 *8
                number = [charString intValue];
                counter += number *8;
                break;
            case 2:
                //第三碼 *7
                number = [charString intValue];
                counter += number *7;
                break;
            case 3:
                //第四碼 *6
                number = [charString intValue];
                counter += number *6;
                break;
            case 4:
                //第五碼 *5
                number = [charString intValue];
                counter += number *5;
                break;
            case 5:
                //第六碼 *4
                number = [charString intValue];
                counter += number *4;
                break;
            case 6:
                //第七碼 *3
                number = [charString intValue];
                counter += number *3;
                break;
            case 7:
                //第八碼 *2
                number = [charString intValue];
                counter += number *2;
                break;
            case 8:
                //第九碼 *1
                number = [charString intValue];
                counter += number *1;
                break;
            case 9:
                //第十碼 *1
                number = [charString intValue];
                counter += number *1;
                break;
            default:
                break;
        }
        
    }
    if(counter % 10 > 0){
        return NO;
    }
    return YES;
}

-(BOOL) checkChinaId
{
        
    //檢核前6碼
    
    if ([_plistData objectForKey:[_idTextField.text substringWithRange:NSMakeRange(0, 6)]] == nil) {
        return NO;
    }
    
    //檢核7~14碼
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateCode = [dateFormatter dateFromString:[_idTextField.text substringWithRange:NSMakeRange(6, 8)]];
    NSDate *initDateCode = [dateFormatter dateFromString:@"19000101"];//最小日期
    if (dateCode == nil) {
        return NO;
    }
    
    if ([dateCode compare: [NSDate date]] == NSOrderedDescending) {
        return NO;
    }
    if ([dateCode compare: initDateCode] == NSOrderedAscending) {
        return NO;
    }

    
    int counter = 0;
    int number;
    NSString *idNO = [NSString stringWithFormat:@"%@",_idTextField.text];
    for (int i = 0 ; i < idNO.length; i++) {
        NSString *charString = [idNO substringWithRange:NSMakeRange(i, 1)];
        switch (i) {
            case 0:
                //第一碼 *7
                number = [charString intValue];
                counter += number *7;
                break;
            case 1:
                //第二碼 *9
                number = [charString intValue];
                counter += number *9;
                break;
            case 2:
                //第三碼 *10
                number = [charString intValue];
                counter += number *10;
                break;
            case 3:
                //第四碼 *5
                number = [charString intValue];
                counter += number *5;
                break;
            case 4:
                //第五碼 *8
                number = [charString intValue];
                counter += number *8;
                break;
            case 5:
                //第六碼 *4
                number = [charString intValue];
                counter += number *4;
                break;
            case 6:
                //第七碼 *2
                number = [charString intValue];
                counter += number *2;
                break;
            case 7:
                //第八碼 *1
                number = [charString intValue];
                counter += number *1;
                break;
            case 8:
                //第九碼 *6
                number = [charString intValue];
                counter += number *6;
                break;
            case 9:
                //第十碼 *3
                number = [charString intValue];
                counter += number *3;
                break;
            case 10:
                //第十一碼 *7
                number = [charString intValue];
                counter += number *7;
                break;
            case 11:
                //第十二碼 *9
                number = [charString intValue];
                counter += number *9;
                break;
            case 12:
                //第十三碼 *10
                number = [charString intValue];
                counter += number *10;
                break;
            case 13:
                //第十四碼 *5
                number = [charString intValue];
                counter += number *5;
                break;
            case 14:
                //第十五碼 *8
                number = [charString intValue];
                counter += number *8;
                break;
            case 15:
                //第十六碼 *4
                number = [charString intValue];
                counter += number *4;
                break;
            case 16:
                //第十七碼 *2
                number = [charString intValue];
                counter += number *2;
                break;
            case 17:
                break;
            default:
                break;
        }
        
    }
    
    
    NSArray *lastCheckCodeArr = [[NSArray alloc]initWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    
    
    if ([[idNO substringWithRange:NSMakeRange(17, 1)] isEqual:[lastCheckCodeArr objectAtIndex:(counter % 11)]] ) {
        return YES;
    }else {
        return NO;
    }

    return YES;
}

-(BOOL) checkKoreaId
{
    //檢核1~6碼
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateCode = [dateFormatter dateFromString:[_idTextField.text substringWithRange:NSMakeRange(0, 6)]];
    NSDate *minDate = [dateFormatter dateFromString:@"19000101"];//最小日期
    if (dateCode == nil) {
        return NO;
    }
    
    if ([dateCode compare: [NSDate date]] == NSOrderedDescending) {
        return NO;
    }
    if ([dateCode compare: minDate] == NSOrderedAscending) {
        return NO;
    }
    
    
    NSString *idNO = [NSString stringWithFormat:@"%@", _idTextField.text];
    int counter = 0;
    int number;
    for (int i = 0 ; i < idNO.length; i++) {
        NSString *charString = [idNO substringWithRange:NSMakeRange(i, 1)];
        switch (i) {
            case 0:
                //第一碼* 2
                number = [charString intValue];
                counter += number *2;
                break;
            case 1:
                //第二碼 *3
                number = [charString intValue];
                counter += number *3;
                break;
            case 2:
                //第三碼 *4
                number = [charString intValue];
                counter += number *4;
                break;
            case 3:
                //第四碼 *5
                number = [charString intValue];
                counter += number *5;
                break;
            case 4:
                //第五碼 *6
                number = [charString intValue];
                counter += number *6;
                break;
            case 5:
                //第六碼 *7
                number = [charString intValue];
                counter += number *7;
                break;
            case 6:
                //第七碼 *8
                number = [charString intValue];
                counter += number *8;
                break;
            case 7:
                //第八碼 *9
                number = [charString intValue];
                counter += number *9;
                break;
            case 8:
                //第九碼 *2
                number = [charString intValue];
                counter += number *2;
                break;
            case 9:
                //第十碼 *3
                number = [charString intValue];
                counter += number *3;
                break;
            case 10:
                //第十一碼 *4
                number = [charString intValue];
                counter += number *4;
                break;
            case 11:
                //第十二碼 *5
                number = [charString intValue];
                counter += number *5;
                break;
            case 12:
                //第十三碼
                break;
            default:
                break;
        }
    }
    counter  = 11- (counter %11);
    counter = counter %10;
    if (counter != [idNO substringWithRange:NSMakeRange(12, 1)].intValue) {
        return NO;
    }

    return YES;
}

-(BOOL) checkHongKongId
{
    NSArray *lastChar = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", nil];
    if (_idTextField.text.length == 9) {
        //檢核第二個字母
        if ([_plistData objectForKey:[_idTextField.text substringWithRange:NSMakeRange(1, 1)].uppercaseString] == nil ) {
            return NO;
        }
    }else if(_idTextField.text.length == 8){
        //檢核第一個字母
        if ([_plistData objectForKey:[_idTextField.text substringWithRange:NSMakeRange(0, 1)].uppercaseString] == nil ) {
            return NO;
            
        }
    }
    
    
    
    NSString *idNO = [NSString stringWithFormat:@"%@", _idTextField.text];
    
    int counter = 0;
    int number;
    for (int i = 0 ; i < idNO.length; i++) {
        NSString *charString = [idNO substringWithRange:NSMakeRange(i, 1)];
        if (_idTextField.text.length == 9) {
            switch (i) {
                case 0:
                    //第一碼轉換數字：
                    number = [[_plistData objectForKey:charString.uppercaseString] intValue];
                    if (number == 0) {
                        //是數字
                        counter += charString.intValue;
                    }else {
                        //是字母
                        counter += number*9;
                    }
                    break;
                case 1:
                    //第二碼轉換數字：
                    number = [[_plistData objectForKey:charString.uppercaseString] intValue];
                    counter += number *8;
                    break;
                case 2:
                    //第三碼 *7
                    number = [charString intValue];
                    counter += number*7;
                    break;
                case 3:
                    //第四碼 *6
                    number = [charString intValue];
                    counter += number *6;
                    break;
                case 4:
                    //第五碼 *5
                    number = [charString intValue];
                    counter += number *5;
                    break;
                case 5:
                    //第六碼 *4
                    number = [charString intValue];
                    counter += number *4;
                    break;
                case 6:
                    //第七碼 *3
                    number = [charString intValue];
                    counter += number *3;
                    break;
                case 7:
                    //第八碼 *2
                    number = [charString intValue];
                    counter += number *2;
                    break;
                case 8:
                    //第九碼 *1
                    if ([lastChar indexOfObject:charString.uppercaseString] == NSNotFound) {
                        return NO;
                    }
                    if ([charString isEqualToString:@"A"]) {
                        counter += 10;
                    }else {
                        number = [charString intValue];
                        counter += number *1;
                    }
                    break;
                default:
                    break;
            }
            
        }else if (_idTextField.text.length == 8) {
            switch (i) {
                case 0:
                    //第二碼轉換數字：*8
                    number = [[_plistData objectForKey:charString.uppercaseString] intValue];
                    counter += number *8;
                    break;
                case 1:
                    //第三碼 *7
                    number = [charString intValue];
                    counter += number *7;
                    break;
                case 2:
                    //第四碼 *6
                    number = [charString intValue];
                    counter += number *6;
                    break;
                case 3:
                    //第五碼 *5
                    number = [charString intValue];
                    counter += number *5;
                    break;
                case 4:
                    //第六碼 *4
                    number = [charString intValue];
                    counter += number *4;
                    break;
                case 5:
                    //第七碼 *3
                    number = [charString intValue];
                    counter += number *3;
                    break;
                case 6:
                    //第八碼 *2
                    number = [charString intValue];
                    counter += number *2;
                    break;
                case 7:
                    //第九碼＊1
                    if ([lastChar indexOfObject:charString.uppercaseString] == NSNotFound) {
                        return NO;
                    }
                    if ([charString isEqualToString:@"A"]) {
                        counter += 10;
                    }else {
                        number = [charString intValue];
                        counter += number *1;
                    }
                    break;
                default:
                    break;
            }
            
        }
    }
    
    
    if (_idTextField.text.length == 8) {
        counter += 58*9;
    }
    
    if(counter % 11 > 0){
        return NO;
    }

    return YES;

}

@end
