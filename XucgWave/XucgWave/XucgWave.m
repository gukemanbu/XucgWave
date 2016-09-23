//
//  XucgWave.m
//  XucgWave
//
//  Created by xucg on 8/30/16.
//  Copyright © 2016 xucg. All rights reserved.
//  Welcome visiting https://github.com/gukemanbu

#import "XucgWave.h"

const CGFloat gDefaultGrowSpeed = 0.008f;

@interface XucgWave ()

@property (nonatomic, assign) CGFloat        width;               // 当前视图宽
@property (nonatomic, assign) CGFloat        height;              // 当前视图高
@property (nonatomic, assign) CGFloat        waveHeight;          // 默认波高
@property (nonatomic, assign) CGFloat        offsetX;             // x位移
@property (nonatomic, assign) CGFloat        amplitude;           // 振幅比率
@property (nonatomic, assign) BOOL           amplitudeDirection;  // 振幅方向，默认为上
@property (nonatomic, strong) CADisplayLink  *displayLink;        // 更新器，相当于timer
@property (nonatomic, assign) CGFloat        tmpPercent;          // 临时波高占比，上涨动画用

@end

@implementation XucgWave

- (instancetype)initWidth:(CGFloat)width height:(CGFloat)height {
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
        _amplitude = 1.5f;
        _offsetX = 0;
        _percent = 0;
        _waveHeight = height * (1 - _percent);
        _amplitudeDirection = YES;
        _waveLength = width;
        _tmpPercent = 0.f;
        _growSpeed = gDefaultGrowSpeed;
        _startX = 0;
        _waveSpeed = 4;
    }
    
    return self;
}

- (void)updateWave {
    if (_amplitudeDirection) {
        _amplitude += 0.01;
    } else {
        _amplitude -= 0.01;
    }
    
    if (_amplitude <= 1) {
        _amplitudeDirection = YES;
    }
    
    if (_amplitude >= 1.5) {
        _amplitudeDirection = NO;
    }
    
    _offsetX += 0.1;

    if (_tmpPercent < _percent) {
        _tmpPercent += _growSpeed;
    } else {
        _tmpPercent = _percent;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    _waveHeight = _height * (1 - _tmpPercent);
    float y = _waveHeight;
    CGPathMoveToPoint(path, nil, 0, y);
    for(float x=0; x<=self.width; x++) {
        y = _amplitude * sin((x+_startX)/_waveLength*(M_PI*2) + _offsetX/M_PI * _waveSpeed) * 5 + _waveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _width, _height);
    CGPathAddLineToPoint(path, nil, 0, _height);
    CGPathAddLineToPoint(path, nil, 0, _waveHeight);
    
    self.path = path;
    CGPathRelease(path);
}

- (void) setPercent:(CGFloat)percent {
    _percent = percent;
    
    if (percent < 0.f) {
        _percent = 0.f;
    } else if (percent > 1.f) {
        _percent = 1.f;
    }
}

- (void)setGrowSpeed:(CGFloat)growSpeed {
    _growSpeed = growSpeed;
    if (_percent == 0.f) {
        _growSpeed = gDefaultGrowSpeed;
        return;
    }
    
    if (_growSpeed > _percent) {
        _growSpeed = _percent;
    } else if (_growSpeed < 0) {
        _growSpeed = gDefaultGrowSpeed;
    }
}

- (void)setStartX:(CGFloat)startX {
    _startX = startX;
    
    if (_startX < 0) {
        _startX = 0;
    } else if (_startX > _width) {
        _startX = 0;
    }
}

- (void)startWave {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopWave {
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
