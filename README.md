# docker-tinydns-gitdnsdata
Docker image running tinydns as name server. Includes [fefe's ipv6 patches](https://www.fefe.de/dns/)

Name server in a docker container running tinydns. Uses a git repository to periodically pull and update the DNS data. Updated version
that uses statically compiled binaries for tinydns and tinydns-data based on Alpine Linux.

### Variables

* **GIT_DNSDATA**: URL to pull the dns data from. See [example data](https://github.com/andreasfaerber/docker-tinydns-exampledata)
* **GIT_UPDATE_FREQUENCY**: Delay in seconds between each DNS data update


#### Run tinydns docker container with example data:

```
docker run -d \
  -e GIT_DNSDATA=\
  "https://github.com/andreasfaerber/docker-tinydns-exampledata.git" \
  -e GIT_UPDATE_FREQUENCY=300 \
  -p 53:53/udp \
  --name tinydns_example \
  afaerber/docker-tinydns-gitdnsdata
```

#### Run with ssh key authentication for some real world DNS data repository:

- Provide username and password via https to pull git repository via https
- Change the example GIT_DNSDATA URL to your DNS data repository
- Change GIT_UPDATE_FREQUENCY to suit your use

```
docker run -d \
  -e GIT_DNSDATA="https://username:password@your.git.url/repository.git" \
  -e GIT_UPDATE_FREQUENCY=300 \
  -p 53:53/udp \
  --name tinydns_example \
  afaerber/docker-tinydns-gitdnsdata
```

#### Test example install

```
dig @127.0.0.1 your.example mx
```
