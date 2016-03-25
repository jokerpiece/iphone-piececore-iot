//
//  BaseSencorViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/03/01.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "CoreBluetooth/CoreBluetooth.h"
#import "DistanceSencorData.h"
#import "BLEConnector.h"

@interface BaseSencorViewController : BaseViewController <BLEConnectDelegate>
@property (nonatomic) BLEConnector *ble;

-(void)setBLEConnectorWithServiceUuid:(NSString *)serviceUuid CharactoristicUuid:(NSString *)charactoristicUuid;
-(void)cancelPeripheralConnection;
-(void)connectPeripheral;
-(void)startScanWithIdentifer:(NSString*)identifer retryTime:(float)retryTime retryCount:(int)retryCount;
-(void)fieldActionWithBLEErrType:(BLEErrType *)errType;
@end
