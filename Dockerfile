
# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

# Copy project files
COPY ["HelloWorldDocker.csproj", "./"]

# Restore dependencies
RUN dotnet restore "HelloWorldDocker.csproj"

# Copy remaining source files
COPY . .

# Publish the application
RUN dotnet publish "HelloWorldDocker.csproj" -c Release -o /app/publish

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

# Expose application port
EXPOSE 8080

ENV ASPNETCORE_HTTP_PORTS=8080

# Copy published application
COPY --from=build /app/publish .

# Start the application
ENTRYPOINT ["dotnet", "HelloWorldDocker.dll"]
