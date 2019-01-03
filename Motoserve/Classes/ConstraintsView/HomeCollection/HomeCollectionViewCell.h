//
//  HomeCollectionViewCell.h
//  Motoserve
//
//  Created by Karthik Baskaran on 03/01/19.
//  Copyright © 2019 Shyam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CPMetaFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell
{
    AppDelegate * appdelegate;
}
@property(nonatomic,retain)UIImageView * onrdserviceImg;
@property(nonatomic,retain)UILabel * onrdserviceLbl;
@property(nonatomic,retain)UIButton * serviceBtn;
@end

NS_ASSUME_NONNULL_END
