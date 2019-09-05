#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use Encode;

use JSON; # Debian: libjson-perl
use LWP::UserAgent ();

my $JSON = JSON->new->utf8;
my $station = shift;
die "Usage: $0 START-OF-STATION-NAME\n" unless defined $station;
$station = Encode::decode('UTF-8', $station);

my $url = 'http://wap.vasttrafik.se/AutoComplete.asmx/GetCompletionList';
my $limit = $station eq "" ? 11000 : 20; # 20 is used on the official page
my $json = $JSON->encode({"count" => $limit, "prefixText" => $station});

my $req = HTTP::Request->new(POST => $url);
$req->content_type('application/json');
$req->content($json);

my $ua = new LWP::UserAgent();
my $response = $ua->request($req);
#my $response = $ua->post($url, Content => $json);

if ($response->is_success()) {
    #print $response->content, "\n";
    my $resp_hash = $JSON->decode($response->content);
    foreach (@{$$resp_hash{'d'}}) {
        next unless /^\Q$station\E/i;
        print "$_\n";
    }
}
else {
    die("ERROR: " . $response->status_line());
}

