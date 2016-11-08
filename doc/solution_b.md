# Soultion B

## Components

* Locust: Sent the aggregated load testing data to Consumer.
* Consumer:
    * connect to influxDB.
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
3. [Consumer] Create the record of load testing in the time series database.
    2.1 Locust starts load testing and notifies Consumer server. Consumer starts a cron job to insert the record of load testing into time series database every 15 seconds.
    2.2 Locust finishes the load testing and notifies Consumer server. Consumer insert the last record of load testing into database and canceles the cron job.

#### Modified Locust

    * New parameter, consumer_host "http://xxx-ggg-zzz:port"
    * Adjust the flow of load testing. Send the request to Consumer server to register load testing event before starts the load testing.
#### Consumer API

* POST /apiv0.1/event/register
    * Register a cron job to insert the record of load testing every 15 seconds.
    * Required data```{json}
{
    time: "Date", // Date, string
    mode: "", // "single", "cluster", string
    targetHost: "", // "http:10.10.10.1", Host to load test, string
    clients: 0, // number of concurrent clients, number
    hatchRate: 0.1, // The rate per second in which clients are spawned. number
}
````
    * Returned data: ```{json}
{
    time: "Date", // Date, string
    uuid: "xkjpw-ajta-jwt", // {host}-{date}-{id}, string
}
```
* POST /apiv0.1/event/commit
    * Task: Insert the last record of load testing into influxDB. Delete the cronjob.
    * Required data: ```{json}
{
    time: "Date", // The time of the end of load testing.
    uuid: "xxx-ggg-zzz", // {host}-{date}-{id}, string
    statistics: {

    }, // Metrics from Locust
    statistics_text: "" // the formating from locust, string
    failures: {

    }, // Metrics from Locust
    failures_text: "" // Formating by Locust.
}
```

* GET /states
    * Display how many cron job running.

#### TODO

* [ ] Customize Locust && Build it by docker.
* [ ] Shell Script for deployment (Docker image && Locust)
* [ ] Consumer RESTful API server (Queue, influxDB)
* [ ] Integrate with Slack
* [ ] Deploy by Mesos.

## Cluster

* The problem of the number of requests.
* Deploy locust by kubernetes on 5+ nodes.
