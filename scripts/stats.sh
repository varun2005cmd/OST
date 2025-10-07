#!/bin/bash

TASK_FILE="scripts/tasks.txt"

# Check if the file exists and is not empty
if [ ! -f "$TASK_FILE" ]; then
    echo "❌ Task file not found!"
    exit 1
elif [ ! -s "$TASK_FILE" ]; then
    echo "⚠️  Task file is empty. Add some tasks first!"
    exit 0
fi

# Basic counts
total=$(wc -l < "$TASK_FILE")
done=$(grep -c "\[done\]" "$TASK_FILE")
pending=$((total - done))

# Calculate percentage completion
if [ "$total" -gt 0 ]; then
    percent=$((done * 100 / total))
else
    percent=0
fi

# Function to draw a progress bar
draw_bar() {
    local value=$1
    local total_chars=20
    local filled=$((value * total_chars / 100))
    local empty=$((total_chars - filled))

    printf "["
    for ((i=0; i<filled; i++)); do printf "█"; done
    for ((i=0; i<empty; i++)); do printf " "; done
    printf "] %d%%\n" "$value"
}

# Display stats
echo "================================="
echo "📊 To-Do List Statistics"
echo "================================="
echo "Total Tasks   : $total"
echo "Completed     : $done"
echo "Pending       : $pending"
echo -n "Progress      : "
draw_bar "$percent"
echo "---------------------------------"

# Optional: show category-wise breakdown
echo "📂 Category Summary:"
categories=$(grep -oP '\[\K[^\]]+' "$TASK_FILE" | sort | uniq -c)
if [ -n "$categories" ]; then
    echo "$categories" | while read count category; do
        echo "  - $category: $count task(s)"
    done
else
    echo "  No categories found (you can tag tasks like [work], [personal], etc.)"
fi

echo "================================="
