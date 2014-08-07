
.PHONY : all fix-perms deps get-deps compile gen devlink unlink

all: deps compile gen

deps: get-deps

get-deps:
	rebar get-deps

compile: 
	rebar compile

clean:
	rebar clean

gen: fix-perms stop
	cd rel; rebar -f generate; cd ..

fix-perms:
	chmod 750 rel/files/erl
	chmod 750 rel/files/nodetool
	chmod 750 rel/files/{{srvid}}

start:
	rel/{{srvid}}/bin/{{srvid}} start

stop:
	-if [ -f "rel/{{srvid}}/bin/{{srvid}}" ]; then rel/dropoff/bin/dropoff stop; fi
	-killall epmd

console:
	rel/{{srvid}}/bin/{{srvid}} console

devlink:
	#priv dir
	rm -rf rel/{{srvid}}/lib/{{srvid}}-1/priv
	ln -s ./../../../../priv rel/{{srvid}}/lib/{{srvid}}-1/priv

unlink:
	rm rel/{{srvid}}/lib/{{srvid}}-1/priv
	make clean gen
