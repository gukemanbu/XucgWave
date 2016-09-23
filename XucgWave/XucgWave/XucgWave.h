//
//  XucgWave.h
//  XucgWave
//
//  Created by xucg on 8/30/16.
//  Copyright © 2016 xucg. All rights reserved.
//  Welcome visiting https://github.com/gukemanbu

#import <QuartzCore/QuartzCore.h>

@interface XucgWave : CAShapeLayer

// 波长，默认为视图宽
@property (nonatomic, assign) CGFloat waveLength;
// 波速，默认是4
@property (nonatomic, assign) NSUInteger waveSpeed;
// 水波高度百分比, 0 ~ 1
@property (nonatomic, assign) CGFloat percent;
// 水波上涨速度, 0 ~ 1, 默认值0.008
@property (nonatomic, assign) CGFloat growSpeed;
// 波开始的点，默认为0，多个波时为了不重合，需要设置此值, 0 ~ 波长
@property (nonatomic, assign) CGFloat startX;

- (instancetype)initWidth:(CGFloat)width height:(CGFloat)height;
- (void)startWave;
- (void)stopWave;

@end
