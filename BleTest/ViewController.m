//
//  ViewController.m
//  BleTest
//
//  Created by Mac on 2018/3/19.
//  Copyright © 2018年 BeiJingXiaoMenTong. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager * manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark Delegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙打开");
             [_manager scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if ([peripheral.name hasPrefix:@"iTag"]) {
        NSData *data = advertisementData[@"kCBAdvDataManufacturerData"];
        NSString *macString = [self dataToHexString:data];
        NSMutableArray *macArray = [NSMutableArray arrayWithCapacity:6];
        NSLog(@"mac = %@",macString);
        for (int i = 0; i<6; i++) {
            NSString *string = [macString substringWithRange:NSMakeRange(16-i*2, 2)];
            [macArray addObject:string];
        }
        self.macLabel.text = [[macArray componentsJoinedByString:@":"] uppercaseString];
    }
    
    
}



- (IBAction)scanClick:(id)sender {
    if (_manager.state==CBCentralManagerStatePoweredOn) {
        [_manager scanForPeripheralsWithServices:nil options:nil];
    }
    
    
}

- (IBAction)stopClick:(id)sender {
    self.macLabel.text = @"卡扣MAC";
    [_manager stopScan];
}


//16进制   data转string
-(NSString *)dataToHexString:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
- (void)didReceiveMemoryWarning {
    //FF:FF:70:07:3A:A9
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
