#!/bin/bash
set -ex -o pipefail

if [ "$CI" == "true" ] && [ "$TRAVIS" == "true" ]; then
    apt-get install -y python3-pip shellcheck
    pip3 install miniwdl
    export PATH=$PATH:$HOME/.local/bin
fi

ORIG_CWD="$(pwd)"
cd "$(dirname $0)/ABOlocus"
miniwdl check vg_ABOlocus_test.wdl 
miniwdl cromwell vg_ABOlocus_test.wdl -d "$ORIG_CWD/vg_wdl_tests_ABOlocus" \
    ABOlocus_fa_gz=ABOlocus.fa.gz ABOlocus_SV_vcf_gz=ABOlocus_SV.vcf.gz reads_bam=HG01308.ABOlocus.bam
