use inc::Module::Install;
  
# Define metadata
name		'Slam';
all_from	'lib/Slam.pm';
author		'Torsten Raudssus';
license		'perl';

# Specific dependencies
requires	'5.010';
requires	'Moose';
requires	'POE';
requires	'POE::Component::IKC';
requires	'XML::SAX';
requires	'Template';
requires	'MooseX::LogDispatch::Levels';
requires	'MooseX::Getopt';
test_requires	'Test::More';

install_script	'slam';
install_script	'slamdunk';

auto_license;

WriteAll;
