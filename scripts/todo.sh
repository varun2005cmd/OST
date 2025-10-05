#!/bin/bash

TASK_FILE="scripts/tasks.txt"

while true; do
    echo "=========================="
    echo "    TO-DO LIST MENU       "
    echo "=========================="
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Delete Task"
    echo "4. Exit"
    echo "=========================="
    read -p "Choose an option [1-4]: " choice

    case $choice in
        1)
            read -p "Enter the task: " task
            echo "$task" >> "$TASK_FILE"
            echo "Task added successfully!"
            ;;
        2)
            if [ ! -f "$TASK_FILE" ] || [ ! -s "$TASK_FILE" ]; then
                echo "No tasks found."
            else
                echo "Your Tasks:"
                nl -w2 -s'. ' "$TASK_FILE"
            fi
            ;;
        3)
            if [ ! -f "$TASK_FILE" ] || [ ! -s "$TASK_FILE" ]; then
                echo "No tasks to delete."
            else
                echo "Select the task number to delete:"
                nl -w2 -s'. ' "$TASK_FILE"
                read -p "Task number: " tnum
                sed -i "${tnum}d" "$TASK_FILE"
                echo "Task deleted successfully!"
            fi
            ;;
        4)
            echo "Exiting To-Do List. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option! Please select 1-4."
            ;;
    esac
done
