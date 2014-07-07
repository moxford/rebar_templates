-module(web_routes).

-export([install/0]).
-export([update_routes/0]).

update_routes() ->
    cowboy:set_env(web_listener, dispatch, cowboy_router:compile([{'_', routes()}])).

routes() ->
    {ok, App} = application:get_env(sarserver, application_name),
    Webtypes = [{mimetypes, cow_mimetypes, web}],
    [
     {"/", web_root_handler, []},
     {"/websocket", websocket_handler, []},
     {"/html/[...]", cowboy_static, {priv_dir, App, "web/html"}},
     %% {"/html/[...]", cowboy_static, {priv_dir, App, "web/html"}, Webtypes},
     {"/third-party/[...]", cowboy_static, {priv_dir, App, "web/third-party"}, Webtypes},
     {"/css/[...]", cowboy_static, {priv_dir, App, "web/css"}, Webtypes}, 
     {"/js/[...]", cowboy_static, {priv_dir, App, "web/js"}, Webtypes},
     {"/dialogs/[...]", cowboy_static, {priv_dir, App, "web/dialogs"}, Webtypes},
     {"/images/[...]", cowboy_static, {priv_dir, App, "web/images"}, Webtypes},
     {"/audio/[...]", cowboy_static, {priv_dir, App, "web/audio"}, Webtypes}
     %%{"/lookup/:lookup_type", web_lookup_handler, []},
     %%{"/cart/:cart_type", web_sales_handler, []},
     %%{"/seller/showcut/:sid/:ts", [{sid,int},{ts,int}], web_seller_handler, []},
     %%{"/pos", pos_handler, []} 
    ].
    
install() ->
    Routes = routes(),
    Dispatch = cowboy_router:compile([{'_', Routes}]),
    cowboy:start_http(web_listener, 
		      proplists:get_value(start_count, [application:get_env(sarserver, web)], 30),
		      [ {port, proplists:get_value(port, [application:get_env(sarserver, web)], 8090)} ],
		      [ {env, [{dispatch, Dispatch}]} ]
		     ).
