ARG python_version

FROM python:${python_version}

RUN apt-get update && apt-get install -y curl apt-transport-https gnupg2 jq \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get install -y libev4 libev-dev unixodbc-dev g++ gcc

# Preinstall pip libs to use cassandra, kafka, mongo and sql (spikeelabs default libs)
RUN pip install cassandra-driver==3.7.1 confluent-kafka==1.4.1  pymongo==3.10.1 pyodbc==4.0.26

# Install poetry (using install recommended way) and setup poetry path
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH="${PATH}:/root/.poetry/bin"
