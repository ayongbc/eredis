-module(eredis_sentinel_sup).

-behaviour(supervisor).

-export([start_link/1]).

-export([init/1]).

start_link(Env) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [Env]).

init([Env]) ->
    {ok, {{one_for_one, 10, 100}, [{eredis_sentinel, 
                                   {eredis_sentinel, start_link, [Env]}, 
                                   permanent, 5000, worker, [eredis_sentinel]}]}}.
