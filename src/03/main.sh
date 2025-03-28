#!/bin/bash

source validation.sh
source system_info.sh
source print_info.sh

validate_params "$@"

get_system_info

print_all_info