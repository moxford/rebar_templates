-module({{srvid}}).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    %%{ok, Stores} = application:get_env(config, data_stores),
    %% lists:map(fun(DSe) -> 
    %% 		      case DSe of
    %% 			  {mysql, MySQLDSi} when is_list(MySQLDSi) -> 
    %% 			      [
    %% 			       {db_pool_name, PName},
    %% 			       {db_pool_size, PSize},
    %% 			       {db_user, User},
    %% 			       {db_pass, Pass},
    %% 			       {db_host, Host},
    %% 			       {db_port, Port},
    %% 			       {db_name, DBName},
    %% 			       {db_encoding, Encoding}
    %% 			      ] = MySQLDSi,
    %% 			      application:set_env(pointofsale, poolname, PName),
    %% 			      emysql:add_pool(PName, PSize, 
    %% 					      User, Pass, Host, Port, DBName, Encoding);
    %% 			  _ -> 
    %% 			      throw(datastore_config_error)
    %% 		      end
    %% 	      end,
    %% 	      Stores),
    {ok, _} = web_routes:install(),
    {{srv_id}}_sup:start_link().

stop(_State) ->
    ok.
