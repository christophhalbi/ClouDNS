package ClouDNS::DNSZones;

use common::sense;

use Moose;

with 'ClouDNS::Authorization';
with 'ClouDNS::Request';

has 'endpoint' => (
    is      => 'ro',
    isa     => 'Str',
    default => sub {

        return 'https://api.cloudns.net/dns/';
    },
);

sub list {
    my ($self, $page, $rows) = @_;

    $page ||= 1;
    $rows ||= 20;

    return $self->do_request('list-zones.json', {
        'page'          => $page,
        'rows-per-page' => $rows,
    });
}

sub create {
    my ($self, $domain, $type) = @_;

    die "no domain-name" unless $domain;

    $type ||= 'master';

    return $self->do_request('register.json', {
        'domain-name' => $domain,
        'zone-type'   => $type,
    });
}

1;
