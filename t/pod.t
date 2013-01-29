#!perl -T
use Test::Base;

if (! -e '.author') {
    plan skip_all => "-e '.author'";
}
eval "use Test::Pod 1.14";
if ($@) {
    plan skip_all => "Test::Pod 1.14 required for testing POD";
}

all_pod_files_ok();
