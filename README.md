# .NET Core - Demo Web Application
This is a simple .NET Core web app  for weather report.
webserver serves weather  details stats and a nginx file server serves static json file.


# Running Locally using docker-compose
```
$docker-compose -f docker-compose.yml up -d --build

Successfully built 15a065ee26fc
Successfully tagged weather-demoapp:latest
Starting weather-demo_nginx-service_1 ... done
Creating weather-demo_webapp_1        ... done
```

# Check docker-compose services status 
```
$ docker-compose -f docker-compose.yml ps
         Name                        Command               State           Ports
-----------------------------------------------------------------------------------------
testapi_nginx-service_1   nginx -g daemon off;             Up      0.0.0.0:8000->80/tcp
testapi_webapp_1          ./TestApi /bin/bash -c doc ...   Up      0.0.0.0:5001->5001/tcp
```

#  Testing webapp 

![Test results](images/tests.png)




# Bring down docker-compose  services
```
[kube@eaasrt TestApi]$ docker-compose -f docker-compose.yml down
Stopping testapi_webapp_1        ... done
Stopping testapi_nginx-service_1 ... done
Removing testapi_webapp_1        ... done
Removing testapi_nginx-service_1 ... done
Removing network testapi_default
```
Web app will listen on the usual Kestrel port of 5001, but this can be changed by setting the `ASPNETCORE_URLS` ENV parameter  in Dockefile.


# Docker images  github and AzureCR

Public Docker image is [available on Dockerhub](https://hub.docker.com/repository/docker/nsvijay04b1/weather-demoapp/).  

Public Docker image is [available on AzureCR]( nsvijaykumar.azurecr.io/apps/weather-demoapp:latest). 


Run in a container with:
```
docker run -it -d -p 5001:5001 --name weather-demoapp weather-demoapp:latest

```

Should you want to build your own container, use the `Dockerfile` found the in the 'docker' directory of the project

# GitHub Actions CI/CD 
A working CI and release GitHub Actions workflow is provided `.github/workflows/build-ci-build-test.yaml`, automated builds are run in GitHub hosted runners

### [GitHub Actions](https://github.com/nsvijay04b1/weather-demo/actions)

![fgithub actions CI ](/images/githubActions-CI.JPG)  




