/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseHelper.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "MorseHelper.h"
#import "FlashHelper.h"

#define MORSE_DOT       0
#define MORSE_DASH      1
#define MORSE_DOT_TIME  0.2

static MorseHelper * __sharedInstance = nil;

MorseCode codes[ 36 ] =
{
    { 'A', 2, MORSE_DOT  | ( MORSE_DASH << 1 ) },
    { 'B', 4, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'C', 4, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'D', 3, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) },
    { 'E', 1, MORSE_DOT },
    { 'F', 4, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'G', 3, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) },
    { 'H', 4, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'I', 2, MORSE_DOT  | ( MORSE_DOT  << 1 ) },
    { 'J', 4, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) },
    { 'K', 3, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) },
    { 'L', 4, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'M', 2, MORSE_DASH | ( MORSE_DASH << 1 ) },
    { 'N', 2, MORSE_DASH | ( MORSE_DOT  << 1 ) },
    { 'O', 3, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) },
    { 'P', 4, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DOT  << 3 ) },
    { 'Q', 4, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DASH << 3 ) },
    { 'R', 3, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) },
    { 'S', 3, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) },
    { 'T', 1, MORSE_DASH },
    { 'U', 3, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) },
    { 'V', 4, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DASH << 3 ) },
    { 'W', 3, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) },
    { 'X', 4, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DASH << 3 ) },
    { 'Y', 4, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) },
    { 'Z', 4, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) },
    { '0', 5, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) | ( MORSE_DASH << 4 ) },
    { '1', 5, MORSE_DOT  | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) | ( MORSE_DASH << 4 ) },
    { '2', 5, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) | ( MORSE_DASH << 4 ) },
    { '3', 5, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DASH << 3 ) | ( MORSE_DASH << 4 ) },
    { '4', 5, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) | ( MORSE_DASH << 4 ) },
    { '5', 5, MORSE_DOT  | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) | ( MORSE_DOT  << 4 ) },
    { '6', 5, MORSE_DASH | ( MORSE_DOT  << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) | ( MORSE_DOT  << 4 ) },
    { '7', 5, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DOT  << 2 ) | ( MORSE_DOT  << 3 ) | ( MORSE_DOT  << 4 ) },
    { '8', 5, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DOT  << 3 ) | ( MORSE_DOT  << 4 ) },
    { '9', 5, MORSE_DASH | ( MORSE_DASH << 1 ) | ( MORSE_DASH << 2 ) | ( MORSE_DASH << 3 ) | ( MORSE_DOT  << 4 ) }
};

@interface MorseHelper( Private )

- ( void )displayCode: ( MorseCode * )code;
- ( void )displayMessage: ( const char * )str;
- ( void )displayMessageThreaded: ( NSArray * )options;

@end

@implementation MorseHelper( Private )

- ( void )displayCode: ( MorseCode * )code
{
    unsigned int i;
    
    for( i = 0; i < code->length; i++ )
    {
        if( shouldStop == YES )
        {
            break;
        }
        
        [ flash flashOn ];
        
        if( ( code->code >> i ) & 0x01 )
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME * 3 ];
        }
        else
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME ];
        }
        
        [ flash flashOff ];
        
        if( i < code->length - 1 )
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME ];
        }
    }
}

- ( void )displayMessage: ( const char * )str
{
    unsigned int j;
    size_t       i;
    size_t       length;
    
    length  = strlen( str );
    
    for( i = 0; i < length; i++ )
    {
        if( shouldStop == YES )
        {
            return;
        }
        
        if( str[ i ] == 0x20 )
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME * 7 ];
            
            continue;
        }
        else if( i > 0 )
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME * 3 ];
        }
        
        for( j = 0; j < 36; j++ )
        {
            if( codes[ j ].character == str[ i ] )
            {
                [ self displayCode: &( codes[ j ] ) ];
            }
        }
    }
}

- ( void )displayMessageThreaded: ( NSArray * )options
{
    NSAutoreleasePool * ap;
    NSString          * msg;
    const char        * str;
    BOOL                repeat;
    
    ap      = [ NSAutoreleasePool new ];
    msg     = ( NSString * )[ options objectAtIndex: 0 ];
    repeat  = [ ( NSNumber * )[ options objectAtIndex: 1 ] boolValue ];
    str     = [ [ msg uppercaseString ] cStringUsingEncoding: NSASCIIStringEncoding ];
    
    [ self displayMessage: str ];
    
    if( repeat == YES )
    {
        while( shouldStop == NO )
        {
            [ NSThread sleepForTimeInterval: MORSE_DOT_TIME * 7 ];
            [ self displayMessage: str ];
        }
    }
    
    shouldStop = NO;
    running    = NO;
    
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"MorseCodeEnded" object: self ];
    [ ap release ];
}

@end

@implementation MorseHelper

+ ( MorseHelper * )sharedInstance
{
    @synchronized( self )
    {
        if( __sharedInstance == nil )
        {
            [ [ self alloc ] init ];
        }
    }
    
    return __sharedInstance;
}

+ ( id )allocWithZone:( NSZone * )zone 
{
    @synchronized( self )
    {
        __sharedInstance = [ super allocWithZone: zone ];
        
        return __sharedInstance;
    }
}

- ( id )copyWithZone:( NSZone * )zone 
{
    ( void )zone;
    
    return self;
}

- ( id )retain
{
    return self;
}

- ( NSUInteger )retainCount
{
    return UINT_MAX;
}

- ( oneway void )release
{}

- ( id )autorelease
{
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

- ( id )init
{
    if( ( self = [ super init ] ) )
    {
        flash      = [ FlashHelper sharedInstance ];
        shouldStop = NO;
        running    = NO;
    }
    
    return self;
}

- ( void )displayMessage: ( NSString * )msg repeat: ( BOOL )repeat
{
    NSArray * options;
    
    options = [ NSArray arrayWithObjects: msg, [ NSNumber numberWithBool: repeat ], nil ];
    running = YES;
    
    [ NSThread detachNewThreadSelector: @selector( displayMessageThreaded: ) toTarget: self withObject: options ];
}

- ( void )stop
{
    if( running == YES )
    {
        shouldStop = YES;
        
        while( running == YES )
        {
            [ NSThread sleepForTimeInterval: 0.1 ];
        }
    }
}

@end
