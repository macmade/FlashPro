/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseTableDataSource.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "MorseTableDataSource.h"

@implementation MorseTableDataSource

- ( id )init
{
    if ( ( self = [ super init ] ) )
    {
        defaults = [ NSUserDefaults standardUserDefaults ];
    }
    
    return self;
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell;
    NSArray         * snippets;
    UIImageView     * backgroundView;
    
    snippets = [ defaults objectForKey: @"morse-snippets" ];
    
    ( void )tableView;
    ( void )indexPath;
    
    cell = [ tableView dequeueReusableCellWithIdentifier: CellIdentifier ];
    
    if( cell == nil )
    {
        cell                           = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: CellIdentifier ];
        cell.textLabel.textColor       = [ UIColor colorWithHue: ( CGFloat )0.00 saturation: ( CGFloat )0.00 brightness: ( CGFloat )1.00 alpha: ( CGFloat )1.00 ];
        cell.textLabel.backgroundColor = [ UIColor colorWithHue: ( CGFloat )0.00 saturation: ( CGFloat )0.00 brightness: ( CGFloat )1.00 alpha: ( CGFloat )0.00 ];
        
        [ cell.textLabel setFont: [ UIFont boldSystemFontOfSize: 16 ] ];
        
        backgroundView      = [ [ UIImageView alloc ] initWithImage: [ UIImage imageNamed: @"cell" ] ];
        cell.backgroundView = backgroundView;
        
        [ backgroundView autorelease ];
        [ cell autorelease ];
    }
    
    cell.textLabel.text = [ snippets objectAtIndex: [ indexPath row ] ];
    
    return cell;

}

- ( NSInteger )tableView: ( UITableView * )tableView numberOfRowsInSection: ( NSInteger )section
{
    NSArray * snippets;
    
    snippets = [ defaults objectForKey: @"morse-snippets" ];
    
    ( void )tableView;
    ( void )section;
    
    return [ snippets count ];
}

- ( void )tableView: ( UITableView * )tableView commitEditingStyle: ( UITableViewCellEditingStyle )editingStyle forRowAtIndexPath: ( NSIndexPath * )indexPath
{
    NSMutableArray * snippets;
    
    if( editingStyle == UITableViewCellEditingStyleDelete )
    {
        snippets = [ [ defaults objectForKey: @"morse-snippets" ] mutableCopy ];
        
        [ snippets removeObjectAtIndex: [ indexPath row ] ];
        [ defaults setObject: snippets forKey: @"morse-snippets" ];
        [ defaults synchronize ];
        [ snippets release ];
        [ tableView reloadData ];
    }
}

- ( BOOL )tableView: ( UITableView * )tableView canMoveRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ( void )tableView;
    ( void )indexPath;
    
    return YES;
}

- ( void )tableView: ( UITableView * )tableView moveRowAtIndexPath: ( NSIndexPath * )fromIndexPath toIndexPath: ( NSIndexPath * )toIndexPath
{
    NSMutableArray * snippets;
    NSString       * text;
    
    snippets = [ [ defaults objectForKey: @"morse-snippets" ] mutableCopy ];
    text     = [ [ snippets objectAtIndex: [ fromIndexPath row ] ] retain ];
    
    [ snippets removeObjectAtIndex: [ fromIndexPath row ] ];
    [ snippets insertObject: text atIndex: [ toIndexPath row ] ];
    [ text release ];
    [ defaults setObject: snippets forKey: @"morse-snippets" ];
    [ defaults synchronize ];
    [ tableView reloadData ];
    [ snippets release ];
    [ tableView reloadData ];
}

@end
