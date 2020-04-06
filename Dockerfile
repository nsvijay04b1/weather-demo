# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY TestApi/*.csproj ./TestApi/
RUN dotnet restore 

# copy everything else and build app
COPY TestApi/. ./TestApi/
WORKDIR /source/TestApi
RUN dotnet publish -o /TestApi  --no-restore --configuration Release

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine
WORKDIR /TestApi
COPY --from=build /TestApi ./

# Expose port 5001 from Kestrel webserver
EXPOSE 5001/tcp

# Tell Kestrel to listen on port 5001 and serve plain HTTP
ENV ASPNETCORE_URLS http://*:5001
ENV ASPNETCORE_ENVIRONMENT Development
ENV NGINX 'http://nginx-service/static.json'

ENTRYPOINT ["./TestApi"]

