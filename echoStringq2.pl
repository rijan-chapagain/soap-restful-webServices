#!/usr/bin/perl -w
use strict;
use SOAP::Lite;

my $url = shift;

my $inputString="hello";

my $inputSoapParam = SOAP::Data
	-> name ('inputString')
	-> type ('string')
	-> value ($inputString);

my $response = SOAP::Lite
	-> proxy($url)
	-> uri('http://soapinterop.org/')
	-> on_action( sub { '"http://soapinterop.org/"' } )
	-> echoString ($inputSoapParam);

if ($response->fault)
{
	print "SOAP Fault received.\n\n" ;
	print "Fault Code   : ".$response->faultcode."\n";
	print "Fault String : ".$response->faultstring."\n";
	print "Fault Actor  : ".$response->faultactor."\n";
	die;
}

my @data = $response->result;
# print "response: $response \n";
print "Datas are: $data[0] + 2nd is: $data[1] \n";
	# print "your data are:  $d\n";

print "Sent '".$inputString."', received uppercase '".$data[0]."'\n";
print "Sent '".$inputString."', received '".$data[1]."'\n";

