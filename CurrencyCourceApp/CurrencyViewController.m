//
//  CurrencyViewController.m
//  CurrencyCourceApp
//
//  Created by Elerman on 28.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "CurrencyViewController.h"

#import "MyXmlParserDelegate.h"

@interface CurrencyViewController ()


@end

@implementation CurrencyViewController


-(id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source


-(void) getCurrencyForCellDate:(NSString *)cellDate{
    //NSLog(@"cellDate = %@", cellDate);
    
    NSLog(@"some magic action = %@",self.tableView.visibleCells);

    NSString* urlString = [NSString stringWithFormat:@"http://www.cbr.ru/scripts/XML_daily.asp?date_req=%@", cellDate];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    MyXmlParserDelegate *parserDelegate = [[MyXmlParserDelegate alloc] init];
    [parser setDelegate:parserDelegate];
    
    if([parser parse]){
        //NSLog(@"parserDelegate.dictXml = %@",parserDelegate.dictXml);
        if(parserDelegate.dictXml){
            self.USDL.text = [parserDelegate.dictXml objectForKey:@"USD"];
            self.EURL.text = [parserDelegate.dictXml objectForKey:@"EUR"];
        }
    }
   


}



@end
