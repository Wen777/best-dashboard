# Soultion B

## Ideas 

* Security
    * Not allow all the Locust client can connect to database(influxdb)
    * Only provide fews (limited) APIs to access the database.
* Extensibility
    * Easily to replace any component in the future.

## Components

* Locust: Sent the aggregated load testing data to Consumer.
* Consumer:
    * connect to influxDB.
    * Receive the data from Locust and store the data inside DB.

## Single Node

* Customized locust. (--no-web mode)
* Consumer, a restful api server.

#### User Story:
1. Deploy application on AWS EC2
    1.1 Deploy by Docker image.
2. Execute locust.
    2.1 Execute locust from shell / docker run (ex: nohub locust -f ./example_locust.py --host=http://docs.locust.io --no-web -c 5 -r 10 -n 100  --only-summary )
    2.2 Locust notifies Consumer server before it starts load test and receive a uuid from Consumer as a event id.
    3.3 Before finishing load testing，send a request (include: event number, aggregated data) to Consumer server to store.
3. [Consumer] Create the record of load testing in the time series database.
    2.1 Locust starts load testing and notifies Consumer server. Consumer starts a cron job to insert the record of load testing into time series database every 15 seconds.
    2.2 Locust finishes the load testing and notifies Consumer server. Consumer insert the last record of load testing into database and canceles the cron job.

#### Modified Locust
i
* New parameter, consumer_host "http://xxx-ggg-zzz:port"
* Adjust the flow of load testing. Send the request to Consumer server to register load testing event before starts the load testing.

#### Consumer API

* POST /apiv0.1/events/register
    * Register a cron job to insert the record of load testing every 15 seconds.
    * Required data
```{json}
{
    startedAt: "Date", // Date, string
    host: "",
    measurement: {
        fields: {
            clients: 0, // number of concurrent clients, number
            hatchRate: 0.1, // The rate per second in which clients are spawned. number
            requests: 0 // The number of requests
        },
        tags: {
            targetHost: "", // "http:10.10.10.1", Host to load test, string
            mode: "" // "single", "cluster", string
        }
    }
}

````
    * Returned data:
```{json}
{
    uuid: "xkjpw-ajta-jwt", // {random-id}, string
}
```
* POST /apiv0.1/events/commit
    * Task: Insert the last record of load testing into influxDB. Delete the cronjob.
    * Required data:
```{json}
{
    startedAt: "Date", // The time of the end of load testing.
    uuid: "xxx-ggg-zzz", // {random-id}, string
    host: "", // host, string
    measurement: {
        fields: {
           requestStats: {JSON OBJECT} // result of load testing 
        },
        tags: {
            hostname: "", // "http:10.10.10.1", Host to load test, string
            mode: "" // "single", "cluster", string
        }
    }
}
```

* GET /events/isrunning
    * Display how many cron job running.

#### TODO

* [X] Customize Locust && Build it by docker.
* [X] Shell Script for deployment (Docker image && Locust)
* [X] Consumer RESTful API server (Queue, influxDB)
* [ ] Integrate with Slack
* [ ] Deploy by AWS ECS.

## Cluster

* The problem of the number of requests.
* Deploy locust by kubernetes on 5+ nodes.
