#!/bin/sh

echo "Private key:"
wg genkey | tee private.key

echo "Public key:"
cat private.key | wg pubkey
