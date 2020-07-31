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

####################################################
# shiny terminal wise cow and terminal binance api #
####################################################

binance_api() { echo "$(curl -s https://api.binance.com/api/v1/ticker/price\?symbol=$1 | jq '.price' ) "; }

binance() {
    currency="# "
    price="$(binance_api $1)"
    currency="$1 = "+"${price:1:8}"
    currency+=" #"
    python -c "print( '#'*len('$currency'))" | lolcat
    echo $currency | lolcat
    python -c "print( '#'*len('$currency'))" | lolcat
}

export HISTFILESIZE=10000
PROMPT_COMMAND='history -a'

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

if [ -x /usr/bin/fortune -a -x /usr/bin/cowsay -a -x /usr/bin/lolcat ]; then
    binance "BTCUSDT"
    fortune -a | cowsay | lolcat
fi
