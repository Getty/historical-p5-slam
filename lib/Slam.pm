package Slam;
our $VERSION = '0.0.1';

use Moose ();
use Moose::Exporter;
use Data::Dumper;

Moose::Exporter->setup_import_methods(
	with_meta => [],
	as_is	  => [qw( say dump )],
	also      => [qw( Moose )],
);

sub say {
	print @_, "\n";
}

sub dump {
	say Dumper @_;
}

1;
