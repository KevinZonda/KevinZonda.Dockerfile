FROM golang:latest

# Configure to reduce warnings and limitations as instruction from official VSCode Remote-Containers.
# See https://code.visualstudio.com/docs/remote/containers-advanced#_reducing-dockerfile-build-warnings.
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils 2>&1

# Verify git, process tools, lsb-release (common in install instructions for CLIs) installed.
RUN apt-get -y install git iproute2 procps lsb-release

# Install Go tools.
RUN apt-get update

RUN go install golang.org/x/tools/gopls@latest

# Clean up.
RUN apt-get autoremove -y \
    apt-get clean -y

# Revert workaround at top layer.
ENV DEBIAN_FRONTEND=dialog

# Expose service ports.
EXPOSE 8000