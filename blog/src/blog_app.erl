%%%-------------------------------------------------------------------
%% @doc blog public API
%% @end
%%%-------------------------------------------------------------------

-module(blog_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:fwrite("List of available readers:\n"),
    {ok, Readers} = pcsc_card_db:list_readers(),
    erlang:display(Readers),
    blog_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
