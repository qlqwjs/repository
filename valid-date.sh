#!/bin/bash

 
if [ "$#" -ne 3 ]; then

  echo "입력값 오류"

  exit 1

fi

month=$1

day=$2

year=$3

case "${month,,}" in

  jan|january|1) month="Jan" ;;

  feb|february|2) month="Feb" ;;

  mar|march|3) month="Mar" ;;

  apr|april|4) month="Apr" ;;

  may|5) month="May" ;;

  jun|june|6) month="Jun" ;;

  jul|july|7) month="Jul" ;;

  aug|august|8) month="Aug" ;;

  sep|september|9) month="Sep" ;;

  oct|october|10) month="Oct" ;;

  nov|november|11) month="Nov" ;;

  dec|december|12) month="Dec" ;;

  *)

    echo "월 형식 오류: $month는 유효하지 않습니다"

    exit 1

    ;;

esac



is_leap_year() {

  if (( $1 % 4 == 0 )); then

    if (( $1 % 100 != 0 )) || (( $1 % 400 == 0 )); then

      return 0

    fi

  fi

  return 1

}

 

case "$month" in

  Jan|Mar|May|Jul|Aug|Oct|Dec) max_days=31 ;;

  Apr|Jun|Sep|Nov) max_days=30 ;;

  Feb)

    if is_leap_year $year; then

      max_days=29

    else

      max_days=28

    fi

    ;;

esac

 

if (( day < 1 || day > max_days )); then

  echo "$month $day $year는 유효하지 않습니다"

  exit 1

fi

 

echo "${month^} $day $year"

 

exit 0
