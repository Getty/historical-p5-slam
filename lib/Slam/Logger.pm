package Slam::Logger;
use Slam;
use Moose::Role;
use namespace::autoclean;
use Moose::Exporter;

my @functions = qw(
  log
  debug
  info
  notice
  warning
  error
  critical
  alert
  emergency
);

Moose::Exporter->setup_import_methods(
	as_is     => [@functions],
);

requires @functions;

1;
__END__

