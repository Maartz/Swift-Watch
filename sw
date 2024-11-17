#!/bin/bash

# Function to display global help
global_help() {
  cat <<EOF
Usage: sw [OPTION]

Swift Watch (sw) is a utility that automatically watches your Swift files and runs the specified command when changes are detected.

Options:
  --build       Watch for file changes and rebuild the project.
  --test        Watch for file changes and run the tests.
  --run         Watch for file changes and run the Swift project.
  --analyze     Watch for file changes and perform static analysis.
  --help        Show help for the command or globally.

Examples:
  sw --build     # Watches for changes and rebuilds the project.
  sw --test      # Watches for changes and runs the tests.
  sw --run       # Watches for changes and runs the project.
  sw --analyze   # Watches for changes and performs static analysis.
EOF
}

# Function to display help for each command
command_help() {
  case "$1" in
  --build)
    cat <<EOF
Usage: sw --build

Watches for changes in your Swift files and automatically rebuilds the project.

Examples:
  sw --build     # Watches for changes and rebuilds the project.
EOF
    ;;
  --test)
    cat <<EOF
Usage: sw --test

Watches for changes in your Swift files and automatically runs the test suite.

Examples:
  sw --test      # Watches for changes and runs the tests.
EOF
    ;;
  --run)
    cat <<EOF
Usage: sw --run

Watches for changes in your Swift files and automatically runs the project.

Examples:
  sw --run       # Watches for changes and runs the project.
EOF
    ;;
  --analyze)
    cat <<EOF
Usage: sw --analyze

Watches for changes in your Swift files and performs static analysis on the project.

Examples:
  sw --analyze   # Watches for changes and performs static analysis.
EOF
    ;;
  *)
    echo "Invalid command for help: $1"
    global_help
    ;;
  esac
}

# Check if there are no arguments provided
if [ $# -eq 0 ]; then
  global_help
  exit 1
fi

# Function to watch and execute Swift commands
watch_and_execute() {
  # Use `entr` to watch for file changes and execute commands
  # Thanks gutenberg, many thanks, for real this time ;)
  find . -name "*.swift" | entr -r bash -c "clear && printf '\033c'; swift $*"
}

# Parse arguments
case "$1" in
--build)
  echo "Watching for changes and building..."
  watch_and_execute build
  ;;
--test)
  echo "Watching for changes and testing..."
  watch_and_execute test
  ;;
--run)
  echo "Watching for changes and running..."
  watch_and_execute run
  ;;
--analyze)
  echo "Watching for changes and analyzing..."
  watch_and_execute build --analyze
  ;;
--help)
  if [ $# -eq 2 ]; then
    command_help "$2"
  else
    global_help
  fi
  ;;
*)
  echo "Invalid option: $1"
  global_help
  exit 1
  ;;
esac
