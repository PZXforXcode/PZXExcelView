//
//  ExcelTableViewCell.m
//  PZXExcelView
//
//  Created by pzx on 2021/5/13.
//  Copyright © 2021 pzx. All rights reserved.
//

#import "ExcelTableViewCell.h"
#import "ExcelCollectionViewCell.h"

@interface ExcelTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ExcelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"1");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"2");
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        NSLog(@"3");
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rowWidth, rowHeight)];
        //左边header类型（可以根据index.row去dataSource数据修改值）
        self.leftLabel.text = [NSString stringWithFormat:@"%ld左header",self.row];
        self.leftLabel.font = [UIFont systemFontOfSize:12.f];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.layer.borderWidth = 0.5;
        self.leftLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.leftLabel];
        
        
        
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            CGFloat edge = 0.f;
                layout.itemSize = CGSizeMake(rowWidth, rowHeight);
                layout.minimumLineSpacing = edge;
                layout.minimumInteritemSpacing = edge;
                layout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);

        //    layout.itemSize
            _innerExcelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(rowWidth, 0, self.contentView.frame.size.width - rowWidth, rowHeight) collectionViewLayout:layout];
            [_innerExcelCollectionView registerClass:[ExcelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _innerExcelCollectionView.backgroundColor = [UIColor orangeColor];
        _innerExcelCollectionView.showsHorizontalScrollIndicator = NO;
            _innerExcelCollectionView.delegate = self;
            _innerExcelCollectionView.dataSource = self;
            [self.contentView addSubview:_innerExcelCollectionView];
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(0, 0, rowWidth, rowHeight);
    self.innerExcelCollectionView.frame = CGRectMake(rowWidth, 0, self.contentView.frame.size.width - rowWidth, rowHeight);
    self.leftLabel.text = [NSString stringWithFormat:@"%ld左header",self.row];

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        ExcelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5;
        cell.backgroundColor = [UIColor whiteColor];
    //表格类型（可以根据index.row去dataSource数据修改值）
        cell.excelLabel.text = [NSString stringWithFormat:@"%ld行%ld列",self.row,indexPath.row];
        return cell;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.columnNumber;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
