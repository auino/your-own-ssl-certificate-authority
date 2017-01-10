# your-own-ssl-certificate-authority

### Description ###

This program (based on the answers received to [a StackExchange question](http://security.stackexchange.com/questions/89319/creating-my-own-ca-for-an-intranet) allows you to easily set up an internal SSL certificate authority.

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

Hence, it is possible to generate a certificate `samplecertificate` for a domain `example.com` by using the following command.

```sh
sh generatekey.sh samplecertificate example.com
```

### Contacts ###

You can find me on Twitter as [@auino](https://twitter.com/auino).
