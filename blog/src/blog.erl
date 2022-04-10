-module(blog).
-export([main/1]).

main(X) ->
	io:fwrite("Hello world!\n"),
	pcsc_card_db:list_readers().
