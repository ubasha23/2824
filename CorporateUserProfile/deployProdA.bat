set FMW_HOME=C:\oracle\Middleware
set ANT_HOME=%FMW_HOME%\modules\org.apache.ant_1.7.1
set PATH=%ANT_HOME%\bin;%PATH%
set JAVA_HOME=%FMW_HOME%\jdk160_18
set CLASSPATH=%FMW_HOME%/wlserver_10.3/server/lib/weblogic.jar;%FMW_HOME%/Oracle_OSB1/lib/alsb.jar;%FMW_HOME%/Oracle_OSB1/modules/com.bea.common.configfwk_1.3.0.0.jar 

set WLS_HOME="c:\oracle\Middleware\wlserver_10.3"

call %WLS_HOME%\common\bin\wlst.cmd deployWar.py

call %WLS_HOME%\common\bin\wlst.cmd import.py importProdA.properties