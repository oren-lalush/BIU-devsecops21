#!/bin/bash

SYSLOG="/var/log/syslog"
KEYWORDS=("ERROR" "WARNING" "FATAL" "CRITICAL" "FAIL" "ALERT")

# --------------------------------------------
# Function: extract IP address from a line
# returns first IP found (if any)
# --------------------------------------------
get_ip() {
    local line="$1"
    # basic IPv4 regex
    #local ipregex="([0-9]{1,3}\.){3}[0-9]{1,3}"
    local ipregex="\\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b"
    if [[ $line =~ $ipregex ]]; then
        echo "${BASH_REMATCH[0]}"
    else
        echo ""
    fi
}

# --------------------------------------------
# Function: check if a line contains any keyword
# returns keyword if found (first match)
# --------------------------------------------
get_keyword() {
    local line="$1"
    for key in "${KEYWORDS[@]}"; do
        if [[ "$line" == *"$key"* ]]; then
            echo "$key"
            return
        fi
    done
    echo ""
}

# --------------------------------------------
# Main processing
# --------------------------------------------
declare -A ip_count
declare -A ip_keywords

while IFS= read -r line; do
    ip=$(get_ip "$line")
    [[ -z "$ip" ]] && continue

    ((ip_count[$ip]++))

    kw=$(get_keyword "$line")
    if [[ -n "$kw" ]]; then
        if [[ -z "${ip_keywords[$ip]}" ]]; then
            ip_keywords[$ip]="$kw"
        else
            # avoid duplicates
            if [[ ! " ${ip_keywords[$ip]} " =~ " $kw " ]]; then
                ip_keywords[$ip]="${ip_keywords[$ip]}, $kw"
            fi
        fi
    fi
done < "$SYSLOG"

# --------------------------------------------
# Create report
# --------------------------------------------
timestamp=$(date +"%d-%m-%Y_%H-%M-%S")
report="report-${timestamp}.rep"

{
    echo "*******************************************************************************"
    echo "Report created at $(date +"%H:%M")"
    echo

    for ip in "${!ip_count[@]}"; do
        echo "$ip address appeared in ${ip_count[$ip]} lines."
        if [[ -n "${ip_keywords[$ip]}" ]]; then
            echo "keywords appeared: ${ip_keywords[$ip]}"
        else
            echo "keywords appeared: none"
        fi
        echo
    done

    echo "*******************************************************************************"
} > "$report"

cat "$report"

