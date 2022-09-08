# iss-ah-predictor

Blum et al. [[1](#references)] developed a set of algorithms for the prediction of adult height (AH) in patients with idiopathic short stature (ISS), based on a German-Dutch cohort. The iss-ah-predictor is a convenient Perl implementation of these algorithms.

Depending of the amount of available patient properties, a specific set of parameters is used to calculate AH. The following properties are used in the algorithms:

| property                               | unit         | LOINC code                           | hash key for perl functions |
| -------------------------------------- | ------------ | -------------------------------------| -------------------------- |
| chronological age                      | years        | [30525-0](https://loinc.org/30525-0) | age                        |
| body height at baseline                | cm           | [3137-7](https://loinc.org/3137-7)   | body_height                |
| Tanner target height [[2](references)] | cm           |                                      | target_height              |
| mother height                          | cm           | [83846-6](https://loinc.org/83846-6) | mother_height              |
| father height                          | cm           | [83845-8](https://loinc.org/83845-8) | father_height              |
| bone age                               | years        | [85151-9](https://loinc.org/85151-9) | bone_age                   |
| birth weight                           | kg           | [8339-4](https://loinc.org/8339-4)   | birth_weight               |
| sex                                    | male, female | [46098-0](https://loinc.org/46098-0) | sex                        |

## Installation

```sh
cpan Iss::Ah::Predictor
```

After installing, you can find documentation for this module with the
perldoc command.

```sh
perldoc Iss::Ah::Predictor
```

You can also look for information at:

    Search CPAN
        http://search.cpan.org/dist/iss-ah-predictor/

### Build from Source

```sh
perl Makefile.PL
make
make test
make install
```

## Usage

Just call `ISS::AH::Predictor::predict(...)` and provide property values from the table above. The function will pick an appropriate parameter set and will calculate the adult height.

```perl
my $prediction = ISS::AH::Predictor::predict(
  age           => 12,
  body_height   => 130,
  father_height => 180,
  bone_age      => 12,     # will be converted with property age to bone_age_per_age
  sex           => 'male', # 'male' or 'female'
); # => adult height prediction: 164.6488 cm
```

You can also provide custom module parameters via hash key "models":

```perl
my $prediction = ISS::AH::Predictor::predict(
  age           => 12,
  body_height   => 130,
  father_height => 180,
  bone_age      => 12,
  sex           => 'male',
  models        => [
    [ 63.3339,  -2.9595, 0.7256, 0.3173, undef,  undef,  -13.0399, 1.2695, -6.2213 ], # parameters of model 1
    [ 62.1795,  -2.9892, 0.7328, 0.3442, undef,  undef,  -12.6821, undef,  -6.3021 ], # parameters of model 2
  ],
);
```

### Models must be provided as follows:

Each model parameter set is enclosed in an arrayref. The index of the parameter in this arrayref determines for which property the parameter is used.
The order is defined by the constant `ISS::AH::Predictor::PARAMETER_NAMES`:

```perl
use constant PARAMETER_NAMES => {
  0 => 'intercept',
  1 => 'age',
  2 => 'body_height',
  3 => 'target_height',
  4 => 'mother_height',
  5 => 'father_height',
  6 => 'bone_age_per_age',
  7 => 'birth_weight',
  8 => 'sex',
};
```

## References

**[1]** Blum WF, Ranke MB, Keller E, Keller A, Barth S, de Bruin C, Wudy SA, Wit JM. *A Novel Method for Adult Height Prediction in Children With Idiopathic Short Stature Derived From a German-Dutch Cohort.* Journal of the Endocrine Society, Volume 6, Issue 7, July 2022, bvac074. https://doi.org/10.1210/jendso/bvac074

**[2]** Tanner JM, Goldstein H, Whitehouse RH. *Standards for Children's Height at Ages 2-9 Years Allowing for Height of Parents.* Archives of Disease in Childhood, 1970, 45:755-762. https://doi.org/10.1136/adc.45.244.755

## License and Copyright

Copyright (C) 2017-2022 CrescNet, Leipzig University

This program is released under the following license: MIT
