//
//  ViewController.m
//  OptionDemo
//
//  Created by Liang Dai on 2020/3/23.
//  Copyright © 2020 Liang Dai. All rights reserved.
//

#import "ViewController.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//星期选择
typedef NS_OPTIONS(NSInteger, ALWeekRepeat) {
    ALWeekRepeatNone = 0,//未选择
    ALWeekRepeatMonday = 1<<1,
    ALWeekRepeatTuesday = 1<<2,
    ALWeekRepeatWednesday = 1<<3,
    ALWeekRepeatThursday = 1<<4,
    ALWeekRepeatFriday = 1<<5,
    ALWeekRepeatSaturday = 1<<6,
    ALWeekRepeatSunday = 1<<7
};

@interface ViewController ()
@property (nonatomic) ALWeekRepeat tempWeekRepeat;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tempWeekRepeat = ALWeekRepeatMonday | ALWeekRepeatFriday;
    // Do any additional setup after loading the view.
    NSArray *weekarray = @[@"M",@"TU",@"W",@"TH",@"F",@"SA",@"SU"];
    CGFloat weekButtonWidth = 30;
    CGFloat margin = (self.view.frame.size.width - weekButtonWidth * 7) / 8;
    for (NSInteger i = 0; i < weekarray.count; i++) {
        UIButton *weekBtn = [[UIButton alloc]init];
        weekBtn.tag = i;
        weekBtn.frame = CGRectMake( margin + i * (margin + weekButtonWidth), 100, weekButtonWidth, weekButtonWidth);
        [weekBtn setTitle:weekarray[i] forState:UIControlStateNormal];
        [weekBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [weekBtn setTitleColor:RGB(33, 209, 102) forState:UIControlStateSelected];
        weekBtn.adjustsImageWhenHighlighted = NO;
        [weekBtn addTarget:self action:@selector(weekBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if ((_tempWeekRepeat & (1<<(i+1)))) {
            weekBtn.selected = YES;
        }
        [self.view addSubview:weekBtn];
    }
}

-(void)weekBtnClick:(UIButton *)button{
//    ALWeekRepeat tempWeekRepeat = 0;
    button.selected = !(button.selected);
    if (button.isSelected) {
        _tempWeekRepeat |= 1<<(button.tag +1);
        button.backgroundColor = RGB(242, 242, 242);
        button.layer.cornerRadius = 15;
        button.layer.masksToBounds = YES;
    }else{
        _tempWeekRepeat &= ~(1<<(button.tag +1));
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 0;
    }
}

@end
