#!/bin/sh
file="src/esperanto_town_names"

# this expects the format nmlc optimizes to
make optimize

realw_start=$(grep -n "real_world_1){" "$file.nml" | awk -F: '{print $1}')
names_start=$(grep -n "names){" "$file.nml" | awk -F: '{print $1}')
realw_end=$((names_start-4))
saints_start=$(grep -n "saints){" "$file.nml" | awk -F: '{print $1}')
names_end=$((saints_start-4))
adj_start=$(grep -n "adjective){" "$file.nml" | awk -F: '{print $1}')
saints_end=$((adj_start-4))
root_start=$(grep -n "(root){" "$file.nml" | awk -F: '{print $1}')
adj_end=$((root_start-4))
rootsuf_start=$(grep -n "root_for_suffix){" "$file.nml" | awk -F: '{print $1}')
root_end=$((rootsuf_start-4))
comproot_start=$(grep -n "compound_root){" "$file.nml" | awk -F: '{print $1}')
rootsuf_end=$((comproot_start-4))
comproot_end=$(grep -n "(suffix){" "$file.nml" | awk -F: '{print $1}')
comproot_end=$((comproot_end - 4))


eof=$(wc -l "$file.nml" | awk -F' ' '{print $1}')

# grf header
head -n $((realw_start + 1)) "$file.nml" > "$file.sorted.nml"
# always values and }}town_names(xx){{ alternating
sed -n "$((realw_start+2)),${realw_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((realw_end+1)),$((names_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((names_start+2)),${names_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((names_end+1)),$((saints_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((saints_start+2)),${saints_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((saints_end+1)),$((adj_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((adj_start+2)),${adj_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((adj_end+1)),$((root_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((root_start+2)),${root_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((root_end+1)),$((rootsuf_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((rootsuf_start+2)),${rootsuf_end}p" "$file.nml" | sort >> "$file.sorted.nml"
sed -n "$((rootsuf_end+1)),$((comproot_start+1))p" "$file.nml" >> "$file.sorted.nml"

sed -n "$((comproot_start+2)),${comproot_end}p" "$file.nml" | sort >> "$file.sorted.nml"
#echo "===" >> "$file.sorted.nml"

tail -n $((eof - (comproot_end) )) "$file.nml" >> "$file.sorted.nml"

mv "$file.sorted.nml" "$file.nml"