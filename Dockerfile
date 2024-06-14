FROM python:3.12-bullseye

# Update system packages
RUN apt-get update && \
    apt-get upgrade -y

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
COPY --chown=app:app ./src /home/app/src

# Install python dependencies
RUN pipenv requirements > requirements.txt
RUN pip install -r requirements.txt

CMD ["/bin/bash"]
