package Math::Coprimes;

use 5.008008;
use strict;
use warnings;

use List::Util qw(max);

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.1';

sub new {
	my($this, @args) = @_;

	# We need at least two numbers:
	die "Math::Coprimes: Two arguments needed by the constructor!" if @args < 2;

	my $class = ref($this) || $this;

	my $self = {};
	$self->{numbers} = \@args;
	$self->{gcd} = undef;

	bless $self, $class;
	return ($self);
}

sub gcd {
	my $self = shift;

	my @numbers = @{ $self->{numbers} };
	my @compare;

	foreach my $number(@numbers) {
		$number = abs $number;
		my @divisors;
		for my $i (1..$number) {
			push(@divisors, $i) if $number % $i == 0;
		}
		push(@compare, @divisors);
	}

	my $count = @numbers;

	# Thanks for the tip to BinGOs from #perl at irc.freenode.net
	my %hash;
	$hash{$_}++ for @compare;
	my @repeats = grep { 
			$hash{$_} == @numbers
	} keys %hash;

	return max @repeats;

}

sub are_coprimes {
	my $self = shift;
	my $gcd = $self->gcd;
	if($gcd == 1) {
		return 1;
	} else {
		return 0;
	}
}

1;
__END__

=head1 NAME

Math::Coprimes - Calculate if two or more numbers are coprimes (relatively primes)

=head1 SYNOPSIS

  use Math::Coprimes;
  my $numbers = Math::Coprimes->new(-6, 6, 8);
  print "They are coprimes!\n" unless $numbers->are_coprimes == 0;

=head1 DESCRIPTION

From Wikipedia:
	In mathematics, the integers a and b are said to be coprime or relatively
	prime if they have no common factor other than 1 and −1, or equivalently,
	if their greatest common divisor is 1.

	For example, 6 and 35 are coprime, but 6 and 27 are not because they are
	both divisible by 3. The number 1 is coprime to every integer; 0 is coprime
	only to 1 and −1.

=head1 DEPENDENCIES

List::Util

=head1 DISCLAIMER

This is my first package written ever. I welcome any possible feedback.

=head1 BUGS

There might be bugs when using negative integers. I promise to take a look soon.

=head1 AUTHOR

David Moreno Garza, E<lt>damog@ciencias.unam.mx<gt>

=head1 THANKS TO

Thanks to Raquel for being my day to day inspiration. Thanks to the Science Faculty
at UNAM for providing such a beautiful career. And thanks also go to some other
people that challenged me (even if they don't know) to do this like Tato, Gunnar
and bureado: I love those bastards. Thanks also to the #perl dudes.

=head1 COPYRIGHT AND LICENSE

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

Copyright (C) 2007 David Moreno Garza

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO. 

=cut
