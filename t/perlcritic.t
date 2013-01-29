#!perl
use Test::Base;

if (! -e '.author') {
    Test::Base::plan(skip_all => "-e '.author'");
}
if (require Test::Perl::Critic) {
    my @arg;
    push @arg, -profile => 't/perlcriticrc' if -e 't/perlcriticrc';
    Test::Perl::Critic->import(@arg, -theme => 'pbp');
}
else {
    Test::Base::plan(
        skip_all => "Test::Perl::Critic is not installed"
    );
}

Test::Perl::Critic::all_critic_ok();
