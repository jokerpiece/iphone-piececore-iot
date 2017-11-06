//
//  BLEConnector.h
//  terumi
//
//  Created by ハマモト  on 2016/03/24.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreBluetooth/CoreBluetooth.h"

typedef NS_ENUM(NSInteger, BLEErrType) {
    BLEErrUnconnectable = 0,
};
@protocol BLEConnectDelegate
-(void)updateActionWithData:(NSData *)data;
-(void)fieldActionWithBLEErrType:(BLEErrType *)errType;
@end


@interface BLEConnector : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate>
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSString *serviceUuid;
@property (nonatomic,strong) NSString *charactoristicUuid;
@property (nonatomic,strong) CBCentralManager *centralManager;
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) NSTimer *retryTimer;
@property (nonatomic) float timerRetry;
@property (nonatomic) int retryCount;
@property (nonatomic) int retryCountLimit;
@property (nonatomic) bool isCallingServices;

+ (BLEConnector *)sharedManager;
- (id)initWithServideUuid:(NSString *)serviceUuid charactoristicUuid:(NSString *)charactoristicUuid;
-(void)startScanWithIdentifer:(NSString*)identifer retryTimer:(float)retryTimer retryCount:(int)retryCount;
-(void)cancelPeripheralConnection;
-(void)connectPeripheral;

@end
