/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseEditViewController.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface MorseEditViewController: UIViewController
{
@protected
    
    UINavigationController * navigationController;
    UITextView             * textView;
    NSUserDefaults         * defaults;
    UITableView            * tableView;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet UITextView             * textView;
@property( assign,    readwrite )       UINavigationController * navigationController;
@property( assign,    readwrite )       UITableView            * tableView;

-( IBAction )cancel: ( id )sender;
-( IBAction )save: ( id )sender;

@end
