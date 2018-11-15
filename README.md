# Packer AWS nginx64

A packer template to build AWS ami image of ubuntu xenial with nginx.

## AWS Authentication

AWS credentials can be provided in the ways listed below in order of precedence:

* Set template variables `aws_access_key_id` and `aws_secret_access_key` directly when building the template e.g.

  ```packer build -var 'aws_access_key_id=<aws_key_id>' -var 'aws_secret_access_key=<aws_key>' template.json```

* Set environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

* Have a shared credential file `$HOME/.aws/credentials` or at path defined in `AWS_SHARED_CREDENTIALS_FILE`

## Setting base AWS ami and AWS region

The base ami must be in the selected region.
By default the template uses:

* `aws_base_ami_id: ami-00259791f61937520`
* `aws_region: eu-central-1`

In order to change them pass `-var 'aws_region=<aws_region>' -var 'aws_base_ami_id=<aws_ami_id>'`
to `packer build`

## Build the template

Run: `packer build template.json`

## Running Kitchen test

* **Prerequisites:**
  * Install rbenv - `brew install rbenv`
  * Initialize rbenv - add to `~/.bash_profile` line `eval "$(rbenv init -)"`
  * Run `source ~/.bash_profile`
  * Install ruby 2.3.1 with rbenv - `rbenv install 2.3.1` , check `rbenv versions`
  * Set ruby version for the project to 2.3.1 - `rbenv local 2.3.1` , check `rbenv local`
  * Install bundler - `gem install bundler`
  * Install gems from Gemfile - `bundle install`

* **Set up AWS authentication** - choose one of the options below:
  * Set up the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
  * Set up a shared credentials file `$HOME/.aws/credentials`

* **Set ami id and region for the test** - set the tested ami id and it's region in `.kitchen.yml` as follows:

```YAML

  platforms:
  - name: aws/nginx64
    driver:
      image_id: <ami_id_to_be_tested>
      region: <aws_region>

```

* **Running kitchen:**
  * List kitchen environment - `bundle exec kitchen list`
  * Build kitchen environment - `bundle exec kitchen converge`
  * Run kitchen tests - `bundle exec kitchen verify`
  * Destroy kitchen environment - `bundle exec kitchen destroy`
  * Automatically build, test, destroy - `bundle exec kitchen test`