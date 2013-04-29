/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseTableDelegate.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "MorseTableDelegate.h"
#import "MorseHelper.h"

@implementation MorseTableDelegate

- ( id )init
{
    if ( ( self = [ super init ] ) )
    {
        [ [ NSNotificationCenter defaultCenter ] addObserver: self selector: @selector( morseCodeEnd: ) name: @"MorseCodeEnded" object: [ MorseHelper sharedInstance ] ];
    }
    
    return self;
}

- ( void )tableView: ( UITableView * )tableView willBeginEditingRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ( void )tableView;
    ( void )indexPath;
}

- ( void )tableView: ( UITableView * )tableView didSelectRowAtIndexPath: ( NSIndexPath * )indexPath
{
    NSArray         * snippets;
    NSString        * text;
    UITableViewCell * cell;
    
    [ tableView deselectRowAtIndexPath: indexPath animated: YES ];
    
    cell = [ tableView cellForRowAtIndexPath: indexPath ];
    
    if( cell == currentCell )
    {
        [ self morseCodeEnd: nil ];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        currentCell        = cell;
        snippets           = [ [ NSUserDefaults standardUserDefaults ] objectForKey: @"morse-snippets" ];
        text               = [ snippets objectAtIndex: [ indexPath row ] ];
        
         [ [ MorseHelper sharedInstance ] displayMessage: text repeat: NO ];
    }
}

- ( void )morseCodeEnd: ( id )nothing
{
    ( void )nothing;
    
    [ [ MorseHelper sharedInstance ] stop ];
    
    currentCell.accessoryType = UITableViewCellAccessoryNone;
    currentCell               = nil;
}

@end
