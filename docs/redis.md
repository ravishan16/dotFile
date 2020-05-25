![redis](https://redis.io/images/redis-white.png) 
# brew redis on Mac

Redis is a powerful in-memory datastore widely used as cache, pub/sub (message broker) for [further reading..](https://redis.io) 

## Installing Redis on mac

there are many options to install Redis on mac you can [Download]() the code and compile it or use a docker image. I prefer using [Homebrew](https://brew.sh/) to install and manage Redis on mac. It is also easy to uninstall Redis using brew.
``` shell
> brew install redis
```


## Starting Redis server as a foreground process
starts the server as a foreground process using redis-server command. To exit ctrl+c
``` shell
 > redis-server

15594:C 25 May 2020 18:08:37.005 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
15594:C 25 May 2020 18:08:37.005 # Redis version=6.0.3, bits=64, commit=00000000, modified=0, pid=15594, just started
15594:C 25 May 2020 18:08:37.005 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
15594:M 25 May 2020 18:08:37.006 * Increased maximum number of open files to 10032 (it was originally set to 8192).
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis 6.0.3 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._                                   
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 15594
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           http://redis.io        
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               

15594:M 25 May 2020 18:08:37.007 # Server initialized
15594:M 25 May 2020 18:08:37.008 * Ready to accept connections
```

## Starting/Stopping Redis server as a background service

Starting/Stopping Redis server can be done using brew services. By default, Redis starts on port 6379 as a background service

### List all brew services

``` shell
> brew services list
```

### Start redis

``` shell
> brew services start redis
```

### Stop redis

``` shell
> brew services stop redis
```

### Restart redis

``` shell
> brew services restart redis
```

## Check if Redis is up

command redis-cli ping should respond with a PONG
``` shell
> redis-cli ping
PONG
```

## Configuring Redis

To configure Redis and change the default edit the /usr/local/etc/redis.conf file and restart the Redis server. 
Check the configuration section for [more](https://redis.io/topics/config) to configure users check the [ACL (Access Control List)](https://redis.io/topics/acl)


## useful aliases add to ~/.zshrc or ~/.bash_profile

``` shell
alias redis-start="brew services start redis"
alias redis-stop="brew services stop redis"
alias redis-restart="brew services restart redis"
alias redis-monitor="redis-cli monitor"
```


### [Useful redis commands](https://redis.io/topics/rediscli)
``` shell
# connect to a different redis server or port 
> redis-cli -h <address> -p <port>

# List users
> redis-cli ACL LIST

# Continous stat
> redis-cli --stat
------- data ------ --------------------- load -------------------- - child -
keys       mem      clients blocked requests            connections          
1          1.02M    1       0       0 (+0)              1           
1          1.02M    1       0       1 (+0)              1           
1          1.02M    1       0       2 (+1)              1           
1          1.02M    1       0       3 (+1)              1           
1          1.02M    1       0       4 (+1)              1           

# Monitor commandis is a super useful it stdouts all the command received by redis
> redis-cli monitor
OK
1590445706.871636 [0 127.0.0.1:52583] "ping"
1590445716.910679 [0 127.0.0.1:52642] "flushall"
1590445814.170701 [0 127.0.0.1:53107] "incr" "visitor"
1590445893.336228 [0 127.0.0.1:53483] "publish" "channel" "hi"
1590445914.672421 [0 127.0.0.1:53591] "subscribe" "channel1"
1590445925.539757 [0 127.0.0.1:53639] "publish" "channel" "hey"
```