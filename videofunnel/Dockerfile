ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.21
FROM ${BUILD_FROM}

ARG BUILD_ARCH=amd64
ARG VF_VERSION=0.2.18
# China: set at build time, e.g. GH_MIRROR=https://ghfast.top/https://github.com
ARG GH_MIRROR=https://github.com
# Optional pinned SHA256 of the archive (release publishes no checksum file).
ARG VF_SHA256=""

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Native AOT musl binary: needs libssl (dlopen'd), CA certs, libgcc. No ICU (invariant).
RUN apk add --no-cache ca-certificates libgcc libstdc++ openssl curl

RUN case "${BUILD_ARCH}" in \
      amd64)   RID=linux-musl-x64 ;; \
      aarch64) RID=linux-musl-arm64 ;; \
      *) echo "unsupported arch ${BUILD_ARCH}"; exit 1 ;; \
    esac \
 && curl -fsSL -o /tmp/vf.tgz "${GH_MIRROR}/huiyuanai709/VideoFunnel-releases/releases/download/v${VF_VERSION}/vf-${RID}.tar.gz" \
 && if [ -n "${VF_SHA256}" ]; then echo "${VF_SHA256}  /tmp/vf.tgz" | sha256sum -c -; fi \
 && mkdir -p /tmp/vf \
 && tar -xzf /tmp/vf.tgz -C /tmp/vf \
 && install -m 0755 /tmp/vf/vf /usr/bin/vf \
 && rm -rf /tmp/vf /tmp/vf.tgz

# vf writes vf-console.log under $XDG_CONFIG_HOME/VideoFunnel; keep it in the add-on config dir.
ENV XDG_CONFIG_HOME=/config

COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
