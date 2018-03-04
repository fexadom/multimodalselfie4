#! /bin/sh
#  /etc/init.d/Equil

FILE_PATH="/opt/recording/scripts/controller"

case "$1" in
    start) 
        echo "Starting the Program..."       
        $FILE_PATH/client 127.0.0.1 9001 start  
        echo "The Program has started."
    ;;
    stop)
        echo "Stopping the $DESC..."
       
        $FILE_PATH/client 127.0.0.1 9001 stop      
       
        echo "The $DESC has stopped."
    ;;
    
    *)
    echo "Usage: /etc/init.d/$NAME {start|stop}" >&2
    exit 3
    ;;
esac