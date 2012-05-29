use Test::More import => ['!pass'],  tests => 4;

use strict;
use warnings;

use Dancer::Session::DBI;
use Dancer qw(:syntax);



# ONE
eval {
    set session => 'DBI';
};
like $@, qr{No database handle and no valid DSN specified}i,
    'Should fail when no settings specified';



# TWO
eval {
    set 'session_options' => {
        dsn => 'Invalid',
    };
    set session => 'DBI';
};
like $@, qr{No database handle and no valid DSN specified}i,
    'Should fail on invalid DSN';



# THREE
eval {
    set 'session_options' => {
        dsn => 'DBI:MyDriver(RaiseError=>1):db=test;port=42'
    };
    set session => 'DBI';
};
like $@, qr{Valid DSN specified, but no user or password specified}i,
    'Should fail with no user or password';



# FOUR
eval {
    set 'session_options' => {
        table    => '',
        dbh      => 'Handle',
        user     => 'user',
        password => 'password'
    };
    set session => 'DBI';
};
like $@, qr{No table selected for session storage}i,
    'Should fail with no table selected';

