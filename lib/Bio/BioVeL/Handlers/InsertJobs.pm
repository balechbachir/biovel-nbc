package Bio::BioVeL::Handlers::InsertJobs;
use strict;
use warnings;
use XML::Quick;
use Bio::BioVeL::Job;
use Bio::BioVeL::JobArgs;
use Apache2::Request;
use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Const -compile => qw(OK);

sub handler {
	my $r = shift;
	my $req = Apache2::Request->new($r);
	
	# create or lookup a job
	my %args = map { $_ => $req->param($_) } $req->param;
	my $job = Bio::BioVeL::Job->new(%args); # just need NAME, really
		
	# job was newly instantiated
	if ( $job->status == LAUNCHING ) {
	
		# decode the arguments
		$job->arguments(Bio::BioVeL::JobArgs->new($args{'arguments'},$job));
		
		# launch
		$job->run;
	}

	# return result
	$r->content_type('application/xml');
	print xml({
		'Job' => {
			'Name'   => $job->name,
			'Flag'   => undef,
			'JobsID' => {
				'JobId' => $job->id,
			}
		}	
	});

	return Apache2::Const::OK;
}

1;