- install nerves key
- show how to generate key/cert (maybe a CA for AWS)
  https://hexdocs.pm/nerves_key/readme.html#signer-certificates

# Securing Communication

## Setup certificate authority

Now that we have a useful bit of code for reading our sensor, we want to be able to get that data to the cloud, really put the I in IoT. In order to communicate securely with the cloud, we will start by generating some [certificates](https://en.wikipedia.org/wiki/X.509) as well as a [certificate authority](https://en.wikipedia.org/wiki/Certificate_authority). We will be using [Nerves Key](https://github.com/nerves-hub/nerves_key) for easy generation of our certificates.

```sh
mix deps.get
mix nerves_key.signer create ca_cert
```

This will output a certificate and a key. You can verify the certificate details by using [`openssl`](https://www.openssl.org/)

```sh
openssl x509 -in ca_cert.cert -text
```

## Environment Variables and Things

Please note that in multiple places during this step we will be using environment variables. Very recommends using a tool like [direnv](https://direnv.net/) to help maintain environments but if you do not have such a tool at hand, you can simply set the necessary variables with your chosen console shell.

The following documentation will prepare us to connect to the AWS cloud. The preferred method of authenticating with AWS is via client side certificates. Each certificate will contain the necessary encrypted information to prove that it was signed by a Certificate Authority that has been approved within AWS, and it will be an authentic representation of some [AWS Thing](https://docs.aws.amazon.com/iot/latest/developerguide/iot-thing-management.html) by presenting a `thing name` via the certificate's common name. In the example below you will notice that we are creating a certificate and passing a specified `$THING_NAME` in the creation step. It is important that thing names are unique within a given AWS instance. If you are having trouble this might be an area for exploration.

Now we can use our new CA to create a certificate that our device can use to authenticate with the cloud.

```sh
export THING_NAME=my-thing
mix nerves_key.device create $THING_NAME --signer-cert ca_cert.cert --signer-key ca_cert.key
```

```
mix nerves_key.device create demo2023dr --signer-cert certh_auth.cert --signer-key certh_auth.key
```

As an output you will see a device cert and private key with the same given thing name have been created in the directory. Please move these certs to the project's `priv` directory for future use.

## Building Firmware with Certificates

In order to use the certificates within the firmware, we can use environment variable again. This is not best practice for a hardware project, since it is easy to manipulate the code to expose the certificates. Typically some type of [TPM](https://en.wikipedia.org/wiki/Trusted_Platform_Module) is used to secure certificates during manufacturing.

Extra: try to provision an [ATECC608B](https://www.microchip.com/en-us/product/ATECC608B) to provide certificates securely.

But for the purposes of this project, we can use the simple approach. See [the config](../../config/config.exs) lines 14 - 28
