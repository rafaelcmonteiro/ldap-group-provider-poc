FROM trinodb/trino:334
COPY ldap-plugin/ldap-ad /usr/lib/trino/plugin/ldap-ad
COPY /properties/group-provider.properties /etc/trino/group-provider.properties
COPY /properties/access-control.properties /etc/trino/access-control.properties
COPY /properties/rules.json /etc/trino/rules.json
COPY /properties/config.properties /etc/trino/config.properties
COPY /properties/password-authenticator.properties /etc/trino/password-authenticator.properties
COPY /properties/certificate.p12 /etc/certificate.p12