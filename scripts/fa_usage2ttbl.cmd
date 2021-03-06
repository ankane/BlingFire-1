@perl -Sx %0 %*
@goto :eof
#!perl


sub usage {

print <<EOM;

Usage: fa_usage2ttbl [OPTIONS] < usage.txt > ptbl.txt

Takes a program usage (in BlingFire format) and returns a tab separated tool
table. The columns are tool name, description.

EOM

}


while (0 < 1 + $#ARGV) {

    if("--help" eq $ARGV [0]) {

        usage ();
        exit (0);

    } elsif ($ARGV [0] =~ /^-.*/) {

        print STDERR "ERROR: Unknown parameter $$ARGV[0], see fa_usage2ttbl --help";
        exit (1);

    } else {

        last;
    }
    shift @ARGV;
}


#
# process the WTBT file
#

$tool = "";
$description = "";

while(<>) { 

    s/[\r\n]+$//;

    if (/^[ ]*[Uu]sage: ([^ ]+)/) {

      $tool = $1;
      $description = "";

    } elsif (/^([^ ].*)$/ && "" ne $tool) {

      $description .= (" " . $1);

    } elsif (/^[ ]*$/ && "" ne $tool && "" ne $description) {

      print $tool . "\t" . $description . "\n" ;

      $tool = "";
      $description = "";
    }
}

if("" ne $tool && "" ne $description) {
  print $tool . "\t" . $description . "\n" ;
}

