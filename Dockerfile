FROM python:3.12-bullseye

# Update system packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libnss3 \
    libnspr4 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libatspi2.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libdrm2 \
    libxkbcommon0 \
    libasound2 \
    libxcursor1 \
    libgtk-3-0 \
    libx11-xcb1 \
    curl

# Create application user for app to run as
RUN useradd --create-home app

ENV VIRTUAL_ENV=/opt/app/venv
ENV PYTHONPATH=/home/appuser/src
ENV PATH="$VIRTUAL_ENV/bin/:$PATH"
ENV PYTHONUNBUFFERED 1



# Virtual Environment Setup
RUN python3 -m venv $VIRTUAL_ENV && \
	    chown -R app:app /opt/app

USER app

# Install Pipenv
RUN pip install pipenv

WORKDIR /home/app

# Copy dependencies & application into container
COPY --chown=app:app Pipfile* .

# Install python dependencies
RUN pipenv requirements > requirements.txt && \
    pip install -r requirements.txt && \
    playwright install

COPY --chown=app:app ./src /home/app/src

CMD ["/bin/bash"]
