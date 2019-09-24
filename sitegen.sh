RED='\033[0;31m' #Red
LC='\033[0;36m' #Light Cyan 
GR='\033[1;32m' #GREEN
NC='\033[0m' # No Color
echo -e "${RED}/////////////////////////////////////
   _____ _ _        _____            
  / ____(_) |      / ____|           
 | (___  _| |_ ___| |  __  ___ _ __  
  \___ \| | __/ _ \ | |_ |/ _ \ '_ \ 
  ____) | | ||  __/ |__| |  __/ | | |
 |_____/|_|\__\___|\_____|\___|_| |_|
/////////////////////////////////////
Welcome To SiteGen, To Deploy a site please enter the
domain of the site you wish to deploy and implement 
nameserver set up.${NC}"
SITE_ROOT=/var/www/html

echo -e ${LC}
read -r -p "Enter your new site URL: " SITE_NAME
confirm() {
 read -r -p "${1:-Are you sure? [y/N]} " response
 case "$response" in
   [yY][eE][sS]|[yY])
     true
     ;;
   *)
     false
     ;;
 esac
}

confirm "Change root directory from /var/www/html/? [y/N]: " && echo "New site root: " && read SITE_ROOT

#Create the correct directories for the site.
mkdir $SITE_ROOT/$SITE_NAME $SITE_ROOT/$SITE_NAME/logs $SITE_ROOT/$SITE_NAME/public_html

#Copy over the demo site from Sitegen
cp index.php $SITE_ROOT/$SITE_NAME/public_html/

#Copy over nginx.conf file
cp nginx.conf $SITE_NAME.conf
find . -name "$SITE_NAME.conf" -exec sed -i -e "s/SITENAME/$SITE_NAME/g" {} \;
sudo mv $SITE_NAME.conf /etc/nginx/sites-available/$SITE_NAME

#Create symlink between site-available and sites-enabled
sudo ln -s /etc/nginx/sites-available/$SITE_NAME /etc/nginx/sites-enabled/$SITE_NAME

#Change nginx config owner to root
sudo chown root:root /etc/nginx/sites-available/$SITE_NAME

#If nginx set up is successful, restart nginx
sudo nginx -t && service nginx reload

#Completion message

echo -e "${RED}Site has been created at: ${GR}$SITE_NAME${NC}"
echo -e "${RED}Please ensure you domain is set up correctly${NC}"
