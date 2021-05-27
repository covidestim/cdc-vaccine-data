#!/usr/bin/bash

jq -C '.vaccination_demographic_trends_data | map(select(.Demographic_category | startswith("Ages_")))'
