##########################
# unique update function #
##########################

##########################
# special update command #
##########################
function update() {
    echo "Start"
    if [ -z "$1" ]; then
        echo "Normal mode"
        sudo bash -c 'rm /etc/hosts';
        sudo bash -c 'echo "Updating hosts file:" &&
                      echo "===========================" &&
                      curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts > /etc/hosts &&
                      echo "Finished"';
    elif [ "$1" == study ]; then
        echo "Study mode"
        sudo bash -c 'rm /etc/hosts';
        sudo bash -c 'echo "Updating hosts file:" &&
                      echo "===========================" &&
                      curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts > /etc/hosts &&
                      echo "0.0.0.0 9gag.com" >> /etc/hosts &&
                      echo "0.0.0.0 youtube.com" >> /etc/hosts &&
                      echo "0.0.0.0 facebook.com" >> /etc/hosts &&
                      echo "Finished"';
    else
        echo "Hosts file removed"
        sudo bash -c 'rm /etc/hosts';
    fi
    yay -Syu
}

####################################################
# terminal binance api							   #
####################################################

binance_api() { echo "$(curl -s https://api.binance.com/api/v1/ticker/price\?symbol=$1 | jq '.price' ) "; }

binance() {
    currency="# "
    price="$(binance_api $1)"
    currency="$1 = "+"${price:1:10}"
    currency+=" #"
    python -c "print( '#'*len('$currency'))" | lolcat
    echo $currency | lolcat
    python -c "print( '#'*len('$currency'))" | lolcat
}

binance "BTCUSDT"

####################################################
# shiny terminal wise cow 						   #
####################################################

if [ -x /usr/bin/fortune -a -x /usr/bin/cowsay -a -x /usr/bin/lolcat ]; then
    fortune -a | cowsay | lolcat
fi
