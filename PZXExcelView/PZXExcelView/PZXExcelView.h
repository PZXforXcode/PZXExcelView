//
//  PZXExcelView.h
//  PZXExcelView
//
//  Created by pzx on 2021/5/13.
//  Copyright © 2021 pzx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PZXExcelView : UIView

@property(nonatomic,assign)NSInteger rowNumber;//行数
@property(nonatomic,assign)NSInteger columnNumber;//列数
@property(nonatomic,strong)NSDictionary *dataSource;//数据源（具体使用根据你的数据结构来）

@end

NS_ASSUME_NONNULL_END
