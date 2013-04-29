/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseViewController.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "MorseViewController.h"
#import "MorseTableDataSource.h"
#import "MorseTableDelegate.h"
#import "MorseEditViewController.h"
#import "MorseHelper.h"

@implementation MorseViewController

@synthesize table;
@synthesize addButton;
@synthesize editButton;

- ( id )initWithCoder: ( NSCoder * )aDecoder
{
    if( ( self = [ super initWithCoder: aDecoder ] ) )
    {
        tableDataSource = [ MorseTableDataSource new ];
        tableDelegate   = [ MorseTableDelegate new ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ table                release ];
    [ tableDataSource      release ];
    [ tableDelegate        release ];
    
    [ super dealloc ];
}

- ( void )viewDidAppear: ( BOOL )animated
{
    ( void )animated;
    
    [ table setDataSource: tableDataSource ];
    [ table setDelegate:   tableDelegate ];
    [ table reloadData ];
}

- ( void )viewDidLoad
{
    [ super viewDidLoad ];
    
    table.rowHeight = 50;
}

- ( BOOL )shouldAutorotateToInterfaceOrientation: ( UIInterfaceOrientation )interfaceOrientation
{
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

- ( void )didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ];
}

- (void)viewDidUnload
{
    [ super viewDidUnload ];
}

- ( void )viewWillDisappear: ( BOOL )animated
{
    ( void )animated;
    
    [ tableDelegate morseCodeEnd: nil ];
    [ [ MorseHelper sharedInstance ] stop ];
}

- ( IBAction)add: ( id )sender
{
    MorseEditViewController * edit;
    
    ( void )sender;
    
    edit                      = [ MorseEditViewController new ];
    edit.navigationController = self.navigationController;
    edit.tableView            = self.table;
    
    [ tableDelegate morseCodeEnd: nil ];
    [ [ MorseHelper sharedInstance ] stop ];
    [ self.navigationController pushViewController: edit animated: YES ];
}

- ( IBAction)edit: ( id )sender
{
    ( void )sender;
    
    [ tableDelegate morseCodeEnd: nil ];
    [ [ MorseHelper sharedInstance ] stop ];
    [ editButton setStyle: UIBarButtonItemStyleDone ];
    [ editButton setTitle: NSLocalizedString( @"Done", nil ) ];
    [ editButton setAction: @selector( endEdit: ) ];
    [ addButton setEnabled: NO ];
    [ table setEditing: YES animated: YES ];
}

- ( IBAction)endEdit: ( id )sender
{
    ( void )sender;
    
    [ editButton setStyle: UIBarButtonItemStyleBordered ];
    [ editButton setTitle: NSLocalizedString( @"Edit", nil ) ];
    [ editButton setAction: @selector( edit: ) ];
    [ addButton setEnabled: YES ];
    [ table setEditing: NO animated: YES ];
}

@end
