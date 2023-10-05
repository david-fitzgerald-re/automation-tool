#!/bin/bash

setup() {
    echo -e "Performing setup...\n";
    check "$@"
}

add_client() {
    echo "Adding a client... (WIP)"
}

check() {
    command_to_check="python"
    if ! command -v "$command_to_check" >/dev/null 2>&1; then
        echo "Error: $command_to_check is not installed or not in your PATH."
        exit 1
    fi

    if [ "$1" = "--clean" ]; then
        echo "Cleaning repo..."

        if [ -d "venv" ]; then
            echo "Removing venv..."
            rm -rf venv
        fi
    fi

    if [ -d "venv" ]; then
        echo "Skipping creating venv: it already exists"
    else
        echo -e "Creating venv with $(python --version)..."
        python -m venv venv
    fi

    echo -e "\nPlease activate the venv by running:\n"
    echo -e "source venv/bin/activate \n"
}

# Use a case statement to call the appropriate function
# Pass all args except first one (function name)
case "$1" in
    "setup")
        shift; setup "$@"
        ;;
    "add-client")
        shift; add_client "$@"
        ;;
    *)
        echo -e "Unknown command: $1\n"
        echo "Usage: $0 {setup|add-client}"
        exit 1
        ;;
esac

exit 0
