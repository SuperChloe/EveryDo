//
//  MasterViewController.m
//  EveryDo
//
//  Created by Chloe on 2016-01-26.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddNewViewController.h"
#import "ToDo.h"
#import "ToDoCell.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, AddNewProtocol>

@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    ToDo *makeBreakfast = [[ToDo alloc] initWithTitle:@"Make breakfast" description:@"Ceral" andPriority:5];
    ToDo *learnToCode = [[ToDo alloc] initWithTitle:@"Learn to code" description:@"Go to Lighthouse Labs" andPriority:2];
    ToDo *doLaundry = [[ToDo alloc] initWithTitle:@"Do laundry" description:@"Separate whites and colors" andPriority:3];
    ToDo *eatDinner = [[ToDo alloc] initWithTitle:@"Meet friend for Dinner" description:@"At restaurant" andPriority:4];
    ToDo *feedCat = [[ToDo alloc] initWithTitle:@"Feed the cat" description:@"Calvin is hungry" andPriority:1];
    
    self.objects = [[NSMutableArray alloc] init];
    [self.objects addObjectsFromArray:@[makeBreakfast, learnToCode, doLaundry, eatDinner, feedCat]];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    [self.tableView addGestureRecognizer:swipe];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"addToDo" sender:self];
}

- (void)swipeCell:(UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    ToDo *toDo = self.objects[indexPath.row];
    
    if (toDo.isCompleted == NO) {
        toDo.isCompleted = YES;
    } else {
        toDo.isCompleted = NO;
    }
    
    [self.tableView reloadData];
   
    NSLog(@"Swipe!");
    
}

- (void)addNew:(ToDo *)newToDo {
    [self.objects insertObject:newToDo atIndex:0];
    
    // Tell our tableview to insert a new row
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *toDo = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:toDo];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    
    if ([segue.identifier isEqualToString:@"addToDo"]) {
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];

    ToDo *toDo = self.objects[indexPath.row];
    
    if (toDo.isCompleted == NO) {
    cell.titleLabel.text = toDo.title;
    cell.descriptionLabel.text = toDo.descr;
    cell.priorityLabel.text = [NSString stringWithFormat:@"%i", toDo.priorityNumber];
    } else {
        NSMutableAttributedString *titleStrike = [[NSMutableAttributedString alloc] initWithString:(cell.titleLabel.text)];
        [titleStrike addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [titleStrike length])];
        NSMutableAttributedString *descrStrike = [[NSMutableAttributedString alloc] initWithString:(cell.descriptionLabel.text)];
        [descrStrike addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [descrStrike length])];
        cell.titleLabel.attributedText = titleStrike;
        cell.descriptionLabel.attributedText = descrStrike;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
