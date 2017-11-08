#!/usr/bin/perl

#
# © Xavier L'Heureux 2017
# RHP is the Rust Hypertext Preprocessor
# Read the readme for more info
# There isn't any warranty concerning this product
# It is release under the GNU license
#

# TODO:
# Add options

use File::Basename;
use strict;
use warnings;

# Global Variables
my $html;                    # Final html
my $main;                    # Content of the .rhp file to parse
my $includes;                # Modules to include
my $vars;                    # Vars to print in html
my $mainContent;             # Content of the main function before the final print

#Helpers
sub content_of_file{
    my $fileName = $_[0];
    open(my $fh, '<', $fileName) or die "cannot open file $fileName";
    {
        local $/; # ensure that the whole file is included, not just a line
        return <$fh>;
    }
    close($fh);
}

# Main file read
my $fileName = $ARGV[0];
$main = content_of_file($fileName);

#open files to includes
my @includes = $main =~ /(?<=<\?inc )\w+/g;

$includes = "";
foreach my $inc (@includes)
{
    if (-r dirname($fileName)."/$inc.rs") {
        my $incPath = dirname($fileName)."/$inc.rs"; # base directory + .rs file
        $includes .= "#[path = \"$incPath\"]\n"; # specify path
    } elsif (! -r "$inc.rs") {
        warn "Can't load file $inc.rs";
        next;
    }
	$includes .= "mod $inc;\n";
    $mainContent .= "\t$inc\:\:main();\n"
}

#html processing
$html = ($main =~ s/<\?inc .* \?>//rg); #remove includes
$html =~ s/<\?= .* \?>/{}/g; # remove prints
$html =~ s/\n\r|\r\n|\n|\r|\t| {2}//g; # minify

#variables processing
my @vars = ($main =~ /(?<=<\?= ).+(?= \?>)/g);
$vars = join ',', @vars;

#final output
print "$includes\nfn main(){\n$mainContent\n\tprint!(\"content-type: html\\n\\n$html\",$vars);\n}";
