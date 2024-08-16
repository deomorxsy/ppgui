#!/usr/bin/env perl
use v5.38;

use strict;
use warnings;

use feature qw/ state /;

use FindBin qw/ $Bin /;
use Template;
use Plack::Request;
use Plack::Response;

#use Plack::App::Directory;

my $wasm_dir = "./glfw/web/index.wasm"

# pass directory as argument (argv)
my $WEB_DIR = shift @ARGV or die "Usage: $0 /path/to/html\n";

#print <<'END';
#Status: 200
#Content-type: text/html

#<!DOCTYPE HTML>
#<html> HTML goes here </html>
# END

# HTTP server class
{
    my $app = sub {
        my $env = shift;
        my $req = Plack::Request ->new($env);
        my $res = Plack::Response ->new(200);

        my $path = $req->path_info();
        my $full_path = $WEB_DIR . $path;

        if ( -f $full_path ) {
            print "HTTP/1.0 200 OK\r\n";
            print $cgi->header( -type => "text/html" )
            open( my $fh, '<', $full_path ) or die "Cannot open file: $!";
            print <$fh>;
            close $fh;
        }
        else {
            print "HTTP/1.0 404 Not Found\r\n";
            print $cgi->header( -type => "text/plain" );
            print "File not found: $path\n";
        }
    }

my $server = MyWebServer->new(8080);
$server->run();

sub podman_cmd() {
    return (
        qw(podman run --rm -it),
        '--env-host=false',
        generate_lib_maps()->@*,
        ('--workdir', '/workingdir'),
        '--network=none',
        ('-v', '.:/workingdir/'),
        get_image(),
        BIN,
        '-Mlibreplace',
        @ARGV
    );
 }
}



