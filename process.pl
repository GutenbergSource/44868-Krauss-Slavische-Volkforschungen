use strict;

my $saxon   = "java.exe -jar C:\\bin\\saxonhe9\\saxon9he.jar "; # (see http://saxon.sourceforge.net/)

my $inputFile = "SlavischeVolkforschungen-1.0.tei";
my $outputFile = "SlavischeVolkforschungen-html-1.0.tei";
my $outputFileEpub = "SlavischeVolkforschungen-epub-1.0.tei";
my $outputFileEpubXml = "SlavischeVolkforschungen-epub.xml";

open(INPUTFILE, $inputFile) || die("Could not open $inputFile");
open(OUTPUTFILE, "> $outputFile") || die("Could not open $outputFile");
open(OUTPUTFILEEPUB, "> $outputFileEpub") || die("Could not open $outputFileEpub");

print STDERR "Processing $inputFile\n";

while (<INPUTFILE>) {
    my $line = $_;
    my $textLine = $line;

    $line =~ s/<PTABLE>/<table rend=\"class(bilingual)\">\n<row><cell lang=\"bs\">/;
    $line =~ s/<PCELL>/<cell>/;
    $line =~ s/<PROW>/<row><cell lang=\"bs\">/;
    $line =~ s/<\/PTABLE>/<\/table>/;

    $line =~ s/<XPTABLE>//;
    $line =~ s/<XPCELL>//;
    $line =~ s/<XPROW>//;
    $line =~ s/<\/XPTABLE>//;

    $textLine =~ s/<XPTABLE>//;
    $textLine =~ s/<XPCELL>//;
    $textLine =~ s/<XPROW>//;
    $textLine =~ s/<\/XPTABLE>//;

    $textLine =~ s/<PTABLE>//;
    $textLine =~ s/<PCELL>//;
    $textLine =~ s/<PROW>//;
    $textLine =~ s/<\/PTABLE>//;

    print OUTPUTFILE $line;
    print OUTPUTFILEEPUB $textLine;
}

close(OUTPUTFILEEPUB);
close(OUTPUTFILE);
close(INPUTFILE);

system ("perl -S tei2html.pl -h -v $outputFile");
system ("perl -S tei2html.pl -e $outputFileEpub");
