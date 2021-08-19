#!/bin/bash

sudo ln -sf /home/kaumi/findcat.sh /usr/bin/findcat ; reset ;

if (( ${#@} == 3 )) ;
then

    end=$1 ; matches=$2 ; next=$3

    files=`find * | grep .$end`

    for file in $files ;
    do
           lines=`cat "$file"`
            numb=0
            find=0
        for_next=0

        while read line ;
        do
            numb=$((numb+1))
             
            for match in $matches ; # pipe style !!
            do
                 out=`echo "$line" | grep "$match"`
                 
                 if (( ${#out} == 0 )) ; then break ; fi
            done
            
            if (( ${#out} > 0 && ( ! $find == 1 ) )) ;
            then
                 echo ''
                 echo "file: $file"
                 find=1
            fi

            if (( ( $find == 1 ) && $for_next < $next )) ;
            then
                 out=$line
                
                 for_next=$((for_next+1))

                 echo "$numb : $out"
            else
                     find=0
                 for_next=0
            fi

        done < $file
    done
    
    echo ''
else
    echo ''
    echo 'arg1: end of file'
    echo 'arg2: match string list'
    echo 'arg3: lines to read'
    echo ''
fi
