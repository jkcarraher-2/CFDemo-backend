FROM ortussolutions/commandbox:latest

ARG TARGETARCH

RUN echo "TARGETARCH=${TARGETARCH}"

RUN curl -L \
    "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-${TARGETARCH}" \
    -o /usr/local/bin/tailwindcss \
    && chmod +x /usr/local/bin/tailwindcss

RUN apt-get update \
    && apt-get install -y file \
    && file /usr/local/bin/tailwindcss