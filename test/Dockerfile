ARG python_version
FROM python:${python_version}

ARG SONAR_SCANNER_HOME=/opt/sonar-scanner
ARG UID=1000
ARG GID=1000
ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    SONAR_SCANNER_VERSION=4.3.0.2102 \
    PATH=${SONAR_SCANNER_HOME}/bin:${PATH}

RUN apt-get update && apt-get install -y curl apt-transport-https gnupg2 jq \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get install -y libev4 libev-dev unixodbc-dev g++ gcc \
    && apt-get install -y --no-install-recommends ca-certificates git wget unzip xz-utils pylint \
    && rm -rf /var/lib/apt/lists/*

# Preinstall pip libs to use cassandra, kafka, mongo and sql (spikeelabs default libs)
RUN pip install cassandra-driver==3.23.0 confluent-kafka==1.4.1  pymongo==3.10.1 pyodbc==4.0.30

# Install poetry (using install recommended way) and setup poetry path
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH="${PATH}:/root/.poetry/bin"

WORKDIR /opt
RUN wget -U "scannercli" -q -O /opt/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && unzip sonar-scanner-cli.zip \
    && rm sonar-scanner-cli.zip \
    && mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux ${SONAR_SCANNER_HOME}
