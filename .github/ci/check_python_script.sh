#!/bin/bash

# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

set -e

echo
echo "==================================="
echo "Check python utf coding and shebang"
echo "==================================="
echo

ERROR_FILES_SHEBANG=""
ERROR_FILES_UTF_CODING=""
FILES_TO_CHECK=`find . \
    -type f \( -name '*.py' \) \
    \( -not -path "*/.*/*" \) \
    \( -not -path "*/build/*" \) \
    \( -not -path "*/env/*" \) \
    \( -not -path "*/src/*" \) \
    \( -not -path "*/third_party/*" \) \
    \( -not -path "*/*/__init__.py" \) \
    \( -not -path "./miniconda.sh" \) | sort`

for file in $FILES_TO_CHECK; do
    echo "Checking $file"
    grep -q "\#\!/usr/bin/env python3" $file || ERROR_FILES_SHEBANG="$ERROR_FILES_SHEBANG $file"
    grep -q "\#.*coding: utf-8" $file || ERROR_FILES_UTF_CODING="$ERROR_FILES_UTF_CODING $file"
done

if [ ! -z "$ERROR_FILES_SHEBANG" ]; then
    for file in $ERROR_FILES_SHEBANG; do
        echo "ERROR: $file does not have the python3 shebang."
    done
fi

if [ ! -z "$ERROR_FILES_UTF_CODING" ]; then
    for file in $ERROR_FILES_UTF_CODING; do
        echo "ERROR: $file does not have the utf encoding set."
    done
fi
echo
if [ ! -z "${ERROR_FILES_SHEBANG}${ERROR_FILES_UTF_CODING}" ]; then
    exit 1
fi
