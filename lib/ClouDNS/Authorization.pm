package ClouDNS::Authorization;

use common::sense;

use Moose::Role;

has 'auth_id' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'auth_password' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;
