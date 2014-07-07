-module(web_routes).

-export([install/0]).
-export([update_routes/0]).

update_routes() ->
    cowboy:set_env(web_listener, dispatch, cowboy_router:compile([{'_', routes()}])).

install() ->
    Routes = routes(),
    Dispatch = cowboy_router:compile([{'_', Routes}]),
    cowboy:start_http(web_listener, 
		      proplists:get_value(start_count, [application:get_env({{srvid}}, web)], 30),
		      [ {port, proplists:get_value(port, [application:get_env({{srvid}}, web)], 8090)} ],
		      [ {env, [{dispatch, Dispatch}]} ]
		     ).

routes() ->
    {ok, App} = application:get_env({{srvid}}, application_name),
    Webtypes = [{mimetypes, cow_mimetypes, web}],
    [
     {"/", web_root_handler, []},
     {"/ws", websocket_handler, []},
     {"/html/[...]", cowboy_static, {priv_dir, App, "web/html"}, Webtypes},
     {"/third-party/[...]", cowboy_static, {priv_dir, App, "web/third-party"}, Webtypes},
     {"/css/[...]", cowboy_static, {priv_dir, App, "web/css"}, Webtypes}, 
     {"/js/[...]", cowboy_static, {priv_dir, App, "web/js"}, Webtypes},
     {"/dialogs/[...]", cowboy_static, {priv_dir, App, "web/dialogs"}, Webtypes},
     {"/images/[...]", cowboy_static, {priv_dir, App, "web/images"}, Webtypes},
     {"/audio/[...]", cowboy_static, {priv_dir, App, "web/audio"}, Webtypes}
     %%{"/lookup/:lookup_type", web_lookup_handler, []},
    ].
