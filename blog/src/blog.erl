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
	Aid = << 160, 0, 0, 0, 98, 3, 1, 12, 6, 1 >>,
	Select_apdu = { apdu_cmd, default, iso, select, 4, 0, Aid, none },
	{ok, Select_replies} = pcsc_card:command(Card, Select_apdu),
	io:write(Select_replies),
	io:fwrite("~n"),

	% command
	Command_apdu = { apdu_cmd, default, iso, 0, 0, 0, none, none },
	{ok, Command_replies} = pcsc_card:command(Card, Command_apdu),
	io:write(Command_replies),
	io:fwrite("~n"),

	% extract the answer
	[Reply | _] = Command_replies,
	case Reply of
		{apdu_reply, _, ok, Msg} ->
			io:write(binary_to_atom(Msg)),
			io:fwrite("~n");
		{apdu_reply, _, error, _} ->
			io:fwrite("Error~n")
	end.
