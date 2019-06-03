<img src="/defra-ruby-validators.png" alt="Defra ruby validators logo" />

[![Build Status](https://travis-ci.com/DEFRA/defra-ruby-validators.svg?branch=master)](https://travis-ci.com/DEFRA/defra-ruby-validators)
[![Maintainability](https://api.codeclimate.com/v1/badges/a0f8611f1a879786f642/maintainability)](https://codeclimate.com/github/DEFRA/defra-ruby-validators/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a0f8611f1a879786f642/test_coverage)](https://codeclimate.com/github/DEFRA/defra-ruby-validators/test_coverage)
[![Gem Version](https://badge.fury.io/rb/defra_ruby_validators.svg)](https://badge.fury.io/rb/defra_ruby_validators)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

Package of validations commonly used in Defra Rails based digital services.

## Installation

Add this line to your application's Gemfile

```ruby
gem "defra_ruby_validators"
```

And then update your dependencies by calling

```bash
bundle install
```

## Usage

With this gem installed, a number of active model based validators become available.

### Companies House number

This validator checks the company registration number provided. Specifically it first checks that it matches a known format. All registration numbers are 8 characters long but can be formatted in the following ways.

- 09764739
- 10997904
- SC534714
- IP00141R

If the format is valid, it then makes a call to Companies House to validate that the number

- is recognised
- belongs to an 'active' company

A company can be in various states for example liquidation, which means for the purposes of Defra its not a valid entity. So we check the status along with the number as part of the validation.

Add it to your model or form object using

```ruby
validates :company_no, "defra_ruby/validators/companies_house_number": true
```

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
