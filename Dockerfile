FROM --platform=linux/amd64 debian:11-slim

ENV TZ="Europe/Prague"

RUN apt-get update && apt-get install -y --fix-missing --no-install-recommends curl ca-certificates postgresql-13 \
    postgresql-contrib-13 postgresql-client-common wget apt-transport-https gnupg supervisor expect

RUN wget -O- https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb bullseye main" | tee /etc/apt/sources.list.d/adoptopenjdk.list
RUN apt-get update && apt-get install -y --fix-missing --no-install-recommends adoptopenjdk-8-hotspot adoptopenjdk-8-hotspot-jre

RUN apt-get install -y locales locales-all
RUN locale-gen cs_CZ.utf8 && update-locale

# Download latest flexibee
RUN curl -o flexibee.deb "$(curl 'https://www.flexibee.eu/podpora/stazeni-flexibee/stazeni-ekonomickeho-systemu-flexibee-linux/' | egrep -o '(https:[^\"]+\.deb)' | grep -v 'client')"

# Or, optionally, you could comment downloading and copy local deb file
# COPY flexibee_2023.3.0_all.deb flexibee.deb

# Copy & run installation script
ENV DISABLE_DB=1
COPY install.exp install.exp
RUN chmod +x install.exp
RUN ./install.exp

# Clean
RUN rm install.exp flexibee.deb

# Entrypoint
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
