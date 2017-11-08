package ClouDNS::DNSZone;

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

has 'domain' => (
    is  => 'ro',
    isa => 'Str',
);

sub records {
    my ($self) = @_;

    return $self->do_request('records.json', {
        'domain-name' => $self->domain,
    });
}

sub create_record {
    my ($self, $host, $type, $record, $ttl) = @_;

    die "no host"   unless $host;
    die "no type"   unless $type;
    die "no record" unless $record;

    $ttl ||= 60;

    return $self->do_request('add-record.json', {
        'domain-name' => $self->domain,
        'host'        => $host,
        'record-type' => $type,
        'record'      => $record,
        'ttl'         => $ttl,
    });
}

1;
