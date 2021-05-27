#!/usr/bin/bash

jq '.vaccination_demographic_trends_data | map(select(.Demographic_category | startswith("Ages_")))'
