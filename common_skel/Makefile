

.PHONY : all fix-perms deps get-deps compile generate

all: deps compile generate

get-deps:
	rebar get-deps

deps: get-deps

compile: 
	rebar compile

generate: fix-perms
	cd rel; rebar -f generate; cd ..

fix-perms:
	chmod 750 rel/files/erl
	chmod 750 rel/files/nodetool
	chmod 750 rel/files/{{srvid}}

start:
	rel/{{srvid}}/bin/{{srvid}} start

stop:
	rel/{{srvid}}/bin/{{srvid}} stop
	killall epmd

console:
	rel/{{srvid}}/bin/{{srvid}} console
