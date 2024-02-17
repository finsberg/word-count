# Choose latest ubuntu as base image
from ubuntu:latest

# Install python3 with pip as well as git (this might be need to install
# some of the requirements) and clean up afterward to reduce image size
RUN apt-get update && apt-get install -y python3-pip git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /repo
# This means that this will be the directory where the commands will be executed
# and the default directory that will be used when the container starts
WORKDIR /repo

# Copy the requirements file into the container at /repo
COPY requirements.txt /repo

# Install any needed packages specified in requirements.txt
# First we also upgrade pip to the latest version
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Now we copy the rest of the files into the container at /repo
COPY . /repo
