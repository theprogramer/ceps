CEPs
====

Ceps is a collection of all sorts of useful information about every brazilian CEP packaged as pretty little cep objects.

[![Build Status](https://travis-ci.org/theprogramer/ceps.png)](https://travis-ci.org/theprogramer/ceps)
[![Code Climate](https://codeclimate.com/github/theprogramer/ceps/badges/gpa.svg)](https://codeclimate.com/github/theprogramer/ceps)
[![Test Coverage](https://codeclimate.com/github/theprogramer/ceps/badges/coverage.svg)](https://codeclimate.com/github/theprogramer/ceps/coverage)

Installation
------------

    gem install ceps

Basic Usage
-----------

Simply load a new CEP object using Cep.new(23045000) or the shortcut Cep[23045000].

    c = Cep.new(23045400)
    c = Cep.new[23045400]

Cep Info
--------

  Address

    c.location     #=> "Peter Pan"
    c.type         #=> "Rua"
    c.neighborhood #=> "Campo Grande"
    c.city         #=> "Rio de Janeiro"
    c.state        #=> "Rio de Janeiro"

ToDo
----

* Geocoding
* Tests
* Import scripts

Note about GPBe (Guia Postal Brasileiro Eletrônico)
---------------------------------------------------

To generate ceps.yaml data file it is necessary get a valid version of a GPBe.
GPBe is property of Correios do Brasil SA.
