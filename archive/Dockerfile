# =======================================================
# Stage 1 - Build/compile app using container
# =======================================================

ARG IMAGE_BASE=3.1-alpine

# Build image has SDK and tools (Linux)
FROM mcr.microsoft.com/dotnet/core/sdk:$IMAGE_BASE as build
WORKDIR /build

# Copy project source files
COPY TestApi ./TestApi
COPY *.sln .

# Restore, build & publish
WORKDIR /build/TestApi
RUN dotnet restore
RUN dotnet publish --no-restore --configuration Release

# =======================================================
# Stage 2 - Assemble runtime image from previous stage
# =======================================================

# Base image is .NET Core runtime only (Linux)
FROM mcr.microsoft.com/dotnet/core/aspnet:$IMAGE_BASE

# Metadata in Label Schema format (http://label-schema.org)
LABEL org.label-schema.name    = ".NET Core Demo Web App" \
      org.label-schema.version = "1.3.0" \
      org.label-schema.vendor  = "Devops Guy" \
      org.label-schema.vcs-url = "https://github.com/nsvijay04b1/weather-demo"

# Seems as good a place as any
WORKDIR /app

# Copy already published binaries (from build stage image)
COPY --from=build /build/TestApi/bin/Release/netcoreapp3.1/publish/ .

# Expose port 5001 from Kestrel webserver
EXPOSE 5001

# Tell Kestrel to listen on port 5001 and serve plain HTTP
ENV ASPNETCORE_URLS http://*:5001

# Run the ASP.NET Core app
ENTRYPOINT dotnet weather-demo.dll
