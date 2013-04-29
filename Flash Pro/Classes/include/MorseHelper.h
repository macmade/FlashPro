/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseHelper.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@class FlashHelper;

typedef struct MorseCode_Struct
{
    char         character;
    unsigned int length;
    uint8_t      code;
}
MorseCode;

@interface MorseHelper: NSObject
{
@protected
    
    FlashHelper * flash;
    BOOL          shouldStop;
    BOOL          running;
    
@private

    id r1;
    id r2;
}

+ ( MorseHelper * )sharedInstance;
- ( void )displayMessage: ( NSString * )msg repeat: ( BOOL )repeat;
- ( void )stop;

@end
