[![Build Status](https://magnum.travis-ci.com/nchristod/e-proc.svg?token=ignutXcn3zruuYWNuz3N&branch=master)](https://magnum.travis-ci.com/nchristod/e-proc)

Eproc Ror
=========

This application is part of my thesis for ECE Upatras. It's a web app for online procurements.
The goal is to add functionality up to the point that it can be deployed hopefully in a wide range of enterprises at least useable as a starting point/skeleton.

Features
========

##General

- Platform automatically transmit all its notices to a single point of access for publication (RSS) 
- Anyone can access and retrieve contract notices and tender specifications as anonymous users
- Support English in addition to the official language(s) of the member state(s) where they operate [TODO]
- Keep tenders encrypted until the opening session
- Tenders or part of them get evaluated automatically based on pre-defined criteria 

##Admin

- Creates Procurement Calls
- Manages Procurement Calls
- Manages Categories and Products
- Places technical evaluations on offers that requires it
- Manages Users (can change roles and or delete them)

##Supplier

- Can see active Procurement Calls
- Places offers
- Can resubmit their tenders up until the submission deadline
- Can register on the platform without having to provide country-specific information
- Complete their registration by clicking an activation link sent by email
- Can use a username and a password to log in to a platform
- Receive a proof of delivery upon successful submission of their tender [TODO]

Ruby on Rails
-------------

This application requires:

-   Ruby
-   Rails

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Database
--------

This application uses SQLite with ActiveRecord.

Development
-----------

-   Template Engine: ERB
-   Testing Framework: RSpec
-   Front-end Framework: Bootstrap 3.0 (Sass)
-   Form Builder: SimpleForm
-   Authentication: Devise
-   Authorization: Pundit

Email
-----

The application is configured to send email using a Gmail account.

Email delivery is disabled in development.

Getting Started
---------------

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Documentation and Support
-------------------------

This is the only documentation.

#### Issues

Lorem ipsum dolor sit amet, consectetur adipiscing elit.


License
-------

Lorem ipsum dolor sit amet, consectetur adipiscing elit.
