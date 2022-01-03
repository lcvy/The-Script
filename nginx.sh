[root@bqh-118 scripts]# vim nginx.sh 
#!/bin/sh
#date:2019-04-21
#author:aゞ锦衣卫
#chkconfig:2345 28 62
#script function:Nginx service boot-up self-start script
[ -f /etc/init.d/functions ] && . /etc/init.d/functions   #公共函数，提供基本函数调用
pidfile=/application/nginx/logs/nginx.pid
nginx=/application/nginx/sbin/nginx
SHAN='\E[31;5m'
RES='\E[0m'
jiance() {                                                #定义jiance判断状态模块
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
        action "nginx is $1" /bin/true
        else
        action "nginx is $1" /bin/false
        fi
}
Start_nginx() {                                           #定义nginx服务启动模块
if [ -f $pidfile ];then
        echo "nginx is runing"
    else
        $nginx
        jiance start
fi
        return $RETVAL
}
Stop_nginx() {                                            #定义nginx服务停止模块
if [ ! -f $pidfile ];then
        echo "nginx is not runing!"     
    else
        $nginx -s stop
        jiance stop
fi
        return $RETVAL
}
Reload_nginx() {                                            #定义nginx服务平滑启动模块
if [ ! -f $pidfile ];then
        echo -e "${SHAN}Cat't open $pidfile ,no such file or directory!${RES}"
    else
        $nginx -s reload
        jiance reload
        return $RETVAL
fi
        return $RETVAL
}
case "$1" in                 #case交互式判断以上获取的值匹配以下哪些条件并给出相应的提示信息
        start)
          Start_nginx
                RETVAL=$?
        ;;
        stop)
          Stop_nginx
                RETVAL=$?
        ;;
        restart)
          Stop_nginx
          sleep 2
          Start_nginx
                RETVAL=$?
         ;;
        reload)
          Reload_nginx
                RETVAL=$?
        ;;
        *)
          echo -e "${SHAN}USAGE:$0 {start|stop|reload|restart}${RES}"
          exit 1
esac
exit $RETVAL
