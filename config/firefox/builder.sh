set -e

cat="$coreutils/bin/cat"

user_js="$out/user.js"

$coreutils/bin/mkdir $out

$cat $arkenfox_user_js > $user_js

$cat >> $user_js << EOL

/* START: user-overrides.js
   These are cutomized overrides and are NOT part of the arkenfox user.js */
EOL

$cat "$src/user-overrides.js" >> $user_js

$cat >> $user_js << EOL
/* END: user-overrides.js */
EOL
