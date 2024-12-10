#!/bin/bash
#

while [[ $# -gt 0 ]]; do
	case $1 in 
		*)
			POSITIONAL_ARGS+=("$1")
			shift
			;;
	esac
done

set -- "${POSITIONAL_ARGS[@]}"
echo $1
echo $2

# Solution Template
SOLUTION_NAME="Day${1}"
SOLUTION_FILE="lib/solutions/day${1}_solution.dart"

if [ -f "$SOLUTION_FILE" ]; then
	read -p "File [$SOLUTION_FILE] exists.  Overwrite? (yN): " answer
	case "$answer" in
		[yY]*)
			echo "Continuing..."
			;;
		*)
			echo "Exiting..."
			exit 1
			;;
	esac
fi

cp lib/solutions/template_solution.dart $SOLUTION_FILE
sed -i s/Template/$SOLUTION_NAME/ $SOLUTION_FILE
sed -i s/"int get day => 0;"/"int get day => $1;"/ $SOLUTION_FILE

# Page Template
PAGE_NAME="Day${1}"
PAGE_SOLUTION_FILENAME="day${1}"
PAGE_FILE="lib/pages/day_${1}.dart"

if [ -f "$PAGE_FILE" ]; then
	read -p "File [$PAGE_FILE] exists.  Overwrite? (yN): " answer
	case "$answer" in
		[yY]*)
			echo "Continuing..."
			;;
		*)
			echo "Exiting..."
			exit 1
			;;
	esac
fi

cp lib/pages/template.dart $PAGE_FILE
sed -i s/Template/$PAGE_NAME/g $PAGE_FILE
sed -i s/template/$PAGE_SOLUTION_FILENAME/g $PAGE_FILE
#
# Test Template
PAGE_NAME="Day${1}"
PAGE_SOLUTION_FILENAME="day${1}"
PAGE_FILE="test/solutions/day${1}_solution_test.dart"

if [ -f "$PAGE_FILE" ]; then
	read -p "File [$PAGE_FILE] exists.  Overwrite? (yN): " answer
	case "$answer" in
		[yY]*)
			echo "Continuing..."
			;;
		*)
			echo "Exiting..."
			exit 1
			;;
	esac
fi

cp test/solutions/template_solution_test.dart $PAGE_FILE
sed -i s/Template/$PAGE_NAME/g $PAGE_FILE
sed -i s/template/$PAGE_SOLUTION_FILENAME/g $PAGE_FILE

# Main update
WIDGET_PACKAGE_IMPORT="import 'package:adventofcode2024/pages/day_${1}.dart';";
WIDGET_INSTANTIATION="      const Day${1}Widget(),"
MAIN_FILE="lib/main.dart"
sed -i "s|\(// Add new import here\)|$WIDGET_PACKAGE_IMPORT\\n\1|g" $MAIN_FILE
sed -i "s|\(      // Add new day here\)|$WIDGET_INSTANTIATION\\n\1|g" $MAIN_FILE
