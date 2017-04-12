get_aliases() {
    awk -F= '{print $1}' ~/.nimble.map | sort
}

get_services() {
    if [ -z "$services_list" ]; then
        launchctl list | tail -n+2 | awk '{print $1" "$2" "$3}' | sort
    else
        echo "$services_list"
    fi
}

get_services_labels() {
    if [ -z "$services_list" ]; then
        launchctl list | tail -n+2 | awk '{print $NF}' | sort
    else
        echo "$services_list" | awk '{print $NF}'
    fi
}

get_services_with_alias() {
    awk -F= '{print $NF}' ~/.nimble.map | sort
}

get_services_without_alias() {
    comm -3 <(get_services_with_alias) <(get_services_labels)
}

get_service_alias() {
    grep -sm1 "=$1$" ~/.nimble.map | awk -F= '{print $1}'
}

get_alias_service() {
    grep -sm1 "^$1=" ~/.nimble.map | awk -F= '{print $2}'
}

get_service_status() {
    if [ -z "$services_list" ]; then
        launchctl list | tail -n+2 | grep -sm1 "\s$1$"
    else
        echo "$services_list" | grep -sm1 "\s$1$"
    fi
}

get_alias_status() {
    get_service_status $(get_alias_service $1)
}

is_alias() {
    grep -qsm1 "^$1=" ~/.nimble.map
}

is_service() {
    get_service_status $1 > /dev/null
}

has_alias() {
    awk -F= '{print $NF}' ~/.nimble.map | grep -sqm1 "^$1$"
}
