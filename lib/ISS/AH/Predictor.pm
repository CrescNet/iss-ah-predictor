package ISS::AH::Predictor;

use v5.10;

=head1 NAME

ISS::AH::Predictor - Provides prediction models for adult height (AH) in patients with idiopathic short stature (ISS).

=cut

our $VERSION = '0.1.0';


=head1 SYNOPSIS

  use ISS::AH::Predictor;

=head1 ATTRIBUTES

=head2 parameters

This attribute contains the default parameters, estimated by Blum et al.

  my $parameters = ISS::AH::Predictor::PARAMETERS;

  # each element of the $parameters arrayref is an arrayref with estimated parameters of one model
  $parameters->[0]->[0]; # first parameter (intercept) of the first model

=cut

our $parameters = [
  [ 63.3339,  -2.9595, 0.7256, 0.3173,  undef,  undef, -13.0399, 1.2695,  -6.2213 ],
  [ 62.1795,  -2.9892, 0.7328, 0.3442,  undef,  undef, -12.6821,  undef,  -6.3021 ],
  [ 50.3654,  -2.6372, 0.6408, 0.3986,  undef,  undef,    undef,  undef,  -5.9171 ],
  [ 80.3645,  -3.4309, 0.8241,  undef, 0.2242,  undef, -15.1678, 1.2688, -10.2474 ],
  [ 83.4866,  -3.4717, 0.8374,  undef, 0.2234,  undef, -14.7156,  undef, -10.6257 ],
  [ 75.8792,  -3.1944, 0.7581,  undef, 0.2449,  undef,    undef,  undef, -10.9519 ],
  [ 93.2475,  -3.4020, 0.8239,  undef,  undef, 0.1203, -14.2739, 1.6156, -10.0340 ],
  [ 94.2381,  -3.5784, 0.8759,  undef,  undef, 0.1348, -14.2476,  undef, -10.5319 ],
  [ 84.3600,  -3.2207, 0.7623,  undef,  undef, 0.1775,    undef,  undef, -10.8759 ],
  [ 110.8863, -4.1250, 0.9661,  undef,  undef,  undef, -16.0541,  undef, -10.4331 ],
];

=head1 SUBROUTINES/METHODS

=head2 predict

Provide a hash with properties of a subject to predict adult height (AH).

  my $ah = ISS::AH::Predictor::predict(
    age           => ...,
    body_height   => ...,
    target_height => ...,
    mother_height => ...,
    father_height => ...,
    bone_age      => ...,
    birth_weight  => ...,
    sex           => ...,
  );

=cut

sub predict {
  my %params = @_;
  my $model = get_model(%params) or return undef;
}

=head2 get_model

Returns an appropriate model with a set of parameters for the given subject properties.
The returned model is determined by the amount of available parameters.

If no model is appropriate, the result is undef.
If there are multiple matching models (with identical parameter count), the first one will be returned.
If the model contains undef parameters, they will be replaced with zeros (0).

  my $model = ISS::AH::Predictor::get_model(
    age           => ...,
    body_height   => ...,
    target_height => ...,
    mother_height => ...,
    father_height => ...,
    bone_age      => ...,
    birth_weight  => ...,
    sex           => ...,
  );

=cut

sub get_parameters {
  my %params = @_;
}

=head1 AUTHOR

Christoph Beger, C<< <christoph.beger at medizin.uni-leipzig.de> >>

=cut
