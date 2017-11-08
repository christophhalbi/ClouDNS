package ClouDNS::Response;

use common::sense;

use Moose;

use JSON qw(from_json);

has 'response' => (
    is  => 'rw',
    isa => 'HTTP::Response',
);

sub data {
    my $self = shift;

    return from_json($self->response->decoded_content);
}

sub success_by_status {
    my $self = shift;

    my $data = $self->data;

    return unless $data->{status};

    return 1 if $data->{status} eq 'Success';
}

1;
