//
//  DateListCellTableViewCell.m
//  CurrencyCourceApp
//
//  Created by Elerman on 08.03.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "DateListCell.h"

@implementation DateListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
