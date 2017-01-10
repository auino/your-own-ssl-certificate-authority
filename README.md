# your-own-ssl-certificate-authority

### Description ###

This program (based on the answers received to [a StackExchange question](http://security.stackexchange.com/questions/89319/creating-my-own-ca-for-an-intranet) allows you to easily set up an internal SSL certificate authority.

By using a single `root` certificate, it is possible to configure the client to consider such certificate, plus all the "sub/derived certificates", valid.
In this way, it is possible to configure the client to accept a single certificate.
Implicitly, each derived certificate will be considered valid by the client, without further configuration.

### Configuration ###

Configuration is accomplished by customizing the relative section on the `generatekey.sh` file.

### Certificates generation ###

Two steps are involved.

Each certificate will be stored in the `certs` folder.

#### Generation of the root certificate ####

Before generating the SSL certificates for adopted services, it is required to generate the root certificate.

```sh
sh generatekey.sh --root
```

#### Generation of the (sub)certificates ####

Hence, it is possible to generate a certificate `samplecertificate` for a domain `example.com` by using the following command.

```sh
sh generatekey.sh samplecertificate example.com
```

### Installation ###

In general, you can follow the [relative guide on Kerio](http://kb.kerio.com/product/kerio-connect/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html), covering root certificates import on various operating systems.

### Contacts ###

You can find me on Twitter as [@auino](https://twitter.com/auino).
