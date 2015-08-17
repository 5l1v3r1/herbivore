# Copyright 2015 Philipp Winter <phw@nymity.ch>
#
# This file is part of herbivore.
#
# exitmap is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# exitmap is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with exitmap.  If not, see <http://www.gnu.org/licenses/>.

script_dir=$(dirname "$0")
config_file="${script_dir}/../config.cfg"

# Try to parse config.cfg.
while IFS="= " read var val
do
    if [[ "$var" == \[*] ]]
    then
        section="$var"
    elif [[ $val ]]
    then
        declare "$var$section=$val"
    fi
done < "$config_file"

log() {
    msg="$1"
    printf "[$(date -u --rfc-3339=seconds)] ${msg}\n" | tee -a "$LogFile"
}

# Turn relative into absolute paths.
make_absolute() {

    argument="$1"

    if [[ "$argument" != /* ]]
    then
        argument="${script_dir}/${argument}"
    fi

    echo "$argument"
}

Consensuses=$(make_absolute "$Consensuses")
LogFile=$(make_absolute "$LogFile")
