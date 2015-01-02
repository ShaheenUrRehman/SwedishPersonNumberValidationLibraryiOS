//
//  SwedishPersonNumberValidation.m
//  Studentkortet
//
//  Created by Shaheen Ur Rehman on 1/1/15.
//  Copyright (c) 2015 Noonday HB. All rights reserved.
//

#import "SwedishPersonNumberValidation.h"

@implementation SwedishPersonNumberValidation

-(BOOL) NSStringIsValidPersonNumber:(NSString *)checkPersonnummer{
    
    // Get Person Number and assign to NSString
    NSString *text = checkPersonnummer;
    
    // Regular Expression which will support DOB(YYYYMMDD) and DOB (YYMMDD) wit other four characters.
    // As Swedish Person number is either 10 or 12 digits and support DOB in above two formats.
    NSString *personNumberDOBRegEx = @"(((20)((0[0-9])|(1[0-1])))|(([1][^0-8])?\\d{2}))((0[1-9])|1[0-2])((0[1-9])|(2[0-9])|(3[01]))[-+]?\\d{4}[,.]?";
    
    // Assign Regular Expression to NSPredicate
    NSPredicate *personNumberRegTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", personNumberDOBRegEx];
    
    // Check Personnumer format is Valid
    if ([personNumberRegTest evaluateWithObject:text] == NO) {
        // If regular expression not validated return false
        return NO;
    }else{
        // When Regular expression is validated then check for checksum.
        NSString *personNumberText = text;
        NSString *strChecksum;
        
        // Maximum there are 12 characters in Swedish Person Number but it could be either 10 or 12
        // So If 12 then go to this condition
        if (personNumberText.length == 12) {
            /*
             Ignore the first two characters which represent century like 19 or 20
             Swedish person number checksum algorithm basically ignores the first two characters.
             When we ignore the first two character final values are of 10 character
             */
            personNumberText = [personNumberText substringFromIndex:2];
        }
        // strChecksum is the final 10th or 12th character that user enters which is actually checksum value
        // We have to validate this with algorithm Calculated checksum
        strChecksum = [personNumberText substringFromIndex:personNumberText.length-1];
        
        // Remove the last Checksum value from entered person number
        NSString *strBeforeChecksum = [personNumberText substringToIndex:personNumberText.length-1];
        
        NSNumber *calculatedChecksumNumber;
        NSString *str = strBeforeChecksum;
        
        // strChecksumValidation is actually the number with which we calculate each and every value on that index
        NSString *strChecksumValidation = @"212121212";
        // Loop for spliting nsstring and multiply individual character at index i with the character of above checksum value at index i
        for (int i = 0; i < [str length]; i++) {
            // Person number String at index i
            NSString *ch = [str substringWithRange:NSMakeRange(i, 1)];
            // Checksum Validation number string at index i
            NSString *chValidation = [strChecksumValidation substringWithRange:NSMakeRange(i, 1)];
            
            // Multiply the two values
            int multiplieChecksum = [ch intValue]*[chValidation intValue];
            // Assign int to NSString
            NSString *checksumCalculated = [NSString stringWithFormat:@"%d",multiplieChecksum];
            NSString *multipleCalculatedValue;
            // If the multiple of two numbers are two characters then convert them to one by adding both characters
            if (checksumCalculated.length == 2) {
                
                NSString *firstString = [checksumCalculated substringToIndex:1];
                NSString *secondString = [checksumCalculated substringFromIndex:1];
                int calculateMultipe = [firstString intValue]+[secondString intValue];
                multipleCalculatedValue = [NSString stringWithFormat:@"%d",calculateMultipe];
                
            }else{
                // If multiple is one assign value to multipleCalculatedValue
                multipleCalculatedValue = checksumCalculated;
            }
            // Add the multiple of two characteres to the first calculated value
            int calculatedChecksumInt = [calculatedChecksumNumber intValue] + [multipleCalculatedValue intValue];
            calculatedChecksumNumber = [NSNumber numberWithInt:calculatedChecksumInt];
            
        }
        // Sum of the multiple of all correspondent values and assign to NSString
        NSString *calculatedChecksumString = [NSString stringWithFormat:@"%d",[calculatedChecksumNumber intValue]];
        // Take Last Character of calculated value whose Minus 10 should be equal to the last enter character of checksum value provided that last calculated character is not zero
        NSString *lastIndexOfCalChecksum = [calculatedChecksumString substringFromIndex:1];
        NSString *finalChecksum;
        // If last characters of calculated sum is 0 then checksum should be zero else it should be 10 minus of that values
        if ([lastIndexOfCalChecksum intValue] == 0) {
            finalChecksum = [NSString stringWithFormat:@"%d",0];
            
        }else{
            
            int MinusTenOfCheckInt = 10 - [lastIndexOfCalChecksum intValue];
            
            finalChecksum = [NSString stringWithFormat:@"%d",MinusTenOfCheckInt];
        }
        
        // If final calculated checksum value match with last entered character
        // Congratulate your person number is valid
        // If not your person number is wrong
        if ([finalChecksum isEqualToString:strChecksum]) {
            return YES;
        }else{
            return NO;
        }
        
    }
    
    
    
    return YES;
}

@end

