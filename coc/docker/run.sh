cd /var/www/html/coc
bash start_memcached.sh & 
php endAuctions.php & 
php startAuctions.php & 
php bnb_datafeed.php & 
php createPacks.php & 
php datafeed.php & # va in errore SQL /var/www/html/coc/datafeed.php:53
#php sendEmails.php & 
#php eurusdFeed.php & 
php manageGameWeeks.php & 
#php getMatches.php & 
bash start_job_manager.sh & # sbagliata path
#php mint.php & 
php createNFT.php & 
#php updateMatches.php & 
php updateTeamPlayers.php & 
bash start_auctions.sh &
bash start_market.sh &   # eliminata path verso php
bash start_pusher.sh &   # eliminata path verso php


# run a kill command for all of these commands 
# kill -9 $(ps aux | grep 'php endAuctions.php' | awk '{print $2}')