//
//  CurrencyViewController.h
//  CurrencyCourceApp
//
//  Created by Elerman on 28.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyViewController : UITableViewController

-(void) getCurrencyForCellDate:(NSString *)cellDate;

@property (weak, nonatomic) IBOutlet UILabel *USDL;
@property (weak, nonatomic) IBOutlet UILabel *EURL;




@end
