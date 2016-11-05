# Soultion B

## Components

* Locust: Sent the aggregated load testing data to Consumer.
* Consumer:
    * connect to AWS Cloudwatch and download the metrics of AWS EC2.
    * Receive the data from Locust and store the data inside DB.

## Single Node

* Customize locust. (--no-web mode)
* Consumer, a restful api server.

#### User Story:
1. Deploy application on AWS EC2
    1.1 Deploy by Docker image.
2. Execute locust.
    2.1 在shell下指令(ex: nohub locust -f ./example_locust.py --host=http://docs.locust.io --no-web -c 5 -r 10 -n 100  --only-summary )
    2.2 locust運作之前，先發request到Consumer server註冊load testing event 取得event number.
    3.3 load testing 結束前，發request(含event number, aggregated data)到Consumer server 儲存。
3. [Consumer] Download the data of metrics from AWS Cloudwatch
    2.1 收到來自locust的load testing 結束event, 根據time stamp 下載AWS Cloudwatch資料

#### Consumer API

* POST /apiv0.1/event/register

* POST /apiv0.1/event/commit
    * Task: Download data from aws Cloudwatch

* GET /state

#### TODO

* [ ] Shell Script for deployment (Docker image && Locust)
* [ ] Consumer RESTful API server (Queue, AWS Cloudwatch)
* [ ] Integrate with Slack

## Cluster

* The problem of the number of requests.
* Deploy locust by kubernetes on 5+ nodes.
