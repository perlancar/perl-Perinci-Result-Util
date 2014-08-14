package Perinci::Result::Util;

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       is_env_res
               );

# VERSION
# DATE

sub is_env_res {
    my $res = shift;

    return 0 unless ref($res) eq 'ARRAY';
    return 0 unless @$res <= 4;

    # check status
    return 0 unless defined($res->[0]) && $res->[0] =~ /\A[0-9]{1,3}\z/
        && $res->[0] >= 100 && $res->[0] < 599;

    # check message
    return 0 unless !ref($res->[1]);
    if (defined $res->[1]) {
        return 0 unless $res->[1] =~ /[A-Za-z]/;
    }

    # check result metadata
    return 0 if defined($res->[3]) && ref($res->[3]) ne 'HASH';

    1;
}

1;
# ABSTRACT: Utilities related to enveloped result

=head1 SYNOPSIS

 use Perinci::Result::Util qw(is_env_res);

 say is_env_res([200, "OK"]); # 1
 say is_env_res("ok");        # 0
 say is_env_res([1, 2, 3]);   # 0


=head1 FUNCTIONS

=head2 is_env_res($res) => BOOL

Return true if C<$res> looks like enveloped result. It employs some heuristics.


=head1 SEE ALSO

L<Rinci::function>

=cut
