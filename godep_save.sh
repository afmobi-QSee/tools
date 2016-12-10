#!/bin/bash

#解决godep save的问题
#项目拉下来后如果不能够如果引入新包后不能正确godep save
#把gopath目录下的本地目录全部删掉，然后把文件考到项目文件夹下执行

function f_save(){
	godep save
	if [ $? -eq 1 ];then
		result=$(godep save 2>&1)
		if [[ $result =~ "not found" ]];then
			after=${result##*'('}
			package_name=${after%%')'*}
            echo "go get ${package_name}"
			go get ${package_name}
			if [ $? -eq 1 ];then
				lib_name=${package_name##*'x/'}
                echo "go get github.com/golang/${lib_name}"
				go get github.com/golang/${lib_name}
				cp github.com/golang/${lib_name} golang.org/x/ -r
			else
				f_save
			fi
		else
			echo save false
		fi
	fi
}

f_save
