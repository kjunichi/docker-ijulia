```shell-sssion
git clone https://github.com/kjunichi/docker-ijulia.git
cd docker-ijulia
docker build -t kjunichi/ijulia .
```

```shell-sssion
docker run -p 8998:8998 -d kjunichi/ijulia
```

```shell-sssion
open http://`boot2docker ip`:8998
```
