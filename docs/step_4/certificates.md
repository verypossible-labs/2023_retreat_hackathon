- install nerves key
- show how to generate key/cert (maybe a CA for AWS)
  https://hexdocs.pm/nerves_key/readme.html#signer-certificates

```bash
mix nerves_key.signer create oa_auth
```

check if it works with

```
openssl x509 -in certh_auth.cert -text
```

https://github.com/nerves-hub/nerves_key#debugging-without-an-atecc508a608a

Then, create your device cert:

```
mix nerves_key.device create <serial number> --signer-cert certh_auth.cert --signer-key certh_auth.key
```

Set your device serial number (thing_name on AWS)

```
mix nerves_key.device create demo2023dr --signer-cert certh_auth.cert --signer-key certh_auth.key
```

You got:

```
Created device cert, demo2023dr.cert and private key, demo2023dr.key.

Please store demo2023dr.key in a safe place.

```

- Explain how cert is tied to thing name and AWS authentication

- Show how to configure key as part of ENV during compile/build
