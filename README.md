# Consul lab

The simplest way to get a fully working Consul Cluster on 3 VMs :)

## Requirements

- virtualbox
- vagrant

This project uses Ansible but __you don't need it on your host__ : it's installed on a VM by Vagrant and provisions everything from there.

## Run

```
vagrant up
```

That's it ! Have a cup of coffee while looking at Vagrant upping the VMs and setting everything for you.


## Check

When it's finished, ssh in any VM* and check your Consul cluster :

```
vagrant ssh worker-0
consul members
```

you should get something like that :

```
Node      Address           Status  Type    Build  Protocol  DC   Segment
master    172.16.0.10:8301  alive   server  1.6.1  2         dc1  <all>
worker-0  172.16.1.10:8301  alive   client  1.6.1  2         dc1  <default>
worker-1  172.16.1.11:8301  alive   client  1.6.1  2         dc1  <default>
```

\* except "provisionner" which is used to run Ansible scripts and is not part of the cluster


## Docker commands

### worker-0
```
sudo docker run --rm -d --name echo_proxy -p 20000:20000 err0r500/consul-envoy --sidecar-for echo --http-addr 172.17.0.1:8500 --grpc-addr 172.17.0.1:8502
sudo docker run --rm -d --name echo --network=container:echo_proxy hashicorp/http-echo -text="hi from echo server"
```

### worker-1
```
sudo docker run --rm -d --name caller_proxy -p 21000:21000 err0r500/consul-envoy --sidecar-for caller --http-addr 172.17.0.1:8500 --grpc-addr 172.17.0.1:8502
sudo docker run --rm -d --name caller --network=container:caller_proxy amouat/network-utils python -m SimpleHTTPServer 9000
```


## Troubleshooting
- think to restart the container using the "container" network if you restart the proxy
- if error : `cannot create upstream cluster without discovery chain` https://github.com/hashicorp/consul/issues/6521
```
sudo docker run --rm -d --name caller_proxy -p 21000:21000 -e CONSUL_HTTP_ADDR=172.17.0.1:8500 -e CONSUL_GRPC_ADDR=172.17.0.1:8502 nicholasjackson/consul-envoy bash -c "consul connect envoy -sidecar-for caller"
```
