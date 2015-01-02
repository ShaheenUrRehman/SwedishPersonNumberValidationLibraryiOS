//
//  SwedishPersonNumberValidation.h
//  Studentkortet
//
//  Created by Shaheen Ur Rehman on 1/1/15.
//  Copyright (c) 2015 Noonday HB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwedishPersonNumberValidation : NSObject

/*
 Swedish person number is a number which shows the Date of birth of a person, his home town, his status in a country wither you are resident, citizen or immigrants and finally a checksum which has its own algorithm on the bases of all the previous values.
 This method will first validate the first 9 or 11 digits and then validate the checksum which regular expression is validated.
 */
-(BOOL) NSStringIsValidPersonNumber:(NSString *)checkPersonnummer;

@end
