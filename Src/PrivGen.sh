
PrivGenerator(){
     read -r -a users<<< $1
     read -r -a hosts <<< $2

     schema="default"
     tanggal=$(date +%Y_%m_%d_%h_%s)
     name_folder_output="Output"
     
     location=$(pwd)
     location=${location%/*}
     location=$location/$name_folder_output

          for i in $(seq 0 $(( ${#users[@]} -1 )));do
               tmp_filename="${users[$i]}_$tanggal.txt"

               if [ -e $location/$tmp_filename ];then
                         echo "file found"
                    else
                         touch $location/$tmp_filename
               fi

               for j in $(seq 0 $(( ${#hosts[@]} -1 )));do
                    echo "create user '${users[$i]}'@'${hosts[$j]}' with 'mysql_native_password' by 'password'" >> "$location/$tmp_filename"
                    echo -e "grant all privileges on $schema.* to '${users[$i]}'@'${hosts[$j]}'\n" >> $location/$tmp_filename
                    if [ ${#hosts[@]} -eq 1 ] && [ $i -eq 0 ];then
                         tmp_hosts+="'${hosts[$j]}'"
                    elif [ $j -eq $(( ${#hosts[@]} -1 )) ] && [ $i -eq 0 ];then
                         tmp_hosts+="'${hosts[$j]}'"
                         break
                    fi
                    if [ $i -eq 0 ];then
                         tmp_hosts+="'${hosts[$j]}',"
                    fi
               done
               
               echo $separator >> $location/$tmp_filename
               
               if [ ${#users[@]} -eq 1 ];then
                    tmp_user+="'${users[$i]}'"
               elif [ $i -eq $(( ${#users[@]} -1 )) ];then
                    tmp_user+="'${users[$i]}'"
                    break
               fi
               tmp_user+="'${users[$i]}',"

          done

          echo -e "\nselect user, hosts, authentication_string from mysql.user where user in ($tmp_user) and hosts in ($tmp_hosts) " >> "$location/check_$tanggal.txt"
          echo -e "\n\nselect user, hosts, authentication_string from mysql.user where user in ($tmp_user) " >> "$location/check_$tanggal.txt"
     
}

