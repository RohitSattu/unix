# Code written by Rohit Sattu

#!/bin/sh

if [ $# -ne 2 ]; then
        echo "Usage: sh $0 filename major"
        exit 1
fi

if [ ! -f $1 ]; then
        echo "File $1 does not exist"
        exit 1
fi

if [ ! -s $1 ]; then
        echo "File $1 is empty"
        exit 1
fi

count=0
numofstds=0
avemid=0
avefin=0
while read lastname firstname midterm final major
do
        if [ $2 = $major ]; then
                count=`expr $count + 1`
                avemid=`expr $avemid + $midterm`
                avefin=`expr $avefin + $final`
                if [ $final -gt $midterm ]; then
                        numofstds=`expr $numofstds + 1`
                        echo "$lastname $firstname $midterm $final +"
                else
                        echo $lastname $firstname $midterm $final
                fi
        fi
done < $1 > $$.tmp.$$

sort -k1,1f -k2,2f $$.tmp.$$

if [ $count -eq 0 ]; then
        echo "There is no student whose major is ${2}."
else
        avemid=`expr $avemid / $count`
        avefin=`expr $avefin / $count`
        echo "The average midterm mark of $2 students is ${avemid}."
        echo "The average final mark of $2 students os ${avefin}."
        echo "$numofstds students have improved their mark."
fi

if [ -f $$.tmp.$$ ]; then
        rm $$.tmp.$$
fi

exit 0
