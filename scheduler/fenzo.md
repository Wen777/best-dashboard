# Netflix Fenzo: OSS Scheduler for Apache Mesos Framework

## Scheduling Model

* Resources become idle, waiting for new assignments
* Task launches experience increased latency

## Features

* Generic task scheduler works with any Apache Mesos frameworks.
* Long running service-style tasks and for batch or interactive use cases
* Supports plugins. (Be able to customize the constraints.)
    * Compose multiple individual plugins together to achieve higher level complex objectives;
* Assign CPI, memory, network bandwidth, disk, and port resources from resource offers
* Monitor resources allocation failures in order to assist in debugging why some tasks cant't be launched.

```
Fenzo’s task scheduler provides the scheduling core without interaction with Mesos itself. The framework, interfaces with Mesos to get callbacks on new resource offers and task status updates. As well, it calls Mesos driver to launch tasks based on Fenzo’s assignments.
```

# Reference:

* [Netflix Blog](http://techblog.netflix.com/2015/08/fenzo-oss-scheduler-for-apache-mesos.html)
* [Github Repo](https://github.com/Netflix/Fenzo)
