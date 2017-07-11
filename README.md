This project contains:
- Docker image to build with predictionIO + Spark
- A docker-compose yml file to run elasticsearch + the built image

Please read ``docker-compose.yml`` file to get more details about:
- ports
- volumes
- configuration

## Softwares

* elasticsearch 5.5 (official Docker image)
* Spark 2.1.1 for Hadoop 2.6
* predictionIO 0.11.0

## Requirements

- Docker
- Docker compose
- At least 3 gb of free disk space

## Usage

* Run Docker containers (elasticsearch and predictionIO) on background (should build automatically)

``docker-compose up -d``

* Check ``localhost:9200`` (elasticsearch) and ``localhost:7070`` (pIO event server)

* Connect to pIO container ``docker-compose exec pio bash``

* Now you can follow any official tutorial !

## Credits

* Thomas Decaux from Qwant