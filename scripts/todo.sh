#!/bin/bash

TASK_FILE="tasks.txt"

add_task() {
    read -p "Enter new task: " task
    if [ -z "$task" ]; then
        echo "⚠️  Task cannot be empty!"
    else
        echo "$(date '+%d-%m-%Y %H:%M') - $task" >> "$TASK_FILE"
        echo "✅ Task added successfully!"
    fi
}

view_tasks() {
    echo "----- Your Tasks -----"
    if [ ! -s "$TASK_FILE" ]; then
        echo "No tasks yet!"
    else
        cat -n "$TASK_FILE"
    fi
}

delete_task() {
    echo "----- Delete Task -----"
    if [ ! -s "$TASK_FILE" ]; then
        echo "No tasks to delete!"
        return
    fi
    cat -n "$TASK_FILE"
    read -p "Enter task number to delete: " task_num
    sed -i "$((task_num+1))d" "$TASK_FILE"
    echo "Task deleted successfully!"
}

set_reminder() {
    read -p "Enter reminder message: " message
    read -p "Enter time in minutes: " minutes
    if [[ -z "$message" || -z "$minutes" ]]; then
        echo "⚠️  Message or time cannot be empty!"
        return
    fi
    echo "Reminder set for $minutes minute(s)."
    (sleep "${minutes}m" && echo "⏰ REMINDER: $message") &
}

while true; do
    echo "---------------------------"
    echo "     TO-DO LIST MENU       "
    echo "---------------------------"
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Delete Task"
    echo "4. Set Reminder"
    echo "5. Exit"
    echo "---------------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) add_task ;;
        2) view_tasks ;;
        3) delete_task ;;
        4) set_reminder ;;
        5) echo "Exiting... Have a productive day!"; exit 0 ;;
        *) echo "Invalid choice! Please try again." ;;
    esac
    echo ""
done
