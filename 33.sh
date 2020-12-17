#!/bin/bash

# response=$(curl https://api.github.com/repos/VivekRajyaguru/QuotesGenerator/compare/60fc75a008c83adb1ee73fce5b9bc0a2b87765d5...a658f46da8cc73af13409139a0c82007d312c105)
total_commit=()
# echo "" > test.json
# echo $response >> test.json

arr=()
array=()


# echo ${scriptarr[@]}
# This is total commits of json that we got from hit the jira command
total_commit=$(cat test1.json | jq '.total_commits')
counter=0
    while [ $counter -lt $total_commit ]
    do
    temp2=();
    temp3=();
    # The commit_message is that we extract the message from that jira json
        commit_message=$(cat test1.json | jq --arg i "$counter" '.commits[$i | tonumber].commit.message')
        temp2=`echo $commit_message`
        # This is the thing that we got vlaue into array 
        arr[${#arr[@]}]+=${temp2:1}
        counter=`expr $counter + 1`
    done
    temp=1
#  This readarray that we got the \r\n extract the value to it 
readarray -d '\r\n\r\n' -t strarr <<< "$temp2"
# echo ${strarr[@]}
# 
        for (( j=0; j < ${#strarr[*]}; j++))
        do
        a="${strarr[j]//'*'}"
        b="${a//r}"
        c="${b//n}"
        # echo $cChecks
        aa=`echo $c | awk '{print $1;}'`
        # echo $aa
        STR=$aa
        SUB='EDE'
        if [[ "$STR" == *"$SUB"* ]]; then
        array[${#array[@]}]+=${aa}
        fi
        uniq=($(printf "%s\n" "${array[@]}" | sort  | uniq -c | sort -rnk1 | awk '{ print $2 }'))
        done 

vada=($(echo ${uniq[@]} | tr [:] '\n' | awk '!uniq[$0]++')) 
# echo $vada  | sort -du 
# 
# 
for k in ${vada[@]};
do

    value=$(echo $k) 
    # test=$(echo $value | sort -du)
    # echo $value

response=$(curl -v https://rheemiot.atlassian.net/rest/api/2/issue/$value --user vivek.rajyaguru@volansys.com:KJOXCXVval7odX6Lsled8C80)

total_commit=()
echo "" > commit.json
echo $response > commit.json
echo $response

arr=()
counter=0
# while [ $counter -lt 0 1 ]
    for counter in 0:
    do
    temp2=();
    temp3=();
    # 
    key=$(cat commit.json |tr '\r\n' ' ' | jq '.key')
    summary=$(cat commit.json |tr '\r\n' ' ' | jq '.fields.summary')
    description=$(cat commit.json |tr '\r\n' ' ' | jq '.fields.description')
    # echo $description
    # The 
    # 
    arr[${#arr[@]}]+=${key:1:-1}
    arr[${#arr[@]}]+=${summary:1:-1}
    arr[${#arr[@]}]+=${description:1:-1}

    # echo ${description:1:-1}
    echo "- ${key:1:-1}: ${summary:1:-1}" >> readmei.md
    
    if [[ "$description" != "null" ]]
    then
        echo "    - ${description:1:-1}" >> readmei.md
    fi
    sed -i -e 's/\\r\\n/\
    /g' readmei.md
    sed -i -e 's/\\n/\
    /g' readmei.md
    # sed 's/\\r\n/\/g' readmei.md
    # 
    done 
done 
value=`cat readmei.md`
echo "$value"
git add .
git commit -m ""
git push
