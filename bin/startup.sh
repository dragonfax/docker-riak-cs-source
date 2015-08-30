#!/bin/sh
riak start && stanchion start && /app/rel/riak-cs/bin/riak-cs
