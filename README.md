# PZXExcelView
类似excel或者前端表格样式的控件（原生没有写一个方便使用）

下载地址在底部
## 查看效果
![表格.gif](https://upload-images.jianshu.io/upload_images/19409325-ad3629142f04d8a6.gif?imageMogr2/auto-orient/strip)

## 实现思路
顶部是一个单独的view view左边是一个单独的view 右边为collectionView
下面是一个tableView，Cell左边是单独的View右边为collectionView

## 使用方法
将PZXExcelView 文件夹放入你的代码中
在需要的页面 #import "PZXExcelView.h"

## 具体代码
```
    PZXExcelView *excelView = [[PZXExcelView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100)];
    excelView.backgroundColor = [UIColor lightGrayColor];
    excelView.rowNumber = 8;//行
    excelView.columnNumber = 10;//列
    excelView.dataSource = @[];/数据源
    [self.view addSubview:excelView];

```
自定义数据处(代码内搜搜这几个地方 把数据替换为你想要的即可)
```
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        ExcelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5;
        cell.backgroundColor = [UIColor clearColor];
    //顶部类型（可以根据index.row去dataSource数据修改值）
        cell.excelLabel.text = [NSString stringWithFormat:@"顶部类型%ld",indexPath.row];
        return cell;

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        ExcelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5;
        cell.backgroundColor = [UIColor whiteColor];
    //表格类型（可以根据index.row去dataSource数据修改值）
        cell.excelLabel.text = [NSString stringWithFormat:@"%ld行%ld列",self.row,indexPath.row];
        return cell;

}

        //左边header类型（可以根据index.row去dataSource数据修改值）
        self.leftLabel.text = [NSString stringWithFormat:@"%ld左header",self.row];
```
