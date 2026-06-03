use strict;
use warnings;
use feature qw/ state /;

use FindBin qw/ $Bin /;

use Template;
use Plack::Request;
use Plack::Response;

use Time::Piece;
use YAML::PP::LibYAML;

my $app = sub {
    my $yp = YAML::PP::LibYAML->new;
    my %config = %{$yp->load_file("$Bin/config.yml")};
    my @jpgs_list = @{$config{jpgs}};
    # a list of jpgs is much cheaper than downloading and checking each image
    my %jpg_check;
    @jpg_check{@jpgs_list} = ();
    my $WEB_BASE = $config{web_base_url};
    my $STORAGE_BASE = $config{storage_base_url};

    my $req = Plack::Request->new( shift );
    my $res = Plack::Response->new( 200 );

    my $comic_date_string = substr($req->path_info, 1);
    #      %F    is equivalent to ``%Y-%m-%d''.
    my $comic_t = Time::Piece->strptime($comic_date_string, "%F");
    #       basically, see man strftime
    my $long_date = $comic_t->strftime("%A, %B %e, %Y");
    $long_date =~ s/  / /; #because %e injects an unneeded space

    my $title = "Dilbert from ${long_date}";
    my $image = "$STORAGE_BASE${comic_date_string}";
    
    if (exists $jpg_check{$comic_date_string}) {
        $image .= ".jpg";
    }
    else {
        $image .= ".gif";
    }

    my $url = "$WEB_BASE${comic_date_string}";

    state $tt = Template->new({
        INCLUDE_PATH => "$Bin/templates",
    });

    my $out;

    $tt->process(
        "index.html.tt",
        {
            comic_title => $title,
            image_url => $image,
            comic_url => $url,
            year => $comic_t->year,
            month => $comic_t->mon-1, # because Javascript indexes them by 0
            day => $comic_t->mday,
        },
        \$out,
    ) or die $tt->error;

    $res->headers([ 'Content-Type' => 'text/html' ]);
    $res->body( $out );
    $res->finalize;
};