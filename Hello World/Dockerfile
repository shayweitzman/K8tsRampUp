FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /app

COPY . /app

ENV ASPNETCORE_URLS=http://+:6565

RUN dotnet publish -c Release -o out

EXPOSE 6565

CMD ["./out/helloworld"]