![Redis Logo](https://redis.io/images/redis-white.png)

# Redis Cheatsheet for macOS 🍎

Redis is a powerful in-memory datastore widely used for caching, pub/sub messaging, and more. This guide provides quick commands and tips for installing, managing, and using Redis on macOS.

---

## Quick Tips

- **Default Port:** Redis runs on port `6379` by default.
- **Logs Location:** Check logs for debugging in `/usr/local/var/log/redis.log`.
- **Configuration File:** The default configuration file is located at `/usr/local/etc/redis.conf`.
- **Access Control:** Use the [ACL Guide](https://redis.io/topics/acl) to configure users and permissions.
- **Stop Redis Safely:** Always stop Redis using `brew services stop redis` or `redis-cli shutdown` to avoid data loss.
- **Redis CLI Help:** Run `redis-cli --help` to see all available commands.

---

## Useful Commands

### Connect to Redis
```bash
redis-cli -h <host> -p <port>
```

### Ping Redis
Check if Redis is running:
```bash
redis-cli ping
# Output: PONG
```

### List Users
```bash
redis-cli ACL LIST
```

### Monitor Commands
Log all commands received by Redis in real-time:
```bash
> redis-cli monitor
OK
1590445706.871636 [0 127.0.0.1:52583] "ping"
1590445716.910679 [0 127.0.0.1:52642] "flushall"
1590445814.170701 [0 127.0.0.1:53107] "incr" "visitor"
1590445893.336228 [0 127.0.0.1:53483] "publish" "channel" "hi"
1590445914.672421 [0 127.0.0.1:53591] "subscribe" "channel1"
1590445925.539757 [0 127.0.0.1:53639] "publish" "channel" "hey"
```

### View Continuous Stats
```bash
> redis-cli --stat
------- data ------ --------------------- load -------------------- - child -
keys       mem      clients blocked requests            connections          
1          1.02M    1       0       0 (+0)              1           
1          1.02M    1       0       1 (+0)              1           
1          1.02M    1       0       2 (+1)              1           
1          1.02M    1       0       3 (+1)              1           
1          1.02M    1       0       4 (+1)              1           

```

### Flush All Data
Clear all keys in the current database:
```bash
redis-cli flushall
```

### Increment a Key
```bash
redis-cli incr <key>
```

### Publish a Message
Send a message to a channel:
```bash
redis-cli publish <channel> <message>
```

---

## Installation

### Install Redis via Homebrew
The easiest way to install Redis on macOS is using [Homebrew](https://brew.sh/):
```bash
brew install redis
```

---

## Starting and Stopping Redis

### Start Redis as a Foreground Process
Run the Redis server in the foreground:
```bash
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
- **To exit:** Press `Ctrl + C`.

### Start/Stop Redis as a Background Service
Use Homebrew services to manage Redis as a background service:
```bash
brew services start redis   # Start Redis
brew services stop redis    # Stop Redis
brew services restart redis # Restart Redis
```

### Check Running Services
List all services managed by Homebrew:
```bash
brew services list
```

---

## Configuration

### Edit Redis Configuration
To customize Redis settings, edit the configuration file:
```bash
/usr/local/etc/redis.conf
```
- After making changes, restart Redis:
  ```bash
  brew services restart redis
  ```

For more details on configuration, see the [Redis Configuration Guide](https://redis.io/topics/config).

---

## Useful Aliases

Add these aliases to your `~/.zshrc` or `~/.bash_profile` for quick Redis management:
```bash
alias redis-start="brew services start redis"
alias redis-stop="brew services stop redis"
alias redis-restart="brew services restart redis"
alias redis-monitor="redis-cli monitor"
```

---

Redis is now ready to supercharge your development workflow! 🚀 For more commands and advanced usage, check the [Redis CLI Documentation](https://redis.io/topics/rediscli).