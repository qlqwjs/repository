#!/bin/bash


if [ $# -ne 2 ] ; then
  echo "Usage: $0 이름 전화번호"
  exit 1
fi

name=$1
phone_number=$2

if [[ ! $phone_number =~ ^[0-9]{2,3}-[0-9]{4}-[0-9]{4}$ ]] ; then
  echo "Invalid phone number format. Expected format: 000-0000-0000"
  exit 1
fi


local_number=$(echo $phone_number | cut -d "-" -f1)

case $local_number in
  02) region="서울" ;;
  031) region="경기" ;;
  032) region="인천" ;;
  051) region="부산" ;;
  053) region="대구" ;;
  042) region="대전" ;;
  *) region="기타" ;;
esac

full_entry="$name $phone_number $region"
echo "$full_entry"

phonebook_file="number.txt"

if [ ! -e $phonebook_file ] ; then
  touch $phonebook_file
fi

search_result=$(grep -w "$name" $phonebook_file)

if [ -n "$search_result" ] ; then
  while IFS= read -r line ; do
    stored_number=$(echo "$line" | awk '{print $2}')
    if [ "$phone_number" == "$stored_number" ] ; then
      echo "전화번호가 기존에 존재합니다."
      exit 0
    fi
  done <<< "$search_result"
fi

echo "$full_entry" >> $phonebook_file
sort -k1,1 -o $phonebook_file $phonebook_file
echo "새 전화번호가 추가되었습니다."
exit 0
