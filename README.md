## Packer AWS xenial64
A packer template to build AWS ami image of ubuntu xenial with nginx.

### AWS Authenticaton
AWS credentials can be provided in the ways listed below in order of precedence:
* Set template variables `aws_access_key_id` and `aws_secret_access_key` directly when building the template e.g.<br>
```packer build -var 'aws_access_key_id=<aws_key_id>' -var 'aws_secret_access_key=<aws_key>' template.json```

* Set enviroment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

* Have a shared credential file `$HOME/.aws/credentials` or at path defined in `AWS_SHARED_CREDENTIALS_FILE`

### Setting base AWS ami and AWS region
The base ami must be in the selected region.<br>
By default the template ueses `aaws_base_ami_id: ami-00259791f61937520` and `aws_region: eu-central-1`<br>
In order to change them pass `-var 'aws_region=<aws_region>' -var 'aws_base_ami_id=<aws_ami_id>'`<br>
to `packer build`

### Build the template
Run: `packer build template.json`
