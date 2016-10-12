# Vector

# Quick start

Open [demo](http://ec2-52-53-209-251.us-west-1.compute.amazonaws.com:9999/) site on your browser.
`Type ec2-52-53-209-251.us-west-1.compute.amazonaws.com:9999 on Hostname field`

* Client (collect metrics from server)
    http://vectoross.io/docs/installing-performance-co-pilot
* PCP web daemon (RESTful api server for Vector)

```{shell}
docker run -d --name vector -p 7999:80 netflixoss/vector:latest
```

# Reference

https://hostpresto.com/community/tutorials/how-to-monitor-your-server-performance-with-pcp-and-vector-on-ubuntu-14.04/
