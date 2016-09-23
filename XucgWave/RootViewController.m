//
//  RootViewController.m
//  XucgWave
//
//  Created by xucg on 8/30/16.
//  Copyright © 2016 xucg. All rights reserved.
//

#import "RootViewController.h"
#import "XucgWave.h"

@interface RootViewController ()

@property (nonatomic, weak) IBOutlet UIView *waveView;
@property (nonatomic, strong) XucgWave *wave1;
@property (nonatomic, strong) XucgWave *wave2;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _waveView.layer.cornerRadius = 100;
    _waveView.layer.masksToBounds = YES;
    _waveView.layer.borderWidth = 3;
    _waveView.layer.borderColor = [UIColor colorWithRed:233.f/255.f green:233.f/255.f blue:233.f/255.f alpha:1].CGColor;
    _waveView.backgroundColor = [UIColor colorWithRed:33.f/255.f green:33.f/255.f blue:33.f/255.f alpha:1];
    
    _wave1 = [[XucgWave alloc] initWidth:200 height:200];
    _wave1.fillColor = [UIColor cyanColor].CGColor;
    _wave1.percent = 0.5f;
    _wave1.growSpeed = 0.01;
    _wave1.waveLength = 150;
    [_waveView.layer addSublayer:_wave1];
    
    _wave2 = [[XucgWave alloc] initWidth:200 height:200];
    _wave2.fillColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:1].CGColor;
    _wave2.percent = 0.5f;
    _wave2.growSpeed = 0.01;
    _wave2.waveLength = 100;
    _wave2.startX = 50;
    _wave2.waveSpeed = 5;
    [_waveView.layer addSublayer:_wave2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonAciton:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [_wave1 startWave];
        [_wave2 startWave];
    } else {
        [_wave1 stopWave];
        [_wave2 stopWave];
    }
}

@end
