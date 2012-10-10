# dm-bug-report

This is a clone of Postmodern's template for creating standalone scripts
which reproduce bugs found in DataMapper.  I have modified it to support
a spec test which exhibits a bug in DataMapper's storage of time.

## Usage

Install DataMapper dependencies:

    $ bundle install

Install DataMapper Edge dependencies:

    $ DM_EDGE=true bundle install

Use existing DataMapper repositories from a root directory:

    $ DM_ROOT=~/src/dm/ bundle install

Install a specific DataMapper Adapter:

    $ ADAPTER=mysql bundle install

Run the test script.

    $ rspec bug.rb

