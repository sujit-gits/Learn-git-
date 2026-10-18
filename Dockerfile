
# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy source code
COPY . .

# Restore the actual project
RUN dotnet restore WebAPI/WebAPI.csproj

# Publish the application
RUN dotnet publish WebAPI/WebAPI.csproj \
    --configuration Release \
    --no-restore \
    --output /app/publish

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "WebAPI.dll"]
