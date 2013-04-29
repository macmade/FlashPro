/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseEditViewController.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "MorseEditViewController.h"

@implementation MorseEditViewController

@synthesize textView;
@synthesize navigationController;
@synthesize tableView;

- ( id )init
{
    if( ( self = [ super initWithNibName: @"MorseEditView" bundle: nil ] ) )
    {
        defaults = [ NSUserDefaults standardUserDefaults ];
    }
    
    return self;
}

-( IBAction )cancel: ( id )sender
{
    ( void )sender;
    
    [ textView resignFirstResponder ];
    [ navigationController popViewControllerAnimated: YES ];
}

-( IBAction )save: ( id )sender
{
    NSMutableArray * snippets;
    
    ( void )sender;
    
    if( [ textView.text length ] > 0 )
    {
        snippets = [ [ defaults objectForKey: @"morse-snippets" ] mutableCopy ];
        
        [ snippets addObject: textView.text ];
        [ defaults setObject: [ NSArray arrayWithArray: snippets ] forKey: @"morse-snippets" ];
        [ defaults synchronize ];
        [ snippets release ];
    }
    
    [ textView resignFirstResponder ];
    [ navigationController popViewControllerAnimated: YES ];
    [ tableView reloadData ];
}

- ( void )viewDidAppear: ( BOOL )animated
{
    ( void )animated;
    
    [ textView becomeFirstResponder ];
}

@end
