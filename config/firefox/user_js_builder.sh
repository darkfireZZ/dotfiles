set -e

cat="$coreutils/bin/cat"

$cat $arkenfox_user_js > $out

$cat >> $out << EOL

/* START: user-overrides.js
   These are cutomized overrides and are NOT part of the arkenfox user.js */
EOL

$cat "$overrides" >> $out

$cat >> $out << EOL
/* END: user-overrides.js */
EOL
