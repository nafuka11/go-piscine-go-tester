#!/bin/bash

# ----------------------------------------------------------------------------
# User settings
# ----------------------------------------------------------------------------
PROJECT_DIR="../go-piscine-go-00"

# ----------------------------------------------------------------------------
# Script settings
# ----------------------------------------------------------------------------
EX00_FILE="${PROJECT_DIR}/ex00/hello-world.go"
EX01_FILE="${PROJECT_DIR}/ex01/vars.go"
EX02_FILE="${PROJECT_DIR}/ex02/isEmailAddress.go"
EX03_FILE="${PROJECT_DIR}/ex03/createStairs.go"
EX04_FILE="${PROJECT_DIR}/ex04/calculation.go"
EX04_EXE="./calculation"
EX05_FILE="${PROJECT_DIR}/ex05/subSlice.go"
EX05_EXE="./subSlice"
EX06_FILE="${PROJECT_DIR}/ex06/echo42.go"
EX06_EXE="./echo42"

# color
RESET="\e[0m"
GREEN="\e[32m"
RED="\e[31m"
EX_COLOR="\e[1m"
CASE_COLOR="\e[4m"

# ----------------------------------------------------------------------------
print_result () {
	if [ $1 -eq 0 ]; then
		printf "${GREEN}OK${RESET}\n"
	else
		printf "${RED}KO${RESET}\n"
	fi
}

print_header () {
	printf "\n[${EX_COLOR}$1${RESET}]\n"
}

print_case () {
	printf "${CASE_COLOR}$@${RESET}\n"
}

# $1: name of test case
# $2: exXX/file.go
# $3: (optional) args
test () {
	print_case "${@:2}"
	go run $2 ${@:3} | cat -e > actual/$1.txt
	diff expected/$1.txt actual/$1.txt
	print_result $?
}

test_exe () {
	print_case "${@:2}"
	$2 ${@:3} 2>&1 | cat -e > actual/$1.txt
	diff expected/$1.txt actual/$1.txt
	print_result $?
}

check_gofmt () {
	result=`gofmt -d $1`
	echo -n "gofmt: "
	print_result $?
}

test_ex00 () {
	print_header ex00
	check_gofmt ${EX00_FILE}
	test ex00 ${EX00_FILE}
}

test_ex01 () {
	print_header ex01
	check_gofmt ${EX01_FILE}
	test ex01 ${EX01_FILE}
}

test_ex02 () {
	print_header ex02
	check_gofmt ${EX02_FILE}
	test ex02_no_arg ${EX02_FILE}
	test ex02_example ${EX02_FILE} marvin@student.42tokyo.jp abc@def.123
	test ex02_257 ${EX02_FILE} veeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeery_long_email_address@example.com
}

test_ex03 () {
	print_header ex03
	check_gofmt ${EX03_FILE}
	test ex03_1 ${EX03_FILE} 1
	test ex03_4 ${EX03_FILE} 4
	test ex03_10 ${EX03_FILE} 10
	test ex03_12 ${EX03_FILE} 12
}

test_ex04 () {
	print_header ex04
	check_gofmt ${EX04_FILE}
	go build ${EX04_FILE}
	test_exe ex04_no_arg ${EX04_EXE}
	test_exe ex04_1 ${EX04_EXE} 1
	test_exe ex04_12_4 ${EX04_EXE} 12 4
	test_exe ex04_a_4 ${EX04_EXE} a 4
	test_exe ex04_0_1 ${EX04_EXE} 0 1
	test_exe ex04_1_0 ${EX04_EXE} 1 0
}

test_ex05 () {
	print_header ex05
	check_gofmt ${EX05_FILE}
	go build ${EX05_FILE}
	${EX05_EXE}
}

test_ex06 () {
	print_header ex06
	check_gofmt ${EX06_FILE}
	go build ${EX06_FILE}
	test_exe ex06_example_1 ${EX06_EXE} 12 34 555
	test_exe ex06_example_2 ${EX06_EXE} -s / a bc def
	test_exe ex06_example_3 ${EX06_EXE} -s XXXXXXX 12 34 56789
	test_exe ex06_example_4 ${EX06_EXE} 12 34 555
	test_exe ex06_help ${EX06_EXE}  -help
	test_exe ex06_no_arg ${EX06_EXE}
}

main () {
	if [ $# -eq 0 ]; then
		test_ex00
		test_ex01
		test_ex02
		test_ex03
		test_ex04
		test_ex05
		test_ex06
		return
	fi
	for ex in $@; do
		case $ex in
			ex00) test_ex00
				;;
			ex01) test_ex01
				;;
			ex02) test_ex02
				;;
			ex03) test_ex03
				;;
			ex04) test_ex04
				;;
			ex05) test_ex05
				;;
			ex06) test_ex06
				;;
			* ) echo "Usage: $0 [ex00..06]"
				;;
		esac
	done
}

rm -f actual/*.txt ${EX04_EXE} ${EX05_EXE} ${EX06_EXE}
main $@
