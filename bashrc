##################################################################
# append to the end of the bash file, so you can have a wise cow #
##################################################################

btc() { echo "1 BTC = $(curl -s https://api.coindesk.com/v1/bpi/currentprice/$1.json | jq .bpi.\"$1\".rate | tr -d \"\"\") $1"; }

if [ -x /usr/bin/fortune -a -x /usr/bin/cowsay -a -x /usr/bin/lolcat ]; then
    fortune -a | cowsay | lolcat &&
    BTC="# "
    BTC+=$(btc USD)
    BTC+=" #"
    python -c "print( '#'*len('$BTC'))" | lolcat &&
    echo $BTC | lolcat  &&
    python -c "print( '#'*len('$BTC'))" | lolcat
fi

##########################
# unique update function #
##########################

function update() {
    sudo bash -c 'echo "Updating hosts file:" && 
                  echo "===========================" && 
                  curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts |
                  grep -E -v "(coinpot|cointiply|freebitco.in|bitfun.co|bonusbitcoin.co|moonbit.co.in|moonbitcoin.cash|moondash.co.in|moonliteco.in|moondoge.co.in|youtube|zerohedge)" > /etc/hosts && 
                  echo "0.0.0.0 9gag.com" >> /etc/hosts &&
                  echo "Finished"';
    echo "Updating packages:";
    echo "===========================" ;
    yay -Syu
}
