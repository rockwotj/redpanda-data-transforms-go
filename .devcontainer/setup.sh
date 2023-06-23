# install curl, git, ...
apt-get update
apt-get install -y curl git jq gnupg

useradd -m user
su user

# install go
VERSION='1.20'
OS='linux'
ARCH='amd64'

curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

INSTALLED_GO_VERSION=$(go version)
echo "Go version ${INSTALLED_GO_VERSION} is installed"

# install gopls, dlv, hey
echo "Getting development tools"
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/rakyll/hey@latest

# install custom redpanda
curl https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | apt-key add - \
    && echo "deb https://us-central1-apt.pkg.dev/projects/rp-byoc-tyler wasm-feature-branch-apt main" | tee -a /etc/apt/sources.list.d/artifact-registry.list \
    && apt update \
    && apt install redpanda
