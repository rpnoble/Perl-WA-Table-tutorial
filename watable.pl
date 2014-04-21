#!C:/strawberry/perl/bin/perl.exe

# =================================================================================================
# Script Name  : watable.pl
# Purpose      : Show how to push data to JQuery watable.js plugin 
# Author       : Richard Noble rpnoble@ibksoftware.com
# Date created : 04-20-2014
# Date updated : 
# Comments     :  Using the CSV example from: http://perlmaven.com/how-to-read-a-csv-file-using-perl
#              :  as my base.
# =================================================================================================
use strict;
use warnings;
use Text::CSV;
use JSON;
use CGI::Simple::Standard qw(param header url);
use CGI::Carp qw(fatalsToBrowser);

# define my vars
my $file = 'names.csv';
my @names;
my $jsonStructure;
my $json = new JSON;
my $col;
my $q = new CGI::Simple;
print $q->header();
 
my $csv = Text::CSV->new ({
  binary    => 1,
  auto_diag => 1,
  sep_char  => ','    # not really needed as this is the default
});
 
# the lines here read the data from the name.csv file
open(my $data, '<:encoding(utf8)', $file) or die "Could not open '$file' $!\n";
$csv->column_names ($csv->getline ($data)); # use header row to define column name  hash

while (my $row = $csv->getline_hr( $data )) {
  push @names, $row;   #data is now in a hash format of $row->{fieldname}
}
if (not $csv->eof) {
  $csv->error_diag();
}
close $data;

################################################################################
# build column data for the WA Table jquery plugin
# $col->{'FieldName'}->{'wa table property'} = value
# The FieldName must match the heading in the CSV file for the data to align
################################################################################
$col->{'BadgeID'}->{'index'}=0;                    
$col->{'BadgeID'}->{'type'}='number';              
$col->{'BadgeID'}->{'friendly'}='record number';            
$col->{'BadgeID'}->{'placeHolder'}='Filter By';    
$col->{'BadgeID'}->{'unique'}=JSON::true;            # wa table requires a unique ID to use it's row selection checkbox
$col->{'BadgeID'}->{'filterTooltip'}=JSON::false;  

$col->{'FirstName'}->{'index'}=1;                    # wa table column number
$col->{'FirstName'}->{'type'}='string';              # wa table column type. This defines what type of filter can be applied to the data
$col->{'FirstName'}->{'friendly'}='First Name';      # wa table column heading text
$col->{'FirstName'}->{'placeHolder'}='Filter By';    # wa table filter text box placeholder text
$col->{'FirstName'}->{'unique'}=JSON::false;         # wa table unique flag. Needed if you will be working with checkboxes to select records
$col->{'FirstName'}->{'filterTooltip'}=JSON::false;  # wa table show or hide fliter tool tip

$col->{'LastName'}->{'index'}=2;                    
$col->{'LastName'}->{'type'}='string';              
$col->{'LastName'}->{'friendly'}='Last Name';       
$col->{'LastName'}->{'placeHolder'}='Filter By';    
$col->{'LastName'}->{'unique'}=JSON::false;         
$col->{'LastName'}->{'filterTooltip'}=JSON::false;  

$col->{'CompanyName'}->{'index'}=3;                    
$col->{'CompanyName'}->{'type'}='string';              
$col->{'CompanyName'}->{'friendly'}='Company Name';       
$col->{'CompanyName'}->{'placeHolder'}='Filter By';    
$col->{'CompanyName'}->{'unique'}=JSON::false;         
$col->{'CompanyName'}->{'filterTooltip'}=JSON::false;  

$col->{'Title'}->{'index'}=4;                    
$col->{'Title'}->{'type'}='string';              
$col->{'Title'}->{'friendly'}='Title';       
$col->{'Title'}->{'placeHolder'}='Filter By';    
$col->{'Title'}->{'unique'}=JSON::false;         
$col->{'Title'}->{'filterTooltip'}=JSON::false;  

$col->{'Address1'}->{'index'}=5;                    
$col->{'Address1'}->{'type'}='string';              
$col->{'Address1'}->{'friendly'}='Address line 1';       
$col->{'Address1'}->{'placeHolder'}='Filter By';    
$col->{'Address1'}->{'unique'}=JSON::false;         
$col->{'Address1'}->{'filterTooltip'}=JSON::false;  

$col->{'City'}->{'index'}=6;                    
$col->{'City'}->{'type'}='string';              
$col->{'City'}->{'friendly'}='City';       
$col->{'City'}->{'placeHolder'}='Filter By';    
$col->{'City'}->{'unique'}=JSON::false;         
$col->{'City'}->{'filterTooltip'}=JSON::false;  

$col->{'State'}->{'index'}=7;                    
$col->{'State'}->{'type'}='string';              
$col->{'State'}->{'friendly'}='State';       
$col->{'State'}->{'placeHolder'}='Filter By';    
$col->{'State'}->{'unique'}=JSON::false;         
$col->{'State'}->{'filterTooltip'}=JSON::false;  

$col->{'Zip'}->{'index'}=8;                    
$col->{'Zip'}->{'type'}='string';              
$col->{'Zip'}->{'friendly'}='Zip Code';       
$col->{'Zip'}->{'placeHolder'}='Filter By';    
$col->{'Zip'}->{'unique'}=JSON::false;         
$col->{'Zip'}->{'filterTooltip'}=JSON::false;  

$col->{'phone'}->{'index'}=9;                    
$col->{'phone'}->{'type'}='string';              
$col->{'phone'}->{'friendly'}='Phone Number';       
$col->{'phone'}->{'placeHolder'}='Filter By';    
$col->{'phone'}->{'unique'}=JSON::false;         
$col->{'phone'}->{'filterTooltip'}=JSON::false;  

$col->{'Email'}->{'index'}=10;                    
$col->{'Email'}->{'type'}='string';              
$col->{'Email'}->{'friendly'}='Email Address';       
$col->{'Email'}->{'placeHolder'}='Filter By';    
$col->{'Email'}->{'unique'}=JSON::false;         
$col->{'Email'}->{'filterTooltip'}=JSON::false;  

$col->{'BadgeType'}->{'index'}=11;                    
$col->{'BadgeType'}->{'type'}='string';              
$col->{'BadgeType'}->{'friendly'}='Badge Type';       
$col->{'BadgeType'}->{'placeHolder'}='Filter By';    
$col->{'BadgeType'}->{'unique'}=JSON::false;         
$col->{'BadgeType'}->{'filterTooltip'}=JSON::false;  

#Display this data if the Mode=1 else do not show this data....
if ($q->param('MODE') eq '1')
{

    $col->{'UF1'}->{'index'}=12;                    
    $col->{'UF1'}->{'type'}='string';              
    $col->{'UF1'}->{'friendly'}='Are you a member?';     # Notice the Firendly is very different from the Field Name       
    $col->{'UF1'}->{'placeHolder'}='Filter By';    
    $col->{'UF1'}->{'unique'}=JSON::false;         
    $col->{'UF1'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'UF2'}->{'index'}=13;                    
    $col->{'UF2'}->{'type'}='string';              
    $col->{'UF2'}->{'friendly'}='Do want to become a member?';            
    $col->{'UF2'}->{'placeHolder'}='Filter By';    
    $col->{'UF2'}->{'unique'}=JSON::false;         
    $col->{'UF2'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'UF3'}->{'index'}=14;                    
    $col->{'UF3'}->{'type'}='string';              
    $col->{'UF3'}->{'friendly'}='How did you hear about this event?';            
    $col->{'UF3'}->{'placeHolder'}='Filter By';    
    $col->{'UF3'}->{'unique'}=JSON::false;         
    $col->{'UF3'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'UF4'}->{'index'}=15;                    
    $col->{'UF4'}->{'type'}='string';              
    $col->{'UF4'}->{'friendly'}='How did you get to this event?';            
    $col->{'UF4'}->{'placeHolder'}='Filter By';    
    $col->{'UF4'}->{'unique'}=JSON::false;         
    $col->{'UF4'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'DateAdded'}->{'index'}=16;                    
    $col->{'DateAdded'}->{'type'}='date';                # wa table column change
    $col->{'DateAdded'}->{'friendly'}='Date Added';            
    $col->{'DateAdded'}->{'placeHolder'}='Filter By';    
    $col->{'DateAdded'}->{'unique'}=JSON::false;         
    $col->{'DateAdded'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'DateUpdate'}->{'index'}=17;                    
    $col->{'DateUpdate'}->{'type'}='date';              
    $col->{'DateUpdate'}->{'friendly'}='Date of last update';            
    $col->{'DateUpdate'}->{'placeHolder'}='Filter By';    
    $col->{'DateUpdate'}->{'unique'}=JSON::false;         
    $col->{'DateUpdate'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'PrintDate'}->{'index'}=18;                    
    $col->{'PrintDate'}->{'type'}='date';              
    $col->{'PrintDate'}->{'friendly'}='Last Badge Print';            
    $col->{'PrintDate'}->{'placeHolder'}='Filter By';    
    $col->{'PrintDate'}->{'unique'}=JSON::false;         
    $col->{'PrintDate'}->{'filterTooltip'}=JSON::false;  
    
    $col->{'BadgesPrinted'}->{'index'}=19;                    
    $col->{'BadgesPrinted'}->{'type'}='number';              
    $col->{'BadgesPrinted'}->{'friendly'}='Number of badges printed';            
    $col->{'BadgesPrinted'}->{'placeHolder'}='Filter By';    
    $col->{'BadgesPrinted'}->{'unique'}=JSON::false;         
    $col->{'BadgesPrinted'}->{'filterTooltip'}=JSON::false;  
}




#create the JSON data to pass back to the web server
$jsonStructure->{success} = JSON::true;
$jsonStructure->{cols} = $col if $col;
$jsonStructure->{rows} = \@names if @names;

my $prettyJson = $json->encode($jsonStructure);
print $prettyJson."\n";
exit;

