//
//  BLEConnector.m
//  terumi
//
//  Created by ハマモト  on 2016/03/24.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BLEConnector.h"
#import "DLog.h"
#import "SVProgressHUD.h"

@implementation BLEConnector

- (id)initWithServideUuid:(NSString *)serviceUuid charactoristicUuid:(NSString *)charactoristicUuid
{
    self = [super init];
    if (self) {
        self.serviceUuid = serviceUuid;
        self.charactoristicUuid = charactoristicUuid;
    }
    return self;
}

-(void)startScanWithIdentifer:(NSString*)identifer retryTimer:(float)retryTimer retryCount:(int)retryCount{
    
    self.retryCountLimit = retryCount;
    self.retryCount = 0;
    SEL sel = @selector(retryScan:);
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:sel];
    [invocation setArgument:(void *)&identifer atIndex:2];
    
    
    if (self.retryTimer == nil) {
        if (retryTimer != 0) {
            self.retryTimer = [NSTimer scheduledTimerWithTimeInterval:retryTimer invocation:invocation repeats:YES];
            [self.retryTimer fire];
        }

    }
    
    self.isCallingServices = NO;
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                               queue:nil
                                                             options:@{ CBCentralManagerOptionRestoreIdentifierKey:
                                                                            
                                                                            identifer}];
}

-(void)retryScan:(NSString *)identifer{
    self.retryCount ++;
    if (self.retryCount > self.retryCountLimit) {
        [self.retryTimer invalidate];
        self.retryTimer = nil;
        [self.delegate fieldActionWithBLEErrType:BLEErrUnconnectable];
    }
    self.isCallingServices = NO;
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                               queue:nil
                                                             options:@{ CBCentralManagerOptionRestoreIdentifierKey:
                                                                            
                                                                            identifer}];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSLog(@"w:%ld", (long)central.state);
    NSArray *services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:self.serviceUuid], nil];
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                        forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    switch (central.state) {
            
        case CBCentralManagerStatePoweredOn:
            
            [self.centralManager scanForPeripheralsWithServices:services
                                                        options:options];
            
            break;
        case CBCentralManagerStatePoweredOff:
            [SVProgressHUD dismiss];
            DLog(@"power off");
            break;
        case CBCentralManagerStateUnknown:
            [SVProgressHUD dismiss];
            DLog(@"unknown");
            break;
        case CBCentralManagerStateUnauthorized:
            [SVProgressHUD dismiss];
            DLog(@"unauthorized");
            break;
        case CBCentralManagerStateUnsupported:
            [SVProgressHUD dismiss];
            DLog(@"unsupport");
            break;
        default:
            [SVProgressHUD dismiss];
            DLog(@"other");
            break;
    }
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    [self.retryTimer invalidate];
    self.retryTimer = nil;
    NSLog(@"peripheral：%@", peripheral);
    if ([peripheral.name hasPrefix:@"JPSns"]) {
        self.peripheral = peripheral;
        
        [self.centralManager connectPeripheral:self.peripheral options:nil];
    }
    
}

// ペリフェラルへの接続が失敗すると呼ばれる
- (void)        centralManager:(CBCentralManager *)central
    didFailToConnectPeripheral:(CBPeripheral *)peripheral
                         error:(NSError *)error {
    NSLog(@"failed...");
}

// ペリフェラルへの接続が成功すると呼ばれる
- (void)  centralManager:(CBCentralManager *)central
    didConnectPeripheral:(CBPeripheral *)peripheral{
    [self.centralManager stopScan];
    peripheral.delegate = self;
    
    NSArray *services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:self.serviceUuid],nil];
    
    [peripheral discoverServices:services];
    NSLog(@"connected!");
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    self.isCallingServices = YES;
    if (error) {
        NSLog(@"error: %@", error);
        return;
    }
    
    if (peripheral.services.count <= 0) {
        DLog(@"no service");
    }
    
    NSArray *services = peripheral.services;
    NSLog(@"Found %lu services! :%@", (unsigned long)services.count, services);
    
    for (CBService *service in services) {
        
        DLog(@"キャラクタリスティック探索開始");
        NSArray *charastics = [NSArray arrayWithObjects:[CBUUID UUIDWithString:self.charactoristicUuid],nil];
        [peripheral discoverCharacteristics:charastics forService:service];
    }
}

// キャラクタリスティック発見時に呼ばれる
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error
{
    if (error)
    {
        NSLog(@"didDiscoverCharacteristics error: %@", error.localizedDescription);
        return;
    }
    
    if (service.characteristics.count == 0)
    {
        NSLog(@"didDiscoverCharacteristics no characteristics");
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:self.charactoristicUuid]])
        {
            // Alert Levelキャラクタリスティックオブジェクトへの参照を保管
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if (error)
    {
        NSLog(@"didUpdateValueForCharacteristic error: %@", error.localizedDescription);
        return;
    }
    
    
    NSData *data = [characteristic value];      // 1
    
    [self.delegate updateActionWithData:data];
    
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
    NSLog(@"willRestoreState called");
    self.centralManager = dict[CBCentralManagerRestoredStatePeripheralsKey];
}

-(void)cancelPeripheralConnection{
    if (self.peripheral != nil) {
        [self.centralManager cancelPeripheralConnection:self.peripheral];
    }
    
}

-(void)connectPeripheral{
    [self.centralManager connectPeripheral:self.peripheral options:nil];
}

@end
