FROM golang:1.22.5-bookworm AS builder

ENV CGO_CFLAGS="-O -D__BLST_PORTABLE__"
ENV CGO_CFLAGS_ALLOW="-O -D__BLST_PORTABLE__"

WORKDIR /workspace
COPY . .

RUN make build


FROM golang:1.22.5-bookworm

WORKDIR /root

RUN apt-get update -y && apt-get install -y ca-certificates jq tree diffutils vim colordiff dnsutils

COPY --from=builder /workspace/hyperbench /usr/bin/hyperbench
COPY --from=builder /workspace/eth.so /root/eth.so
COPY --from=builder /workspace/benchmark /root/benchmark

CMD ["hyperbench", "start", "benchmark/ethereum/transfer"]