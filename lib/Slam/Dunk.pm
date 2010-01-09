package Slam::Dunk;

use Slam;
use MooseX::POE;

with qw(
	MooseX::Getopt
);

use POE::Component::IKC::Server;
use POE::Component::IKC::Specifier;

has port => (
	is => 'ro',
	isa => 'Int',
);

has socket => (
	is => 'ro',
	isa => 'Str',
	default => sub { 'slamdunk.sock' },
);

sub START {
	say "Start...";
	my ($kernel, $heap, $self) = @_[KERNEL, HEAP, OBJECT];
	my $service_name = "engine";
	$kernel->alias_set($service_name);
	my %ikcconfig = (
		name => 'slamdunk',
	);
	if ($self->port) {
		say "use port ".$self->port."...";
		$ikcconfig{port} = $self->port if ($self->port);
	} else {
		$ikcconfig{unix} = $self->socket;
	}
	POE::Component::IKC::Server->spawn(%ikcconfig);
	$kernel->call(IKC => publish => $service_name => ["start_slam"]);
}

event start_slam => sub {
	say "start_slam...";
	my ($kernel, $heap, $request) = @_[KERNEL, HEAP, ARG0];
	my ($data, $rsvp) = @$request;
	dump $rsvp;
	dump $data;
	$kernel->yield(answer_start_slam => $rsvp, "cool dude");
};

event answer_start_slam => sub {
	my ($kernel, $heap, $rsvp, $answer) = @_[KERNEL, HEAP, ARG0, ARG1];
	$kernel->call(IKC => post => $rsvp, $answer);
};

sub run {
	say "run...";
	$_[0]->new_with_options unless blessed $_[0];
	POE::Kernel->run;
}

__PACKAGE__->run unless caller;

1;
