package Slam::Client;

use Slam;
use POE::Component::IKC::ClientLite;

with qw(
	MooseX::Getopt
);

has name => (
	isa => 'Str',
	is => 'ro',
	default => sub { "slamclient$$" },
);

has port => (
	isa => 'Int',
	is => 'ro',
	required => 1,
);

has ikc => (
	isa => 'POE::Component::IKC::ClientLite',
	is => 'ro',
	lazy_build => 1,
	builder => 'call_create_ikc_client',
);

sub call_create_ikc_client {
	my $self = shift;
	my $remote = create_ikc_client(
		port => $self->port,
		name => $self->name,
		timeout => 30,
	);
	die $POE::Component::IKC::ClientLite::error unless $remote;
	return $remote;
}

sub BUILD {
	my $self = shift;
	my $return = $self->ikc->post_respond('engine/start_slam', "123");
	die $POE::Component::IKC::ClientLite::error unless defined $return;
	dump $return;
}

1;
