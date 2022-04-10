%%%-------------------------------------------------------------------
%% @doc blog public API
%% @end
%%%-------------------------------------------------------------------

-module(blog_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    blog_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
