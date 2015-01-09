# Homebrew-review

## Overview

This is a sample app for reviewing homebrewed beer built with Thoughtbot's [suspenders](https://github.com/thoughtbot/suspenders).  I'm building out a simple web app first, then will build an API using [jbuilder](https://github.com/rails/jbuilder), [prmd](https://github.com/interagent/prmd), [versionist](https://github.com/bploetz/versionist), and some other tools to mess around with building APIs and validating with JSON Schema.

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
