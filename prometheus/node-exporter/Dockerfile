#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.10.1

RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		amd64)    arch='amd64' ;; \
		arm64)    arch='arm64' ;; \
		armel)    arch='armv5' ;; \
		armhf)    arch='armv7' ;; \
		i386)     arch='386' ;; \
		mips64el) arch='mips64le' ;; \
		ppc64el)  arch='ppc64le' ;; \
		riscv64)  arch='riscv64' ;; \
		s390x)    arch='s390x' ;; \
		*)        arch='src' ;; \
	esac; \
	if [ "$arch" != 'src' ]; then \
		filename="node_exporter-${NODE_EXPORTER_VERSION}.linux-${arch}.tar.gz"; \
		case "$filename" in \
			'node_exporter-1.10.1.linux-386.tar.gz') sha256='00f65acfcbfe583b87d2ec54473cbf3cec6976119bed78539fa856369a878abd' ;; \
			'node_exporter-1.10.1.linux-amd64.tar.gz') sha256='0662f0bc0d57470fe2188738c1bec1ec99716e899d0c557480fb94b9b1d9825f' ;; \
			'node_exporter-1.10.1.linux-arm64.tar.gz') sha256='d60d3a29e30fbbe618516ae41ed359c12523a31dd0a9dc04422ff2fc5e401449' ;; \
			'node_exporter-1.10.1.linux-armv5.tar.gz') sha256='b8955d4977e74457a5d127dbb512a540143df59ead895d00c02f7a3e5ab276af' ;; \
			'node_exporter-1.10.1.linux-armv6.tar.gz') sha256='2b8de82b89df6174a1c430f6728e132b0c06361e20c3391e6f46511d8551ade0' ;; \
			'node_exporter-1.10.1.linux-armv7.tar.gz') sha256='2de402b592ef01071f1c06a3c1eb60a06d225f250897d6f19a6bf4b3fdd5766f' ;; \
			'node_exporter-1.10.1.linux-mips.tar.gz') sha256='eb77394aa712ae8aa48c52842171988ea2135db8905def8d4f4676a45a7ddfa0' ;; \
			'node_exporter-1.10.1.linux-mips64.tar.gz') sha256='e5614c77cf7ebe56a2af475e79f3a7224b80c9249b40641fc709527462362885' ;; \
			'node_exporter-1.10.1.linux-mips64le.tar.gz') sha256='e87f69154e132b877471c727ac1465e194eb5bc889f8a72aa7ad177516395fe6' ;; \
			'node_exporter-1.10.1.linux-mipsle.tar.gz') sha256='d5ae271112e3060bba805cddc7b70376d30a1316dc0a037e6c00a8ee6bc89b40' ;; \
			'node_exporter-1.10.1.linux-ppc64.tar.gz') sha256='5b226746e2eb3c639de621a9a34addaf6bd9d87a22cf00df47c853ca615cde87' ;; \
			'node_exporter-1.10.1.linux-ppc64le.tar.gz') sha256='866991100d0f99276e98983bd830ddd8439f01f7cbb43555c59d4144f538168f' ;; \
			'node_exporter-1.10.1.linux-riscv64.tar.gz') sha256='c5d58392ae4a1e0db302c33b041fa6b713f9212268d0e3ba5fad06bc264f4d71' ;; \
			'node_exporter-1.10.1.linux-s390x.tar.gz') sha256='d1145af5402ad1d09f924246c3aec957961d4a002c3162b8a681d353ad87fa15' ;; \
			*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
		esac; \
		url="https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/$filename"; \
	else \
		url="https://github.com/prometheus/node_exporter/archive/refs/tags/v${NODE_EXPORTER_VERSION}.tar.gz"; \
	fi; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget; \
	if [ "$arch" = 'src' ]; then \
		( \
			. /etc/os-release; \
			if [ -n "${VERSION_CODENAME}" ]; then \
				echo "deb https://deb.debian.org/debian $VERSION_CODENAME-backports main" > /etc/apt/sources.list.d/backports.list; \
				apt-get update; \
				apt-get install -y --no-install-recommends -t "$VERSION_CODENAME-backports" golang-go; \
			else \
# must be ports/unstable, so probably new enough Go as-is
				apt-get install -y --no-install-recommends golang-go; \
			fi; \
		); \
	fi; \
	\
	wget -O /tmp/node-exporter.tar.gz "$url"; \
	if [ "$arch" != 'src' ]; then \
		echo "$sha256 */tmp/node-exporter.tar.gz" | sha256sum --strict --check -; \
	fi; \
	\
	tar \
		--extract \
		--file /tmp/node-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/node-exporter.tar.gz; \
	\
	if [ "$arch" = 'src' ]; then \
		dir="$PWD"; \
		cd /; \
		mv "$dir" /tmp/src; \
		( \
			mkdir -p "$dir"; \
			cd /tmp/src; \
			export GOBIN="$dir" GOCACHE="$PWD/.gocache" GOPATH="$PWD/.gopath"; \
			go install \
				-a -tags 'netgo osusergo static_build' \
				-ldflags " \
					-X github.com/prometheus/common/version.Version=$NODE_EXPORTER_VERSION \
					-X github.com/prometheus/common/version.Revision=v$NODE_EXPORTER_VERSION \
				" \
				. \
			; \
		); \
		rm -rf /tmp/src; \
	fi; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	apt-get dist-clean; \
	\
	node_exporter --version

VOLUME /opt/node-exporter/data

EXPOSE 9100
CMD ["node_exporter"]
