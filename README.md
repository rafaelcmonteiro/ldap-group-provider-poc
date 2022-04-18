# POC

This is a poc of [arghya18/trino-group-provider-ldap-ad](https://github.com/arghya18/trino-group-provider-ldap-ad).

## How to set users and groups on Freeipa

First of all run free ipa server using the folloing code.

```
docker run --sysctl net.ipv6.conf.all.disable_ipv6=0 --name freeipa-server-container -ti -h ipa.example.test -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/lib/ipa-data:/data:Z freeipa/freeipa-server:centos-8-4.9.2
```

You'll have to answer a few questions after that, so be careful the questions you have to answer are listed below, the rest you can press enter to accept default.

- Directory Manager password: yourpassword
- IPA admin password: yourpassword
- Continue to configure the system with these values? [no]: yes

After seeing `FreeIPA server configured` you can try the next step.

## Accessing FreeIPA Interface

After the instalation of FreeIPA you have to set the line below on /etc/hosts so you can access the interface via browser on Host, `be careful to set the right container IP adress`:

```
172.17.0.3      ipa.example.test
```

Now access the site via browser https://ipa.example.test, didn't set a certificate to FreeIPA yet, you have to access it via insecure mode, I've tried it with Google Chrome and Firefox, both worked.

## Group Provider and Password Authenticator Properties files

Don't forget to set the same password setted on Freeipa instalation.

`group-provider.properties`
```
ldap.admin-password=admin_pass_set_on_freeipa
```
`password-authenticator.properties`
```
ldap.bind-password=admin_pass_set_on_freeipa
```

## docker-compose run

Run docker-compose.yaml to up Trino container and it's network.

```
docker-compose up
```

Set Freeipa in the same network as Trino:

```
docker network connect ldap-group-provider_trino-demo freeipa-server-container
```

Showing all container in a network

```
docker network inspect ldap-group-provider_trino-demo
```
