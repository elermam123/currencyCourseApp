//
//  MyXmlParserDelegate.m
//  CurrencyCourceApp
//
//  Created by Elerman on 07.03.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "MyXmlParserDelegate.h"

@interface MyXmlParserDelegate()

@property (nonatomic) NSMutableString* mstrXMLString;
@property (nonatomic) NSString* elementAttributeName;

@end

@implementation MyXmlParserDelegate

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
    _dictXml = [[NSMutableDictionary alloc] init];
    
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"Valute"]){
    
        self.elementAttributeName  = [attributeDict valueForKey:@"ID"];

    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //NSLog(@"foundCharacters --> %@", string);
    if (!_mstrXMLString) {
        _mstrXMLString = [[NSMutableString alloc] initWithString:string];
       
    }
    else {
        [_mstrXMLString appendString:string];
       
    }
   
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([self.elementAttributeName isEqualToString:@"R01235"]) {
        NSString *valuteKey = @"USD";
        [self fillArrayDictsOfXmlWithValuteKey:valuteKey andElementName:elementName];
    }
    else if([self.elementAttributeName isEqualToString:@"R01239"]){
        NSString *valuteKey = @"EUR";
        [self fillArrayDictsOfXmlWithValuteKey:valuteKey andElementName:elementName];
    }
    
    
    _mstrXMLString = nil;
    

}

-(void)fillArrayDictsOfXmlWithValuteKey:(NSString*) valuteKey andElementName:(NSString *)elementName{
    if ([elementName isEqualToString:@"Value"]) {
        [_mstrXMLString deleteCharactersInRange:NSMakeRange(0, 2)];
        [_dictXml setObject:_mstrXMLString forKey:valuteKey];
        //NSLog(@"dicXml = %@", _dictXml);
    }

}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}

@end
