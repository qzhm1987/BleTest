//
//  ViewController.h
//  BleTest
//
//  Created by Mac on 2018/3/19.
//  Copyright © 2018年 BeiJingXiaoMenTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *macLabel;

- (IBAction)scanClick:(id)sender;
- (IBAction)stopClick:(id)sender;

@end

