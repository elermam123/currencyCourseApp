//
//  ViewController.m
//  CurrencyCourceApp
//
//  Created by Elerman on 28.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "DateListController.h"
#import "CurrencyViewController.h"
#import "DateListCell.h"

@interface DateListController ()

@property (assign, nonatomic) NSUInteger dateRowsCount;
@property (assign,nonatomic) BOOL loadingData;

@property NSInteger dateDays;
@property (nonatomic) NSMutableArray *dateArray;



@end

@implementation DateListController{
    NSDate *date;
    NSDateComponents *components;
    NSCalendar *calendar;
    NSDateFormatter *dateFormatter;
}


static NSUInteger addRowCount = 25;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingData = YES;
   
    components = [[NSDateComponents alloc] init];
    date = [NSDate date];
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    _dateArray = [NSMutableArray array];
    
    [self updateRowCount];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dateRowsCount;
}


-(void) updateRowCount{
    
    //NSLog(@"DateRowsCount = %ld", self.dateRowsCount);
    
    NSMutableArray *newPaths = [NSMutableArray array];
    
    
    for(NSUInteger i = self.dateRowsCount; i < self.dateRowsCount + addRowCount; i++){
        
        [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        if(i == 0){
            _dateDays = 0;
        }
        else{
            _dateDays = components.day - 1;
        }
        [components setValue:_dateDays forComponent:NSCalendarUnitDay];
        
        date = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
        
        
        NSString *dateString = [dateFormatter stringFromDate:date];

        [_dateArray addObject:dateString];
    }
    
    [self.tableView beginUpdates];
    self.dateRowsCount += addRowCount;
    [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];

    self.loadingData = NO;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"Cell";
   

    DateListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[DateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString* dateStr = [_dateArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dateStr;
    

    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if(!self.loadingData){
            self.loadingData = YES;
           [self updateRowCount];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"Currency"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath.row != self.dateRowsCount){
            NSString* strDate = ((DateListCell*)sender).textLabel.text;
            CurrencyViewController *currencyVC = [segue destinationViewController];
            [currencyVC getCurrencyForCellDate:strDate];
        }
        
        
    }

}


@end
