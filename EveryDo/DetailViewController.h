//
//  DetailViewController.h
//  EveryDo
//
//  Created by Chloe on 2016-01-26.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

