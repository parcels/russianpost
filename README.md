# Russian Post API Client

[![Build Status](https://travis-ci.org/artemshitov/russianpost.png?branch=master)](https://travis-ci.org/artemshitov/russianpost) [![Code Climate](https://codeclimate.com/github/artemshitov/russianpost.png)](https://codeclimate.com/github/artemshitov/russianpost)

Ruby wrapper around Russian Post package tracking SOAP API. Works on a per-package basis (contrary to the bulk ticket-based API). Use it at your own risk, since the API may appear unstable and require authorization in future.

## Installation

To install gem stand-alone:

    gem install russianpost

To use gem in a Rails app, add the following to your `Gemfile`:

    gem "russianpost", "~> 0.4.2"

This gem uses [Savon](http://savonrb.com/), which in turn uses [HTTPI](https://github.com/savonrb/httpi) internally. HTTPI chooses the best HTTP library of those you have installed. For the fastest results, make sure you add [Curb](https://github.com/taf2/curb) to your `Gemfile`:

    gem "curb"
    gem "russianpost"

If you use RussianPost outside Rails, `require "curb"` before requiring RussianPost.

## Usage

Initialize a parcel object, passing the package barcode to the constructor:

    parcel = RussianPost::Parcel.new("EC123456789RU")

Fetch operation history for the parcel:

    parcel.operations

The `operations` method returns an `Array` of `Operation` structs.

### Parcel info

RussianPost makes guesses about current state of the parcel.

    # Current parcel location
    parcel.location

    # Mass
    parcel.mass

    # Rank
    parcel.rank

    # Recipient
    parcel.recipient

    # Type
    parcel.type

### Operations API

Each `Operation` responds to the following methods. If there is no information, methods return `nil`. More thorough documentation coming soon.

#### Address parameters

    destination_address              #=> RussianPost::Address (Struct)
    destination_address.index        #=> String
    destination_address.description  #=> String

    operation_address                #=> RussianPost::Address (Struct)
    operation_address.index          #=> String
    operation_address.description    #=> String

    mail_direct                      #=> RussianPost::Country (Struct)
    mail_direct.id                   #=> Fixnum
    mail_direct.code_2a              #=> String
    mail_direct.code_3a              #=> String
    mail_direct.name_ru              #=> String
    mail_direct.name_en              #=> String

    country_from                     #=> RussianPost::Country (Struct)
    country_from.id                  #=> Fixnum
    country_from.code_2a             #=> String
    country_from.code_3a             #=> String
    country_from.name_ru             #=> String
    country_from.name_en             #=> String
    
    country_oper                     #=> RussianPost::Country (Struct)
    country_oper.id                  #=> Fixnum
    country_oper.code_2a             #=> String
    country_oper.code_3a             #=> String
    country_oper.name_ru             #=> String
    country_oper.name_en             #=> String
    
#### Finance parameters          
    
    payment                          #=> Fixnum
    value                            #=> Fixnum
    mass_rate                        #=> Fixnum
    insr_rate                        #=> Fixnum
    air_rate                         #=> Fixnum
    rate                             #=> Fixnum
    
#### Item parameters          

    barcode                          #=> String
    internum                         #=> String
    valid_ru_type                    #=> Boolean
    valid_en_type                    #=> Boolean
    complex_item_name                #=> String
    
    mail_rank                        #=> RussianPost::GenericOperationParameter (Struct)
    mail_rank.id                     #=> Fixnum
    mail_rank.name                   #=> String

    post_mark                        #=> RussianPost::GenericOperationParameter (Struct)
    post_mark.id                     #=> Fixnum
    post_mark.name                   #=> String
    
    mail_type                        #=> RussianPost::GenericOperationParameter (Struct)
    mail_type.id                     #=> Fixnum
    mail_type.name                   #=> String
    
    mail_ctg                         #=> RussianPost::GenericOperationParameter (Struct)
    mail_ctg.id                      #=> Fixnum
    mail_ctg.name                    #=> String
    
    mass                             #=> Fixnum
    max_mass_ru                      #=> Fixnum
    max_mass_en                      #=> Fixnum

#### Operation parameters          

    oper_type                        #=> RussianPost::GenericOperationParameter (Struct)
    oper_type.id                     #=> Fixnum
    oper_type.name                   #=> String

    oper_attr                        #=> RussianPost::GenericOperationParameter (Struct)
    oper_attr.id                     #=> Fixnum
    oper_attr.name                   #=> String

    oper_date                        #=> DateTime

#### User parameters          
    send_ctg                         #=> RussianPost::GenericOperationParameter (Struct)
    send_ctg.id                      #=> Fixnum
    send_ctg.name                    #=> String

    sndr                             #=> String
    rcpn                             #=> String
