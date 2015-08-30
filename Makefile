all: build

build:
	docker build -t "dragonfax/riak-cs-source" .

run:
	docker run -it dragonfax/riak-cs-source bash
