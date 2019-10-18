# Consul lab

The simplest way to get a fully working Consul Cluster with Connet & Envoy on 3 VMs :)

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

### Check Connect/Envoy L4 setup 

```
vagrant ssh worker-1
sudo docker exec caller curl localhost:12345
```

If you've got a response from `echo`, it means that everything worked properly !

### Check Connect/Envoy L7 setup 

```
vagrant ssh worker-1
sudo docker exec caller_canary watch 'curl http://echo'
```

you shoudl have responses from `echo` container (2/3) `echo2` container (1/3)

### Access Consul UI

Open a SSH tunnel from your host to the master VM in order to forward the port 8080 on your loopback to the port 8500 of the distant server's loopback.

```
ssh -L localhost:8080:localhost:8500 -i ./.vagrant/machines/master/virtualbox/private_key vagrant@172.16.0.10
```

Leave your terminal open, then open in your browser [http://localhost:8080/ui/](http://localhost:8080/ui/)



### Prometheus failed to start
```
vagrant ssh worker-1
sudo docker run --rm -p 9090:9090 -v ~/prometheus/:/etc/prometheus/ prom/prometheus
```

### Grafana
requests statuses to echo service
```
envoy_listener_127_0_0_1_12345_http_upstream_echo_virtual_http_downstream_rq_2xx
envoy_listener_127_0_0_1_12345_http_upstream_echo_virtual_http_downstream_rq_4xx
envoy_listener_127_0_0_1_12345_http_upstream_echo_virtual_http_downstream_rq_5xx
```
