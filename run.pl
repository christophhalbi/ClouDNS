
use common::sense;

use FindBin qw($Bin);

use lib "$Bin/lib";

use Data::Dumper;

use ClouDNS;


my $auth_id       = $ARGV[0];
my $auth_password = $ARGV[1];

my $cloudns = ClouDNS->new( auth_id => $auth_id, auth_password => $auth_password );

my $list = $cloudns->dns_zones->list->data;

warn Dumper($list);

warn $cloudns->dns_zones->create('foo.at')->success_by_status;

my $dns_zone = $cloudns->dns_zone('foo.at');

warn $dns_zone->create_record('foo.at', 'A', '81.19.152.35 ')->success_by_status;

warn Dumper($dns_zone->records->data);
