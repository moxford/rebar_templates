-module({{srvid}}_mysql).

init() ->
    {ok, Stores} = application:get_env({{srvid}}, data_stores),
    lists:map(fun(DSe) -> 
    		      case DSe of
    			  {mysql, MySQLDSi} when is_list(MySQLDSi) -> 
    			      [
    			       {db_pool_name, PName},
    			       {db_pool_size, PSize},
    			       {db_user, User},
    			       {db_pass, Pass},
    			       {db_host, Host},
    			       {db_port, Port},
    			       {db_name, DBName},
    			       {db_encoding, Encoding}
    			      ] = MySQLDSi,
    			      application:set_env({{srvid}}, poolname, PName),
    			      emysql:add_pool(PName, PSize, 
    					      User, Pass, Host, Port, DBName, Encoding);
    			  _ -> 
    			      throw(datastore_config_error)
    		      end
    	      end,
    	      Stores),
