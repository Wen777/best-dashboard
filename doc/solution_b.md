# Soultion B

## Components

* Locust: Sent the aggregated load testing data to Consumer.
* Consumer:
    * connect to AWS Cloudwatch and download the metrics of AWS EC2.
    * Receive the data from Locust and store the data inside DB.

## Single Node

* Customize locust. (--no-web mode)
* Consumer, a restful api server.

## Cluster

* The problem of the number of requests.
* Deploy locust by kubernetes on 5+ nodes.
