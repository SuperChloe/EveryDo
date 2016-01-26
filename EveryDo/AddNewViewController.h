//
//  AddNewViewController.h
//  EveryDo
//
//  Created by Chloe on 2016-01-26.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "ToDo.h"

@protocol AddNewProtocol <NSObject>

- (void)addNew:(ToDo *)newToDo;

@end

@interface AddNewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *descrField;
@property (weak, nonatomic) IBOutlet UITextField *priorityField;
@property (weak, nonatomic) id <AddNewProtocol> delegate;

@end
