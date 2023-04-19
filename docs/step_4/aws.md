## How to create an AWS user and roles

Create or use an account https://aws.amazon.com/free/

# How to get certs into AWS IoT

- Include policy with topic(s) for [basic ingest](https://docs.aws.amazon.com/iot/latest/developerguide/iot-basic-ingest.html)
- Include creating an IoT thing
- Show options for AWS console and CLI?
- Extra: Setup JITP and custom self signed CA

# Configure environment for building firmware with necessary AWS variable like the MQTT endpoint

https://very-development.signin.aws.amazon.com/console

Upload CA certificate

https://docs.aws.amazon.com/iot/latest/developerguide/create-CA-verification-cert.html?icmpid=docs_iot_console_secure_ca_reg

![Add CA cert](add_ca_cert.png)

Then you need to create a policy.

![Add policy](policies.png)

You can use a template

![policy example](json_policy.png)

![JSON policy](json_policy.png)

Upload cert

Attach cert to policy

Create thing name

![JSON policy](create_tn1.png)

![JSON policy](create_tn2.png)

Then attach the thing name to the cert

![JSON policy](attach_tn_to_cert.png)

Extra: create rule
