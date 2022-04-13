-module(blog).
-export([main/0]).

main() ->
	% get all the available readers
	{ok, Readers} = pcsc_card_db:list_readers(),

	% use the first reader
	[Reader | _] = Readers,
	io:fwrite("Using: ~s~n", [Reader]),

	% connect
	{ok, Card} = pcsc_card:start_link(Reader, shared, [t1, t0]),

