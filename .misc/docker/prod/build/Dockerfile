FROM pydemic/consultant_board:release AS release
FROM erlang:22.3.4-alpine

WORKDIR /app

RUN apk add coreutils

COPY --from=release /app/_build/prod/rel/consultant_board .
COPY start.sh start.sh

CMD ["sh", "/app/start.sh"]
