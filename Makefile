all: build

build:
	docker build -t "dragonfax/riak-cs-source" .

run:
	docker run -it -p 8080:8080 dragonfax/riak-cs-source /bin/startup.sh

dev: 
	mkdir riak-cs-source
	docker run -it dragonfax/riak-cs-source bash
