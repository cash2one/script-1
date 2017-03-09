# ~/.bashrc

export HOME=/data/home/monkeyhe
export LANG=en_US.utf8
export LC_CTYPE=zh_CN.utf8
export LC_ALL=en_US.utf8
#export PS1='\[\e]0;\u@\h:\w\a\[\e[32m\]\u:\w[$?]\$\[\e[0m\] '
export PS1='[\u@\h \W]\$'
export TAF_HOME=/usr/local/taf/
#export SVN_EDITOR=vim
export PATH=$PATH:~/bin:/sbin/:${TAF_HOME}/bin:/usr/local/support/bin:/usr/local/wsp
export TERM=xterm-256color
#export TERM=xterm
#export TERM=linux


if [[ -f $HOME/.dir_colors ]] ; then       
    eval $(dircolors -b $HOME/.dir_colors)  
fi
 [ -f "$HOME/.dir_colors" ] && eval `dircolors --sh $HOME/.dir_colors` &&　COLORS=$HOME/.dir_colors

#alias ls='ls -lF --color=auto'
#alias ll='ls -l --color=auto'

alias grep='grep --color'
alias vi=vim
#alias make='make -j8'
alias god="python ~/bin/login.py"


alias rm='trash'  
alias rl='trashlist'  
alias ur='undelfile'   


#替换rm指令移动文件到~/.trash/中   
trash()  
{  
    rmd="$HOME/.trash/$@"
    if [ -e $rmd -a -d $rmd ]; then
        echo -ne "\a\033[33m!!!exist the same dir!Force Delete?[y/n]\033[0m"  
        read confirm  
        if [ $confirm == 'y' -o $confirm == 'Y' ] ;then  
            /bin/rm -rf $rmd 2>/dev/null  
        else 
            echo -e "\a\033[33m rm $@ fail!Exist Same Dir!\033[0m"  
            return 1
        fi
    fi
    mv $@  ~/.trash/  
    if [ $? -eq 0 ]; then
        echo -e "\a\033[33m rm $@ success!\033[0m"  
    else
        echo -e "\a\033[33m rm $@ fail!\033[0m"  
    fi
    return 0
}  


#显示回收站中垃圾清单  
trashlist()  
{  
    echo -e "\033[32m==== Garbage Lists in ~/.trash/ ====\033[0m"  
    echo -e "\a\033[33m----Usage------\033[0m"  
    echo -e "\a\033[33m-1- Use 'cleartrash' to clear all garbages in ~/.trash!!!\033[0m"  
    echo -e "\a\033[33m-2- Use 'ur' to mv the file in garbages to current dir!!!\033[0m"  
    ls -al  ~/.trash  
}  


#找回回收站相应文件   
undelfile()  
{  
	mv -i ~/.trash/$@ ./  
}  

#清空回收站   
cleartrash()  
{  
	echo -ne "\a\033[33m!!!Clear all garbages in ~/.trash, Sure?[y/n]\033[0m"  
	read confirm  
	if [ $confirm == 'y' -o $confirm == 'Y' ] ;then  
		/bin/rm -rf ~/.trash/*  
		/bin/rm -rf ~/.trash/.* 2>/dev/null  
	fi 
}  

#清屏指令
function clr ()
{
    col=`tput cols`
    line=`tput lines`
    let sum=col*line
    tput cup 0 0
    printf "%${sum}s\n" " "
}


#-R:ctags循环生成子目录的tags
#–c++-kinds=+px :ctags记录c++文件中的函数声明和各种外部和前向声明
#–fields=+iaS :ctags要求描述的信息，其中i表示如果有继承，则标识出父类；a表示如果元素是类成员的话，要标明其调用权限（即是public还是private）；S表示如果是函数，则标识函数的signature。
#–extra=+q:强制要求ctags做如下操作—如果某个语法元素是类的一个成员，ctags默认会给其记录一行，可以要求ctags对同一个语法元素再记一行，这样可以保证在VIM中多个同名函数可以通过路径不同来区分。 

function settags()
{
    find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.jce"  -name "*.py" > src.files
    /usr/bin/ctags -R --c++-kinds=+px --fields=+iaS --extra=+q -L src.files
}

#History设置
# history 命令输出的记录数
export HISTSIZE=500
#.bash_history记录命令的数目
export HISTFILESIZE=10000
#历史文件名称
export HISTFILE=$HOME/.monkey_history
#剔除连续的重复命令
export HISTCONTROL=ignoredups 
#历史命令的格式
#export HISTTIMEFORMAT="[%y-%m-%d %H:%M:%S] "
export HISTTIMEFORMAT="%F %T "

