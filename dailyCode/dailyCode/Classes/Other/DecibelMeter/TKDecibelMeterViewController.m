//
//  TKDecibelMeterViewController.m
//  dailyCode
//
//  Created by hello on 2021/9/23.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKDecibelMeterViewController.h"
#import "DecibelMeterHelper.h"

@interface TKDecibelMeterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dbLabel;
@property (nonatomic, strong) DecibelMeterHelper *dbHelper;
@end

@implementation TKDecibelMeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dbHelper = [[DecibelMeterHelper alloc]init];
    
    __weak typeof(self) weakSelf = self;
    self.dbHelper.decibelMeterBlock = ^(double dbSPL){
        
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.dbLabel.text = [NSString stringWithFormat:@"%.2lf",dbSPL];
        });

    };
}

- (IBAction)processStartAction:(UIButton *)sender {
    [self.dbHelper startMeasuringWithIsSaveVoice:NO];
}

- (IBAction)processStopAction:(UIButton *)sender {
    [self.dbHelper stopMeasuring];
}



@end
