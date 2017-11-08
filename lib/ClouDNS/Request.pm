package ClouDNS::Request;

use common::sense;

use Moose::Role;

use LWP::UserAgent;

use ClouDNS::Response;

has 'ua' => (
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    lazy    => 1,
    default => sub {

        my $ua = LWP::UserAgent->new;

        $ua->timeout(30);

        return $ua;
    },
);

has 'uri' => (
    is  => 'rw',
    isa => 'Maybe[URI]',
);

sub do_request {
    my ($self, $command, $params) = @_;

    $self->uri(URI->new($self->endpoint . $command));

    $self
        ->add_auth_params
        ->add_additional_params($params);

    return ClouDNS::Response->new( response => $self->ua->get($self->uri->as_string) );
}

sub add_auth_params {
    my ($self) = @_;

    $self->uri->query_form({
        'auth-id'       => $self->auth_id,
        'auth-password' => $self->auth_password,
    });

    return $self;
}

sub add_additional_params {
    my ($self, $params) = @_;

    $self->uri->query_form({
        $self->uri->query_form,
        %{ $params },
    });

    return $self;
}

1;
