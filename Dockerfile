FROM alpine
ADD entrypoint.sh /bin/
RUN apt-get update
RUN apt-get install jq
RUN chmod +x /bin/entrypoint.sh
RUN apk -Uuv add curl ca-certificates
ENTRYPOINT /bin/entrypoint.sh
