#!/bin/bash
# Advanced SARIF Filtering Script
# This script provides additional filtering options for CodeQL SARIF results
# to help manage large result sets and focus on high-priority security findings

set -e

SARIF_DIR="${1:-sarif-results}"
MAX_RESULTS="${2:-25000}"

echo "========================================="
echo "CodeQL SARIF Advanced Filtering"
echo "========================================="
echo "Directory: $SARIF_DIR"
echo "Max results per file: $MAX_RESULTS"
echo ""

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Installing jq..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Priority levels for filtering (highest to lowest)
declare -a PRIORITY_LEVELS=("error" "warning" "note")
declare -a SEVERITY_LEVELS=("critical" "high" "medium" "low")

# Function to count results in SARIF file
count_results() {
    local file=$1
    jq '.runs[].results | length' "$file" 2>/dev/null || echo "0"
}

# Function to get statistics
get_statistics() {
    local file=$1
    echo "Statistics for: $(basename $file)"
    
    # Count by level
    for level in "${PRIORITY_LEVELS[@]}"; do
        count=$(jq --arg level "$level" '.runs[].results | map(select(.level == $level)) | length' "$file" 2>/dev/null || echo "0")
        echo "  Level '$level': $count"
    done
    
    # Count by severity (if present)
    echo "  By severity:"
    for severity in "${SEVERITY_LEVELS[@]}"; do
        count=$(jq --arg sev "$severity" '.runs[].results | map(select(.properties.severity == $sev)) | length' "$file" 2>/dev/null || echo "0")
        if [ "$count" != "0" ]; then
            echo "    '$severity': $count"
        fi
    done
    echo ""
}

# Function to filter SARIF file
filter_sarif() {
    local input_file=$1
    local output_file=$2
    local filter_level=$3
    
    case $filter_level in
        1)
            # Level 1: Errors only
            jq '.runs[].results |= map(select(.level == "error"))' "$input_file" > "$output_file"
            ;;
        2)
            # Level 2: Errors and Warnings
            jq '.runs[].results |= map(select(.level == "error" or .level == "warning"))' "$input_file" > "$output_file"
            ;;
        3)
            # Level 3: Critical and High severity
            jq '.runs[].results |= map(select(.properties.severity == "critical" or .properties.severity == "high" or .level == "error"))' "$input_file" > "$output_file"
            ;;
        4)
            # Level 4: Sort by priority and take top N
            jq --argjson max "$MAX_RESULTS" '
                .runs[].results |= (
                    map(
                        . + {
                            priority: (
                                if .level == "error" then 0
                                elif .level == "warning" then 1
                                elif .properties.severity == "critical" then 2
                                elif .properties.severity == "high" then 3
                                else 4
                                end
                            )
                        }
                    ) | sort_by(.priority) | .[:$max] | map(del(.priority))
                )
            ' "$input_file" > "$output_file"
            ;;
    esac
}

# Process each SARIF file
for sarif_file in "$SARIF_DIR"/*.sarif; do
    if [ ! -f "$sarif_file" ]; then
        echo "No SARIF files found in $SARIF_DIR"
        exit 0
    fi
    
    echo "Processing: $(basename $sarif_file)"
    echo "-----------------------------------"
    
    # Get original statistics
    original_count=$(count_results "$sarif_file")
    echo "Original result count: $original_count"
    
    if [ "$original_count" -le "$MAX_RESULTS" ]; then
        echo "✓ File is already under the limit ($MAX_RESULTS)"
        get_statistics "$sarif_file"
        continue
    fi
    
    echo "⚠ File exceeds limit, applying filters..."
    
    # Try different filter levels until we get under the limit
    temp_file="${sarif_file}.temp"
    filtered=false
    
    for level in 1 2 3 4; do
        filter_sarif "$sarif_file" "$temp_file" $level
        new_count=$(count_results "$temp_file")
        
        echo "Filter level $level: $new_count results"
        
        if [ "$new_count" -le "$MAX_RESULTS" ]; then
            mv "$temp_file" "$sarif_file"
            echo "✓ Successfully filtered to $new_count results using level $level"
            filtered=true
            get_statistics "$sarif_file"
            break
        fi
    done
    
    if [ "$filtered" = false ]; then
        echo "⚠ Could not reduce below limit with standard filters"
        echo "  Applying hard limit to first $MAX_RESULTS highest priority results"
        filter_sarif "$sarif_file" "$temp_file" 4
        mv "$temp_file" "$sarif_file"
        final_count=$(count_results "$sarif_file")
        echo "✓ Final count: $final_count"
    fi
    
    rm -f "$temp_file"
    echo ""
done

echo "========================================="
echo "Filtering complete!"
echo "========================================="
