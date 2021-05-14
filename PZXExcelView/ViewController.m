//
//  ViewController.m
//  PZXExcelView
//
//  Created by pzx on 2021/5/13.
//  Copyright © 2021 pzx. All rights reserved.
//

#import "ViewController.h"
#import "PZXExcelView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    PZXExcelView *excelView = [[PZXExcelView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100)];
    excelView.backgroundColor = [UIColor lightGrayColor];
    excelView.rowNumber = 8;//行
    excelView.columnNumber = 10;//列
    [self.view addSubview:excelView];
    
}


@end
