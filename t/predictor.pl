#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

use ISS::AH::Predictor;

plan tests => 1;

subtest 'should get model', sub {
  my $model = ISS::AH::Predictor::get_model(
    age           => 12,
    body_height   => 130,
    father_height => 180,
    bone_age      => 12,
    sex           => 'male',
  );
  ok $model, 'model retrieved';
  is $model->[0], 94.2381, 'intercept param as expected';

  $model = ISS::AH::Predictor::get_model(
    body_height   => 130,
    father_height => 180,
    bone_age      => 12,
    sex           => 'male',
  );
  ok !$model, 'missing required params, no model retrieved';

  $model = ISS::AH::Predictor::get_model(
    age           => 12,
    body_height   => 130,
    father_height => 180,
    bone_age      => 12,
    sex           => 'male',
    models        => [],
  );
  ok !$model, 'empty custom models, no model retrieved';

  $model = ISS::AH::Predictor::get_model(
    bone_age => 12,
    models   => [ [ 1, undef, undef, undef, undef, undef, 1 ] ],
  );
  ok $model, 'custom model retrieved';
  is $model->[0], 1, 'intercept param as expected';
};

done_testing;
