use strict;
use warnings;
use Test::More tests => 7;
use HTTP::Response;


use_ok( 'P5kkelabels' );

my $api_user = '-- API USER --';
my $api_key = ' -- API KEY --';

ok (my $lbl = P5kkelabels->new(api_user => $api_user, api_key => $api_key), "New P5kkelabel");

ok($lbl->token, 'There is a token');

# Find some points
for my $method (qw/ gls_droppoints pdk_droppoints dao_droppoints pickup_points /) {
    my $params = {zipcode => 2000};
    $params->{agent} = 'dao' if $method eq 'pickup_points';
    ok(my $points = $lbl->$method($params), "$method");
}

