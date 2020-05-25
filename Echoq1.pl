#!/usr/bin/perl -w
use strict;
use SOAP::Lite;
use SOAP::Transport::HTTP;

my $port = shift;

my $soapServer = SOAP::Transport::HTTP::Daemon
        -> new ( LocalPort => $port )
        -> dispatch_to ( qw(echoString) )
        -> on_action (
                sub
                {
                        die "SOAPAction should be \"http://soapinterop.org/\"\n"
                                unless $_[0] eq '"http://soapinterop.org/"';
                });

print "Starting SOAP server on URL: ".$soapServer->url."\n";
$soapServer->handle;

sub echoString
{
        # Receives a string and echoes it back in uppercase
        my ($class, $inputString) = @_;
        die "no input provided\n" if !$inputString;
        return SOAP::Data->name('return')->type('string')->value(uc($inputString));
}
