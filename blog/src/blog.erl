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

	% select applet
	Aid = << 160, 0, 0, 0, 98, 99, 1, 12, 6, 0 >>,
	{ok, Replies} = pcsc_card:command(Card,
       #apdu_cmd{cla = iso, ins = select, p1 = 0, p2 = 10, data = Aid}),
	io:fwrite(Replies).

	% command
	%{ok, Replies2} = pcsc_card:command(Card,
	%	{cla = iso, ins = 0, p1 = 0, p2}),
	%io:fwrite(Replies2).
