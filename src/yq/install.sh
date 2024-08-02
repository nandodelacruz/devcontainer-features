#!/bin/sh
set -e

echo "Activating feature 'yq'"
echo "The provided version is: ${VERSION}"


# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

YQ_VERSION=${VERSION:-"v4.44.2"}

# Determine the architecture
case "$(uname -m)" in
    x86_64) ARCH='amd64' ;;
    aarch64) ARCH='arm64' ;;
    armv7l) ARCH='arm' ;;
    *) echo "Unsupported architecture: $(uname -m)" && exit 1 ;;
esac

# Download and install yq
wget "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${ARCH}" -O /usr/bin/yq
chmod +x /usr/bin/yq

echo "yq version ${YQ_VERSION} installed successfully."