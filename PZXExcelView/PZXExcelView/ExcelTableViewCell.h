//
//  ExcelTableViewCell.h
//  PZXExcelView
//
//  Created by pzx on 2021/5/13.
//  Copyright © 2021 pzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineData.h"

NS_ASSUME_NONNULL_BEGIN



@interface ExcelTableViewCell : UITableViewCell


@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger columnNumber;
@property(nonatomic,strong)UILabel *leftLabel;
@property(strong,nonatomic)UICollectionView *innerExcelCollectionView;

@end

NS_ASSUME_NONNULL_END
