package Bio::BioVeL::Job::nexmlmerge;
use strict;
use warnings;
use Bio::BioVeL::Job;
use base 'Bio::BioVeL::Job';

sub exe { 'biovel_nexmlmerge.pl' }

sub fileparams { qw[tree data meta] }

1;