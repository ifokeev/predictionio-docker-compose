This project contains:
- Docker image to build with predictionIO + Spark + JDBC driver
- A docker-compose yml file to run postgres, elasticsearch, eventserver and queries server
- Integrated universal-recommender with likes engine

Please read ``docker-compose.yml`` file to get more details about:
- ports
- volumes
- configuration

## Softwares

* elasticsearch 1.7.6 (official Docker image)
* Spark 1.6.3 for Hadoop 2.6
* predictionIO 0.11.0

## Requirements

- Docker
- Docker compose
- At least 3 gb of free disk space

## Usage

* Run Docker containers on background (should build automatically)

``sh start.sh``

* Check ``localhost:9200`` (elasticsearch) and ``localhost:7070`` (pIO event server) and ```localhost:8000``` (Queries server)
