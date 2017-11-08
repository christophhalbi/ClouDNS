package ClouDNS;

use common::sense;

use Moose;

use ClouDNS::DNSZone;
use ClouDNS::DNSZones;

with 'ClouDNS::Authorization';

sub dns_zone {
    my ($self, $domain) = @_;

    die "no domain-name" unless $domain;

    return ClouDNS::DNSZone->new(
        auth_id       => $self->auth_id,
        auth_password => $self->auth_password,
        domain        => $domain,
    );
}

sub dns_zones {
    my ($self) = @_;

    return ClouDNS::DNSZones->new(
        auth_id       => $self->auth_id,
        auth_password => $self->auth_password,
    );
}

1;
